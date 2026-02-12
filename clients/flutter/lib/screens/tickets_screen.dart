import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';

import 'package:logger/logger.dart';

import 'package:omsa_demo_app/models/ticket_wallet_models.dart';
import 'package:omsa_demo_app/services/purchase_flow_service.dart';
import 'package:omsa_demo_app/services/ticket_wallet_service.dart';
import 'package:omsa_demo_app/theme/wayfare_tokens.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  static final Logger _logger = Logger();
  bool _isLoading = true;
  bool _isRefreshing = false;
  String? _error;
  List<TicketPackage> _packages = const [];

  @override
  void initState() {
    super.initState();
    _loadPackages(refreshFromBackend: true, isInitialLoad: true);
  }

  Future<void> _loadPackages({
    required bool refreshFromBackend,
    bool isInitialLoad = false,
  }) async {
    if (mounted) {
      setState(() {
        if (isInitialLoad) _isLoading = true;
        _error = null;
      });
    }

    try {
      final packages = await TicketWalletService.getPackages();
      if (!mounted) return;
      setState(() {
        _packages = packages;
        _isLoading = false;
      });

      if (!refreshFromBackend || packages.isEmpty) {
        return;
      }

      if (!mounted) return;
      setState(() {
        _isRefreshing = true;
      });

      for (final package in packages) {
        try {
          final documents = await PurchaseFlowService.fetchTravelDocuments(
            packageId: package.packageId,
          );
          await TicketWalletService.upsertPackage(
            packageId: package.packageId,
            purchasedAt: package.purchasedAt,
            documents: documents,
          );
        } catch (_) {
          // Keep stale package data when backend refresh fails.
        }
      }

      final refreshedPackages = await TicketWalletService.getPackages();
      if (!mounted) return;
      setState(() {
        _packages = refreshedPackages;
      });
    } catch (error, stackTrace) {
      _logger.w(
        'Failed to load ticket packages',
        error: error,
        stackTrace: stackTrace,
      );
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load your tickets. Please try again.';
        _isLoading = false;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isRefreshing = false;
        });
      }
    }
  }

  String _formatAmount(double amount, String currencyCode) {
    return '${amount.toStringAsFixed(2)} $currencyCode';
  }

  String _formatDayMonth(DateTime value) {
    final local = value.toLocal();
    final month = local.month.toString().padLeft(2, '0');
    final day = local.day.toString().padLeft(2, '0');
    return '$day.$month';
  }

  String _formatTime(DateTime value) {
    final local = value.toLocal();
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Color _surfacePrimary(BuildContext context) {
    final isLight = Theme.brightnessOf(context) == Brightness.light;
    return isLight
        ? BaseLightTokens.frameSubdued
        : context.tokens.frameElevated;
  }

  Color _packageCardBackground(BuildContext context) {
    final isLight = Theme.brightnessOf(context) == Brightness.light;
    return isLight ? Colors.transparent : context.tokens.frameTint;
  }

  Color _packageCardBorder(BuildContext context) {
    final isLight = Theme.brightnessOf(context) == Brightness.light;
    return isLight ? context.tokens.strokeSubdued : context.tokens.frameTint;
  }

  double _packageCardBorderRadius() {
    return 4;
  }

  OmsaBadgeVariant _statusVariant(TicketPackage package) {
    final now = DateTime.now();
    final explicitStatus = package.status?.toUpperCase() ?? '';
    if (explicitStatus == 'CANCELLED' || explicitStatus == 'FAILED') {
      return OmsaBadgeVariant.negative;
    }
    final validUntil = package.validUntil;
    if (validUntil != null && validUntil.isBefore(now)) {
      return OmsaBadgeVariant.warning;
    }
    return OmsaBadgeVariant.success;
  }

  String _statusLabel(TicketPackage package) {
    final now = DateTime.now();
    final explicitStatus = package.status?.toUpperCase() ?? '';
    if (explicitStatus == 'CANCELLED') return 'Cancelled';
    if (explicitStatus == 'FAILED') return 'Failed';
    final validUntil = package.validUntil;
    if (validUntil != null && validUntil.isBefore(now)) {
      return 'Expired';
    }
    return 'Active';
  }

  @override
  Widget build(BuildContext context) {
    final pageBackground = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: pageBackground,
      body: SafeArea(
        bottom: false,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _packages.isEmpty
            ? _buildEmptyState(context)
            : RefreshIndicator(
                onRefresh: () => _loadPackages(refreshFromBackend: true),
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  itemCount: _packages.length + 1,
                  separatorBuilder: (_, index) =>
                      SizedBox(height: index == 0 ? 16 : 12),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildPageHeader(context);
                    }
                    final package = _packages[index - 1];
                    return _buildPackageCard(context, package);
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    final totalDocuments = _packages.fold<int>(
      0,
      (sum, package) => sum + package.documents.length,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            OmsaBadge(variant: OmsaBadgeVariant.information, child: "Demo"),
            const Spacer(),
            IconButton(
              onPressed: _isRefreshing
                  ? null
                  : () => _loadPackages(refreshFromBackend: true),
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh tickets',
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Tickets',
          style: AppTypography.headingExtraLarge2.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${_packages.length} package${_packages.length == 1 ? '' : 's'} · $totalDocuments document${totalDocuments == 1 ? '' : 's'}',
          style: AppTypography.textSmall.copyWith(
            color: context.tokens.textSubdued,
          ),
        ),
        if (_isRefreshing) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 8),
              Text(
                'Refreshing from server...',
                style: AppTypography.textSmall.copyWith(
                  color: context.tokens.textSubdued,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildPackageCard(BuildContext context, TicketPackage package) {
    final primaryDocument = package.primaryDocument;
    final packageName = package.packageName?.trim() ?? '';
    final packageDescription = package.packageDescription?.trim() ?? '';
    final fallbackType =
        primaryDocument?.travelDocumentType ?? 'Travel package';
    final validFrom = package.validFrom;
    final validUntil = package.validUntil;
    final amountLabel =
        package.totalAmount != null &&
            package.currencyCode != null &&
            package.currencyCode!.isNotEmpty
        ? _formatAmount(package.totalAmount!, package.currencyCode!)
        : null;
    final footerDate = validUntil ?? validFrom ?? package.purchasedAt;
    final infoParts = <String>[
      '${package.documents.length} document${package.documents.length == 1 ? '' : 's'}',
      if (amountLabel != null) amountLabel,
    ];
    final fallbackSubtitle = infoParts.join(' · ');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(_packageCardBorderRadius()),
        onTap: () {
          final encoded = Uri.encodeComponent(package.packageId);
          context.push('/ticket/$encoded');
        },
        child: Ink(
          decoration: BoxDecoration(
            color: _packageCardBackground(context),
            borderRadius: BorderRadius.circular(_packageCardBorderRadius()),
            border: Border.all(color: _packageCardBorder(context), width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            packageName.isNotEmpty ? packageName : fallbackType,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.textLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OmsaStatusBadge(
                          variant: _statusVariant(package),
                          child: Text(_statusLabel(package)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      packageDescription.isNotEmpty
                          ? packageDescription
                          : fallbackSubtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.textMedium.copyWith(
                        color: context.tokens.textSubdued,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      package.packageId,
                      style: AppTypography.textSmall.copyWith(
                        color: context.tokens.textSubdued,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 2, color: _packageCardBorder(context)),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 18,
                      color: context.tokens.textAccent,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatDayMonth(footerDate),
                      style: AppTypography.textSmall.copyWith(
                        color: context.tokens.textAccent,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 18,
                      color: context.tokens.textAccent,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatTime(footerDate),
                      style: AppTypography.textSmall.copyWith(
                        color: context.tokens.textAccent,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward,
                      color: context.wayfareTokens.brandPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: OmsaCard(
          variant: OmsaCardVariant.filled,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _surfacePrimary(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OmsaIcons.ValidTicket(
                  size: 64,
                  color: context.tokens.textSubdued,
                ),
                const SizedBox(height: 16),
                Text('No tickets yet', style: AppTypography.headlineLarge),
                const SizedBox(height: 8),
                Text(
                  _error ?? 'Tickets you purchase will appear here.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(
                    color: context.tokens.textSubdued,
                  ),
                ),
                const SizedBox(height: 16),
                OmsaButton(
                  onPressed: () => _loadPackages(refreshFromBackend: true),
                  width: OmsaButtonWidth.fluid,
                  child: const Text('Refresh'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

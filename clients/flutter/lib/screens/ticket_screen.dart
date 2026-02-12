import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:omsa_demo_app/models/purchase_models.dart';
import 'package:omsa_demo_app/services/purchase_flow_service.dart';
import 'package:omsa_demo_app/services/ticket_wallet_service.dart';

class TicketScreen extends StatefulWidget {
  final String packageId;

  const TicketScreen({super.key, required this.packageId});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  bool _isLoading = true;
  String? _error;
  List<TravelDocument> _documents = const [];
  int _currentPageIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadDocuments() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final preferredDocumentId = _currentDocument?.id;
    final cachedPackage = await TicketWalletService.getPackage(
      widget.packageId,
    );
    if (cachedPackage != null && cachedPackage.documents.isNotEmpty) {
      if (!mounted) return;
      _applyDocuments(
        cachedPackage.documents,
        preferredDocumentId: preferredDocumentId,
      );
    }

    try {
      final documents = await PurchaseFlowService.fetchTravelDocuments(
        packageId: widget.packageId,
      );
      await TicketWalletService.upsertPackage(
        packageId: widget.packageId,
        documents: documents,
      );
      if (!mounted) return;
      _applyDocuments(
        documents,
        preferredDocumentId: _currentDocument?.id ?? preferredDocumentId,
      );
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        if (_documents.isEmpty) {
          _error = 'Failed to load travel documents: $error';
        }
      });
    }
  }

  TravelDocument? get _currentDocument {
    if (_documents.isEmpty) {
      return null;
    }
    if (_currentPageIndex < 0 || _currentPageIndex >= _documents.length) {
      return _documents.first;
    }
    return _documents[_currentPageIndex];
  }

  int _primaryDocumentIndex(List<TravelDocument> documents) {
    if (documents.isEmpty) {
      return 0;
    }
    for (var i = 0; i < documents.length; i++) {
      if (documents[i].isQrCode) {
        return i;
      }
    }
    return 0;
  }

  int _resolveDocumentIndex({
    required List<TravelDocument> documents,
    String? preferredDocumentId,
  }) {
    if (documents.isEmpty) {
      return 0;
    }
    if (preferredDocumentId != null && preferredDocumentId.isNotEmpty) {
      for (var i = 0; i < documents.length; i++) {
        if (documents[i].id == preferredDocumentId) {
          return i;
        }
      }
    }
    return _primaryDocumentIndex(documents);
  }

  void _applyDocuments(
    List<TravelDocument> documents, {
    String? preferredDocumentId,
  }) {
    final nextIndex = _resolveDocumentIndex(
      documents: documents,
      preferredDocumentId: preferredDocumentId,
    );

    setState(() {
      _documents = documents;
      _currentPageIndex = nextIndex;
      _isLoading = false;
    });

    if (documents.isEmpty) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_pageController.hasClients) {
        return;
      }
      final activePage = (_pageController.page ?? _pageController.initialPage)
          .round();
      if (activePage != nextIndex) {
        _pageController.jumpToPage(nextIndex);
      }
    });
  }

  String _formatDate(DateTime value) {
    final local = value.toLocal();
    final month = local.month.toString().padLeft(2, '0');
    final day = local.day.toString().padLeft(2, '0');
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$day.$month.${local.year} $hour:$minute';
  }

  OmsaBadgeVariant _validityVariant(TravelDocument document) {
    final now = DateTime.now();
    final end = document.endValidity;
    if (end != null && end.isBefore(now)) {
      return OmsaBadgeVariant.warning;
    }
    return OmsaBadgeVariant.success;
  }

  String _validityLabel(TravelDocument document) {
    final now = DateTime.now();
    final end = document.endValidity;
    if (end != null && end.isBefore(now)) {
      return 'Expired';
    }
    return 'Valid';
  }

  Color _surfacePrimary(BuildContext context) {
    final isLight = Theme.brightnessOf(context) == Brightness.light;
    return isLight ? BaseLightTokens.frameTint : context.tokens.frameElevated;
  }

  Color _surfaceSecondary(BuildContext context) {
    final isLight = Theme.brightnessOf(context) == Brightness.light;
    return isLight ? BaseLightTokens.frameTint : context.tokens.frameSubdued;
  }

  @override
  Widget build(BuildContext context) {
    final selected = _currentDocument;
    final pageBackground = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Ticket'),
        backgroundColor: pageBackground,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: _isLoading ? null : _loadDocuments,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null && _documents.isEmpty
          ? _buildErrorState(context)
          : _documents.isEmpty
          ? _buildEmptyState(context)
          : RefreshIndicator(
              onRefresh: _loadDocuments,
              child: ListView(
                padding: const EdgeInsets.only(bottom: 20),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: _buildHeaderCard(context, selected!),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.swipe,
                          size: 18,
                          color: context.tokens.textSubdued,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Swipe to view all travel documents',
                          style: AppTypography.textSmall.copyWith(
                            color: context.tokens.textSubdued,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 452,
                    child: PageView.builder(
                      controller: _pageController,
                      padEnds: false,
                      clipBehavior: Clip.none,
                      itemCount: _documents.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final document = _documents[index];
                        final isActive = index == _currentPageIndex;
                        final isFirst = index == 0;
                        final isLast = index == _documents.length - 1;
                        return Padding(
                          padding: EdgeInsets.only(
                            top: 4,
                            bottom: 8,
                            left: isFirst ? 16 : 0,
                            right: isLast ? 16 : 8,
                          ),
                          child: _TravelDocumentPage(
                            document: document,
                            index: index,
                            totalCount: _documents.length,
                            isActive: isActive,
                            surfaceColor: _surfaceSecondary(context),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildPageIndicator(context),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildDocumentDetailsCard(context, selected),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: OmsaCard(
                        variant: OmsaCardVariant.filled,
                        margin: EdgeInsets.zero,
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          _error!,
                          style: AppTypography.textSmall.copyWith(
                            color: context.tokens.textSubdued,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, TravelDocument selected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfacePrimary(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Package ${widget.packageId}',
            style: AppTypography.textSmall.copyWith(
              color: context.tokens.textSubdued,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  selected.travelDocumentType.isNotEmpty
                      ? selected.travelDocumentType
                      : 'Travel document',
                  style: AppTypography.textLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OmsaStatusBadge(
                variant: _validityVariant(selected),
                child: Text(_validityLabel(selected)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_documents.length, (index) {
        final active = index == _currentPageIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 18 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: active
                ? context.tokens.shapeHighlight
                : context.tokens.shapeDisabled,
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }

  Widget _buildDocumentDetailsCard(
    BuildContext context,
    TravelDocument? selected,
  ) {
    if (selected == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfacePrimary(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Document details',
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OmsaTag(
                compact: true,
                leadingIcon: const Icon(Icons.badge, size: 14),
                child: Text(selected.travelDocumentType),
              ),
              OmsaTag(
                compact: true,
                leadingIcon: const Icon(Icons.description, size: 14),
                child: Text(selected.contentType),
              ),
              if (selected.startValidity != null)
                OmsaTag(
                  compact: true,
                  leadingIcon: const Icon(Icons.event_available, size: 14),
                  child: Text('From ${_formatDate(selected.startValidity!)}'),
                ),
              if (selected.endValidity != null)
                OmsaTag(
                  compact: true,
                  leadingIcon: const Icon(Icons.schedule, size: 14),
                  child: Text('Until ${_formatDate(selected.endValidity!)}'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
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
              Icon(
                Icons.error_outline,
                size: 56,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 12),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: AppTypography.textMedium,
              ),
              const SizedBox(height: 16),
              OmsaButton(
                onPressed: _loadDocuments,
                width: OmsaButtonWidth.fluid,
                child: const Text('Retry'),
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
              Icon(
                Icons.confirmation_number_outlined,
                size: 56,
                color: context.tokens.textSubdued,
              ),
              const SizedBox(height: 12),
              Text(
                'No travel documents available',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Try refreshing again.',
                style: AppTypography.textMedium.copyWith(
                  color: context.tokens.textSubdued,
                ),
              ),
              const SizedBox(height: 16),
              OmsaButton(
                onPressed: _loadDocuments,
                width: OmsaButtonWidth.fluid,
                child: const Text('Refresh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TravelDocumentPage extends StatelessWidget {
  final TravelDocument document;
  final int index;
  final int totalCount;
  final bool isActive;
  final Color surfaceColor;

  const _TravelDocumentPage({
    required this.document,
    required this.index,
    required this.totalCount,
    required this.isActive,
    required this.surfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      scale: isActive ? 1 : 0.97,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    document.travelDocumentType.isNotEmpty
                        ? document.travelDocumentType
                        : 'Document',
                    style: AppTypography.textLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                OmsaTag(compact: true, child: Text('${index + 1}/$totalCount')),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Center(
                child: _TicketVisual(
                  document: document,
                  fallbackTypeLabel: document.travelDocumentType,
                  visualSize: 250,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketVisual extends StatelessWidget {
  final TravelDocument? document;
  final String fallbackTypeLabel;
  final double visualSize;

  const _TicketVisual({
    required this.document,
    required this.fallbackTypeLabel,
    required this.visualSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (document == null) {
      return _placeholder(context, fallbackTypeLabel);
    }

    if (document!.isDailyAnimation && document!.animation != null) {
      return _DailyAnimationTicket(
        animation: document!.animation!,
        size: visualSize,
        fallbackBackgroundColor: context.tokens.frameSubdued,
      );
    }

    if (document!.isQrCode && document!.qrPayloadString != null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: QrImageView(
          data: document!.qrPayloadString!,
          version: QrVersions.auto,
          size: visualSize,
          backgroundColor: Colors.white,
          eyeStyle: const QrEyeStyle(
            eyeShape: QrEyeShape.square,
            color: Colors.black,
          ),
          dataModuleStyle: const QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.square,
            color: Colors.black,
          ),
        ),
      );
    }

    final bytes = document!.displayableImageBytes;
    if (bytes != null && bytes.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(bytes, fit: BoxFit.contain, height: visualSize),
      );
    }

    return _placeholder(context, fallbackTypeLabel);
  }

  Widget _placeholder(BuildContext context, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.qr_code_2, size: 96, color: context.tokens.shapeDisabled),
        const SizedBox(height: 12),
        Text('Ticket type: $label', textAlign: TextAlign.center),
      ],
    );
  }
}

class _DailyAnimationTicket extends StatefulWidget {
  final TravelAnimation animation;
  final double size;
  final Color fallbackBackgroundColor;

  const _DailyAnimationTicket({
    required this.animation,
    required this.size,
    required this.fallbackBackgroundColor,
  });

  @override
  State<_DailyAnimationTicket> createState() => _DailyAnimationTicketState();
}

class _DailyAnimationTicketState extends State<_DailyAnimationTicket>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration());
    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0), weight: 50),
    ]).animate(_controller);
    _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant _DailyAnimationTicket oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animation.speed != widget.animation.speed) {
      _controller
        ..duration = _duration()
        ..repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Duration _duration() {
    final speed = widget.animation.speed ?? 50;
    final milliseconds = (speed * 20).clamp(200, 60000).toInt();
    return Duration(milliseconds: milliseconds);
  }

  Color _backgroundColor() {
    final raw = widget.animation.color?.trim() ?? '';
    if (raw.isEmpty) {
      return widget.fallbackBackgroundColor;
    }

    final normalized = raw.replaceFirst('#', '');
    final parsed = int.tryParse(normalized, radix: 16);
    if (parsed == null) {
      return widget.fallbackBackgroundColor;
    }

    if (normalized.length <= 6) {
      return Color(0xFF000000 | parsed);
    }
    return Color(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(16),
      ),
      child: AnimatedBuilder(
        animation: _opacity,
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.memory(
            widget.animation.imageBytes,
            fit: BoxFit.contain,
            semanticLabel: 'Valid control image',
          ),
        ),
        builder: (context, child) {
          return Opacity(opacity: _opacity.value, child: child);
        },
      ),
    );
  }
}

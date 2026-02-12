import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omsa_design_system/omsa_design_system.dart';

class PurchaseConfirmationScreen extends StatelessWidget {
  final String packageId;

  const PurchaseConfirmationScreen({super.key, required this.packageId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Purchase Complete',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.check_circle,
              size: 80,
              color: SemanticColorTokens.shapeSuccess,
            ),
            const SizedBox(height: 24),
            Text(
              'Payment successful!',
              style: AppTypography.headingExtraLarge2.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Your ticket is ready to use',
              style: AppTypography.textLarge.copyWith(
                color: BaseLightTokens.textSubdued,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            OmsaCard(
              variant: OmsaCardVariant.elevated,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Purchase details',
                    style: AppTypography.textLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow('Package ID', packageId),
                  const SizedBox(height: 8),
                  _buildInfoRow('Status', 'Ready for retrieval'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            OmsaButton(
              onPressed: () {
                final encodedPackageId = Uri.encodeComponent(packageId);
                context.pushReplacement('/ticket/$encodedPackageId');
              },
              width: OmsaButtonWidth.fluid,
              leadingIcon: const Icon(Icons.qr_code_scanner),
              child: const Text('View ticket for inspection'),
            ),
            const SizedBox(height: 12),
            OmsaButton(
              onPressed: () {
                context.go('/');
              },
              width: OmsaButtonWidth.fluid,
              variant: OmsaButtonVariant.secondary,
              leadingIcon: const Icon(Icons.home),
              child: const Text('Return to home'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: AppTypography.textMedium.copyWith(
              color: BaseLightTokens.textSubdued,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: AppTypography.textMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

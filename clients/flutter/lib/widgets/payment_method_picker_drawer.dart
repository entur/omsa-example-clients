import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_icons/omsa_icons.dart';

enum PaymentMethodType { newCard, savedCard, vipps }

// Access dart-define variables for default test phone number
const String _defaultVippsPhone = String.fromEnvironment('TEST_VIPPS_PHONE');

class PaymentMethodSelection {
  final PaymentMethodType method;
  final String? phoneNumber;

  const PaymentMethodSelection({required this.method, this.phoneNumber});
}

class PaymentMethodPickerDrawer extends StatefulWidget {
  final PaymentMethodSelection initialSelection;

  const PaymentMethodPickerDrawer({super.key, required this.initialSelection});

  @override
  State<PaymentMethodPickerDrawer> createState() =>
      _PaymentMethodPickerDrawerState();

  static Future<PaymentMethodSelection?> show(
    BuildContext context, {
    required PaymentMethodSelection initialSelection,
  }) {
    return showModalBottomSheet<PaymentMethodSelection>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: context.tokens.frameTint,
      builder: (context) =>
          PaymentMethodPickerDrawer(initialSelection: initialSelection),
    );
  }
}

class _PaymentMethodPickerDrawerState extends State<PaymentMethodPickerDrawer> {
  late PaymentMethodType _selectedMethod;
  final TextEditingController _phoneController = TextEditingController();
  String? _phoneError;
  bool _useCustomVippsNumber = false;

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.initialSelection.method;

    // Initialize phone controller with saved number or default
    if (widget.initialSelection.phoneNumber != null) {
      _phoneController.text = widget.initialSelection.phoneNumber!;
      // Check if using a custom number (not the default)
      _useCustomVippsNumber =
          widget.initialSelection.phoneNumber != _defaultVippsPhone;
    } else if (_defaultVippsPhone.isNotEmpty) {
      _phoneController.text = _defaultVippsPhone;
      _useCustomVippsNumber = false;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  bool _isValidNorwegianPhone(String phone) {
    final phoneRegex = RegExp(r'^\d{8}$');
    return phoneRegex.hasMatch(phone);
  }

  String? _validatePhoneNumber() {
    if (_selectedMethod == PaymentMethodType.vipps) {
      // Only validate if using custom number or no default is set
      if (_useCustomVippsNumber || _defaultVippsPhone.isEmpty) {
        final phone = _phoneController.text.trim();
        if (phone.isEmpty) {
          return 'Phone number is required for Vipps payments';
        }
        if (!_isValidNorwegianPhone(phone)) {
          return 'Please enter a valid 8-digit Norwegian phone number';
        }
      }
    }
    return null;
  }

  void _submit() {
    final phoneValidationError = _validatePhoneNumber();
    if (phoneValidationError != null) {
      setState(() {
        _phoneError = phoneValidationError;
      });
      return;
    }

    Navigator.of(context).pop(
      PaymentMethodSelection(
        method: _selectedMethod,
        phoneNumber: _selectedMethod == PaymentMethodType.vipps
            ? _phoneController.text.trim()
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: tokens.strokeSubdued,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment method',
                  style: AppTypography.textExtraLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                OmsaIconButton(
                  icon: OmsaIcons.CloseSmall(),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            OmsaRadioPanelGroup<PaymentMethodType>(
              value: _selectedMethod,
              expandOnSelected: true,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedMethod = value;
                    _phoneError = null;
                  });
                }
              },
              options: [
                OmsaRadioPanelOption<PaymentMethodType>(
                  value: PaymentMethodType.newCard,
                  title: Row(
                    children: [
                      OmsaIcons.AddCard(size: 20),
                      const SizedBox(width: 8),
                      const Text('New card'),
                    ],
                  ),
                ),
                OmsaRadioPanelOption<PaymentMethodType>(
                  value: PaymentMethodType.savedCard,
                  title: Row(
                    children: [
                      OmsaIcons.Visa(size: 20),
                      const SizedBox(width: 8),
                      const Text('Saved card (VISA ••1234)'),
                    ],
                  ),
                ),
                OmsaRadioPanelOption<PaymentMethodType>(
                  value: PaymentMethodType.vipps,
                  title: Row(
                    children: [
                      OmsaIcons.Vipps(size: 20),
                      const SizedBox(width: 8),
                      const Text('Vipps'),
                    ],
                  ),
                  children: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!_useCustomVippsNumber &&
                          _defaultVippsPhone.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Phone: ${_phoneController.text.replaceRange(4, 8, '••••')}',
                                style: AppTypography.textMedium,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _useCustomVippsNumber = true;
                                  _phoneController.clear();
                                });
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text('Change number'),
                            ),
                          ],
                        ),
                      ] else ...[
                        const SizedBox(height: 12),
                        Text(
                          'Phone number',
                          style: AppTypography.textMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        OmsaTextField(
                          controller: _phoneController,
                          label: 'Phone number',
                          hint: '12345678',
                          keyboardType: TextInputType.phone,
                          maxLength: 8,
                          feedback: _phoneError,
                          variant: _phoneError != null
                              ? OmsaTextFieldVariant.negative
                              : OmsaTextFieldVariant.none,
                          onChanged: (value) {
                            if (_phoneError != null) {
                              setState(() {
                                _phoneError = null;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Enter your Norwegian phone number for Vipps payment',
                                style: TextStyle(
                                  color: BaseLightTokens.textSubdued,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            if (_defaultVippsPhone.isNotEmpty)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _useCustomVippsNumber = false;
                                    _phoneController.text = _defaultVippsPhone;
                                    _phoneError = null;
                                  });
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text('Use saved'),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            OmsaButton(
              onPressed: _submit,
              width: OmsaButtonWidth.fluid,
              child: const Text('Confirm payment method'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:omsa_design_system/components/shared/component_enums.dart';
import 'package:omsa_design_system/components/alert/omsa_alert_colors.dart';
import 'package:omsa_design_system/components/alert/omsa_alert_dimensions.dart';
import 'package:omsa_design_system/components/buttons/omsa_icon_button.dart';
import 'package:omsa_icons/omsa_icons.dart';

/// Base alert box component matching React's BaseAlertBox
class OmsaBaseAlertBox extends StatefulWidget {
  const OmsaBaseAlertBox({
    super.key,
    required this.variant,
    required this.size,
    this.title,
    this.children,
    this.closable = false,
    this.closeButtonLabel = 'Lukk',
    this.onClose,
    this.mode = OmsaComponentMode.standard,
    this.width,
  });

  final OmsaAlertVariant variant;
  final OmsaAlertSize size;
  final Widget? title;
  final Widget? children;
  final bool closable;
  final String closeButtonLabel;
  final VoidCallback? onClose;
  final OmsaComponentMode mode;
  final OmsaAlertWidth? width;

  @override
  State<OmsaBaseAlertBox> createState() => _OmsaBaseAlertBoxState();
}

class _OmsaBaseAlertBoxState extends State<OmsaBaseAlertBox> {
  bool _isClosed = false;

  void _handleClose() {
    setState(() {
      _isClosed = true;
    });
    widget.onClose?.call();
  }

  OmsaIconData _getIconData(OmsaAlertVariant variant) {
    switch (variant) {
      case OmsaAlertVariant.success:
        return OmsaIcons.ValidationSuccess;
      case OmsaAlertVariant.information:
        return OmsaIcons.ValidationInfo;
      case OmsaAlertVariant.warning:
        return OmsaIcons.ValidationExclamation;
      case OmsaAlertVariant.negative:
        return OmsaIcons.ValidationError;
    }
  }

  String _getIconDescription(OmsaAlertVariant variant) {
    switch (variant) {
      case OmsaAlertVariant.success:
        return 'Suksessmelding';
      case OmsaAlertVariant.information:
        return 'Infomelding';
      case OmsaAlertVariant.warning:
        return 'Varselmelding';
      case OmsaAlertVariant.negative:
        return 'Feilmelding';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isClosed) {
      return const SizedBox.shrink();
    }

    final colors = OmsaAlertColors.fromContext(
      context,
      variant: widget.variant,
      size: widget.size,
      mode: widget.mode,
    );

    final hasTitle = widget.title != null;
    final hasChildren = widget.children != null;

    double padding;
    double? maxWidth;
    double? minWidth;
    double iconSize;

    switch (widget.size) {
      case OmsaAlertSize.banner:
        padding = MediaQuery.of(context).size.width >= 1024
            ? OmsaAlertDimensions.paddingLarge
            : OmsaAlertDimensions.paddingMedium;
        iconSize = OmsaAlertDimensions.iconSizeLarge;
        break;
      case OmsaAlertSize.toast:
        padding = OmsaAlertDimensions.paddingSmall;
        maxWidth = OmsaAlertDimensions.toastMaxWidth;
        minWidth = MediaQuery.of(context).size.width >= 1024
            ? OmsaAlertDimensions.toastMinWidth
            : null;
        iconSize = OmsaAlertDimensions.iconSizeLarge;
        break;
      case OmsaAlertSize.small:
        padding = OmsaAlertDimensions.paddingSmall;
        iconSize = OmsaAlertDimensions.iconSize;
        break;
    }

    final iconWidget = Semantics(
      label: _getIconDescription(widget.variant),
      child: _getIconData(widget.variant)(
        size: iconSize,
        color: colors.iconColor,
      ),
    );

    final contentWidget = Expanded(
      child: DefaultTextStyle(
        style: TextStyle(
          color: colors.textColor,
          fontSize: widget.size == OmsaAlertSize.small ? 14.0 : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasTitle)
              DefaultTextStyle(
                style: TextStyle(
                  color: colors.textColor,
                  fontWeight: FontWeight.w600,
                ),
                child: widget.title!,
              ),
            if (hasChildren) widget.children!,
          ],
        ),
      ),
    );

    final closeButton = widget.closable
        ? Padding(
            padding: const EdgeInsets.only(
              left: OmsaAlertDimensions.closeButtonMarginLeft,
            ),
            child: Transform.translate(
              offset: const Offset(0, OmsaAlertDimensions.closeButtonMarginTop),
              child: OmsaIconButton(
                icon: OmsaIcons.Close(size: 16.0),
                onPressed: _handleClose,
                size: OmsaIconButtonSize.small,
                mode: widget.mode,
                tooltip: widget.closeButtonLabel,
              ),
            ),
          )
        : null;

    final isFluid =
        widget.width == null || widget.width == OmsaAlertWidth.fluid;
    final isFitContent = widget.width == OmsaAlertWidth.fitContent;

    return Container(
      constraints: BoxConstraints(
        maxWidth: isFitContent
            ? double.infinity
            : (maxWidth ?? double.infinity),
        minWidth: minWidth ?? 0,
      ),
      width: isFluid && widget.size == OmsaAlertSize.banner
          ? double.infinity
          : null,
      decoration: BoxDecoration(
        color: colors.fillColor,
        border: Border.all(
          color: colors.borderColor,
          width: OmsaAlertDimensions.borderWidthSmall,
        ),
        borderRadius: BorderRadius.circular(
          OmsaAlertDimensions.borderRadiusMedium,
        ),
      ),
      padding: EdgeInsets.all(padding),
      child: Row(
        crossAxisAlignment: !hasTitle && hasChildren
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: OmsaAlertDimensions.iconMarginRight,
            ),
            child:
                (widget.size == OmsaAlertSize.banner ||
                        widget.size == OmsaAlertSize.toast) &&
                    MediaQuery.of(context).size.width >= 1024
                ? Transform.translate(
                    offset: const Offset(
                      0,
                      OmsaAlertDimensions.iconMarginTopOffset,
                    ),
                    child: iconWidget,
                  )
                : iconWidget,
          ),
          contentWidget,
          if (closeButton != null) closeButton,
        ],
      ),
    );
  }
}

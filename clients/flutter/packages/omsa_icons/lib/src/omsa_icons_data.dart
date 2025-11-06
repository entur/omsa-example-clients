import 'package:flutter/widgets.dart';
import 'package:vector_graphics/vector_graphics.dart';

class OmsaIconData {
  const OmsaIconData(this.assetPath);

  final String assetPath;

  Widget call({
    Key? key,
    double? size,
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return Builder(
      builder: (context) {
        final effectiveWidth = size ?? width;
        final effectiveHeight = size ?? height;

        // Use explicit color if provided, otherwise inherit from IconTheme
        final effectiveColor = color ?? IconTheme.of(context).color;
        final colorFilter = effectiveColor != null
            ? ColorFilter.mode(effectiveColor, BlendMode.srcIn)
            : null;

        return VectorGraphic(
          key: key,
          loader: AssetBytesLoader(assetPath, packageName: 'omsa_icons'),
          width: effectiveWidth,
          height: effectiveHeight,
          fit: fit,
          alignment: alignment,
          semanticsLabel: semanticsLabel,
          excludeFromSemantics: excludeFromSemantics,
          clipBehavior: clipBehavior,
          colorFilter: colorFilter,
        );
      },
    );
  }
}

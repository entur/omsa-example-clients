import 'package:flutter/widgets.dart';
import 'package:vector_graphics/vector_graphics.dart';

class OmsaIconData {
  const OmsaIconData(this.assetPath, {this.preserveOriginalColor = false});

  final String assetPath;
  final bool preserveOriginalColor;

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

        // If preserveOriginalColor is true, don't apply any color filter
        // Use explicit color if provided, otherwise inherit from IconTheme
        final ColorFilter? colorFilter;
        if (preserveOriginalColor) {
          colorFilter = null;
        } else {
          final effectiveColor = color ?? IconTheme.of(context).color;
          colorFilter = effectiveColor != null
              ? ColorFilter.mode(effectiveColor, BlendMode.srcIn)
              : null;
        }

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

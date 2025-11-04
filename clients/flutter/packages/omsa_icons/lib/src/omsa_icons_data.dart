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
    final effectiveWidth = size ?? width;
    final effectiveHeight = size ?? height;
    final colorFilter = color != null
        ? ColorFilter.mode(color, BlendMode.srcIn)
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
  }
}

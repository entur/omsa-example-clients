import 'package:flutter/material.dart';
import 'package:omsa_design_system/theme/tokens/base_color_tokens.dart';
import 'package:omsa_design_system/theme/tokens/semantic_color_tokens.dart';
import 'package:omsa_design_system/theme/app_typography.dart';
import 'package:omsa_design_system/theme/app_dimensions.dart';

/// OMSA Design System Theme Factory
///
/// Provides theme configurations using generated design tokens from Figma.
/// Tokens are organized in a hierarchy:
/// - Primitive: Base colors (Blue/10, Coral/50, etc.)
/// - Semantic: Semantic meaning (fillBackgroundContrast, textAccent, etc.)
/// - Base: Common UI elements (frameDefault, shapeAccent, etc.)
/// - Component: Component-specific tokens
class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return _buildTheme(brightness: Brightness.light);
  }

  static ThemeData dark() {
    return _buildTheme(brightness: Brightness.dark);
  }

  /// Contrast theme for creating inverted sections.
  ///
  /// In the Linje design system, "contrast" sections create visual hierarchy
  /// by inverting brightness: light base → dark contrast, dark base → light contrast.
  static ThemeData contrast({required Brightness baseBrightness}) {
    final contrastBrightness = baseBrightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;
    return _buildTheme(brightness: contrastBrightness);
  }

  static ThemeData _buildTheme({required Brightness brightness}) {
    final isLight = brightness == Brightness.light;

    final colorScheme = isLight
        ? const ColorScheme.light(
            primary: SemanticColorTokens.fillPrimaryDefaultLight,
            onPrimary: SemanticColorTokens.textLight,
            primaryContainer: SemanticColorTokens.fillPrimaryHoverLight,
            onPrimaryContainer: SemanticColorTokens.textAccent,
            secondary: SemanticColorTokens.fillSecondaryActiveLight,
            onSecondary: SemanticColorTokens.textLight,
            secondaryContainer: SemanticColorTokens.fillSecondaryHoverLight,
            onSecondaryContainer: SemanticColorTokens.textAccent,
            error: SemanticColorTokens.fillNegativeDeep,
            onError: SemanticColorTokens.textLight,
            errorContainer: SemanticColorTokens.fillNegativeMuted,
            onErrorContainer: SemanticColorTokens.textAccent,
            surface: BaseLightTokens.frameDefault,
            onSurface: SemanticColorTokens.textAccent,
            surfaceContainerHighest: BaseLightTokens.frameElevated,
            outline: SemanticColorTokens.strokeAccent,
            outlineVariant: SemanticColorTokens.strokeSubdued,
          )
        : const ColorScheme.dark(
            primary: SemanticColorTokens.fillPrimaryDefaultContrast,
            onPrimary: SemanticColorTokens.textDark,
            primaryContainer: SemanticColorTokens.fillPrimaryHoverContrast,
            onPrimaryContainer: SemanticColorTokens.textLightAlt,
            secondary: SemanticColorTokens.fillSecondaryActiveContrast,
            onSecondary: SemanticColorTokens.textDark,
            secondaryContainer: SemanticColorTokens.fillSecondaryHoverContrast,
            onSecondaryContainer: SemanticColorTokens.textLightAlt,
            error: SemanticColorTokens.fillNegativeDeep,
            onError: SemanticColorTokens.textLight,
            errorContainer: SemanticColorTokens.fillNegativeDark,
            onErrorContainer: SemanticColorTokens.textNegativeAlt,
            surface: BaseDarkTokens.frameDefault,
            onSurface: SemanticColorTokens.textLightAlt,
            surfaceContainerHighest: BaseDarkTokens.frameElevated,
            outline: SemanticColorTokens.strokeDark,
            outlineVariant: SemanticColorTokens.strokeDarkAlt,
          );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.headlineSmall,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2.0,
          minimumSize: const Size.fromHeight(48.0),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusLarge,
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48.0),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusLarge,
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48.0),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusLarge,
          ),
          side: BorderSide(
            width: AppDimensions.borderWidthsDefault,
            color: isLight
                ? SemanticColorTokens.strokeAccent
                : SemanticColorTokens.strokeDark,
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size.fromHeight(48.0),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusLarge,
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 2.0,
        color: isLight
            ? BaseLightTokens.frameElevated
            : BaseDarkTokens.frameElevated,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusMedium,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: BorderSide(
            width: AppDimensions.borderWidthsDefault,
            color: isLight
                ? SemanticColorTokens.strokeAccent
                : SemanticColorTokens.strokeDark,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: BorderSide(
            width: AppDimensions.borderWidthsDefault,
            color: isLight
                ? SemanticColorTokens.strokeAccent
                : SemanticColorTokens.strokeDark,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: BorderSide(
            color: isLight
                ? SemanticColorTokens.strokeAccent
                : SemanticColorTokens.strokeContrast,
            width: AppDimensions.borderWidthsMedium,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: const BorderSide(
            color: SemanticColorTokens.strokeNegative,
            width: AppDimensions.borderWidthsDefault,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: const BorderSide(
            color: SemanticColorTokens.strokeNegativeAlt,
            width: AppDimensions.borderWidthsMedium,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}

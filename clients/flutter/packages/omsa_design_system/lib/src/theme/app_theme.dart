import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_semantic_colors.dart';
import 'app_typography.dart';
import 'app_dimensions.dart';

/// OMSA Design System Theme Factory
/// Provides light and dark theme configurations
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData light() {
    const colors = AppColors.light;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color scheme
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        primaryContainer: colors.primaryContainer,
        onPrimary: colors.onPrimary,
        onPrimaryContainer: colors.onPrimaryContainer,
        secondary: colors.secondary,
        secondaryContainer: colors.secondaryContainer,
        onSecondary: colors.onSecondary,
        onSecondaryContainer: colors.onSecondaryContainer,
        tertiary: colors.tertiary,
        tertiaryContainer: colors.tertiaryContainer,
        onTertiary: colors.onTertiary,
        onTertiaryContainer: colors.onTertiaryContainer,
        error: colors.error,
        errorContainer: colors.errorContainer,
        onError: colors.onError,
        onErrorContainer: colors.onErrorContainer,
        surface: colors.surface,
        onSurface: colors.onSurface,
        onSurfaceVariant: colors.onSurfaceVariant,
        outline: colors.outline,
        outlineVariant: colors.outlineVariant,
        shadow: colors.shadow,
        scrim: colors.scrim,
        inverseSurface: colors.inverseSurface,
        onInverseSurface: colors.onInverseSurface,
        inversePrimary: colors.inversePrimary,
      ),

      // Typography
      textTheme: TextTheme(
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

      // Component themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colors.onPrimary,
          backgroundColor: colors.primary,
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
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusMedium,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: BorderSide(
            width: AppDimensions.borderWidthsDefault,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: BorderSide(
            color: colors.primary,
            width: AppDimensions.borderWidthsMedium,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: BorderSide(
            color: colors.error,
            width: AppDimensions.borderWidthsDefault,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: BorderSide(
            color: colors.error,
            width: AppDimensions.borderWidthsMedium,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Extensions for custom colors
      extensions: const <ThemeExtension<dynamic>>[
        colors,
        AppSemanticColors.light,
      ],
    );
  }

  /// Dark theme configuration
  static ThemeData dark() {
    const colors = AppColors.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color scheme
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        primaryContainer: colors.primaryContainer,
        onPrimary: colors.onPrimary,
        onPrimaryContainer: colors.onPrimaryContainer,
        secondary: colors.secondary,
        secondaryContainer: colors.secondaryContainer,
        onSecondary: colors.onSecondary,
        onSecondaryContainer: colors.onSecondaryContainer,
        tertiary: colors.tertiary,
        tertiaryContainer: colors.tertiaryContainer,
        onTertiary: colors.onTertiary,
        onTertiaryContainer: colors.onTertiaryContainer,
        error: colors.error,
        errorContainer: colors.errorContainer,
        onError: colors.onError,
        onErrorContainer: colors.onErrorContainer,
        surface: colors.surface,
        onSurface: colors.onSurface,
        onSurfaceVariant: colors.onSurfaceVariant,
        outline: colors.outline,
        outlineVariant: colors.outlineVariant,
        shadow: colors.shadow,
        scrim: colors.scrim,
        inverseSurface: colors.inverseSurface,
        onInverseSurface: colors.onInverseSurface,
        inversePrimary: colors.inversePrimary,
      ),

      // Typography
      textTheme: TextTheme(
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

      // Component themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colors.onPrimary,
          backgroundColor: colors.primary,
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
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusMedium,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: BorderSide(
            width: AppDimensions.borderWidthsDefault,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: BorderSide(
            color: colors.primary,
            width: AppDimensions.borderWidthsMedium,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: BorderSide(
            color: colors.error,
            width: AppDimensions.borderWidthsDefault,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusLarge,
          borderSide: BorderSide(
            color: colors.error,
            width: AppDimensions.borderWidthsMedium,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Extensions for custom colors
      extensions: const <ThemeExtension<dynamic>>[
        colors,
        AppSemanticColors.dark,
      ],
    );
  }
}

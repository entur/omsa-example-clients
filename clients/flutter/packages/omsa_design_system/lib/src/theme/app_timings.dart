/// Animation timing constants for the OMSA Design System
class AppTimings {
  AppTimings._();

  // Raw values in seconds (for reference)
  /// 0.1 seconds - Fast animation timing
  static const double timingsFastSeconds = 0.1;

  /// 0.2 seconds - Medium animation timing
  static const double timingsMediumSeconds = 0.2;

  /// 0.5 seconds - Slow animation timing
  static const double timingsSlowSeconds = 0.5;

  // Flutter Duration objects
  /// Fast animation duration (100ms)
  static const Duration timingsFast = Duration(milliseconds: 100);

  /// Medium animation duration (200ms)
  static const Duration timingsMedium = Duration(milliseconds: 200);

  /// Slow animation duration (500ms)
  static const Duration timingsSlow = Duration(milliseconds: 500);
}
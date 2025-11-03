import 'package:omsa_design_system/components/inputs/input_panel/omsa_input_panel_base.dart';

/// Dimensions for the OmsaInputPanel components (radio and checkbox panels)
class OmsaInputPanelDimensions {
  OmsaInputPanelDimensions._();

  /// Minimum height for medium-sized panels (3.75rem)
  static const double minHeightMedium = 60.0;

  /// Minimum height for large-sized panels (6rem)
  static const double minHeightLarge = 96.0;

  /// Minimum width for all panels (20rem)
  static const double minWidth = 320.0;

  /// Duration of container state transition animations (in milliseconds)
  static const int containerAnimationDurationMs = 200;

  /// Duration of expand/collapse animations (in milliseconds)
  static const int expandAnimationDurationMs = 250;

  /// Gets the minimum height for a given panel size
  static double getMinHeight(OmsaInputPanelSize size) {
    switch (size) {
      case OmsaInputPanelSize.medium:
        return minHeightMedium;
      case OmsaInputPanelSize.large:
        return minHeightLarge;
    }
  }
}

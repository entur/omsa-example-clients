# OMSA Icons

Entur icon set for Flutter with tree-shaking support using pre-compiled vector graphics.

## Installation

```yaml
dependencies:
  omsa_icons:
    path: packages/omsa_icons
```

## Usage

```dart
import 'package:omsa_icons/omsa_icons.dart';

OmsaIcons.Search(size: 24, color: Colors.blue)
OmsaIcons.Bus(width: 32, height: 32)
```

## Regenerating Icons

After updating SVG files in `assets/svgs/`:

```bash
dart run tool/generate_icons.dart
```

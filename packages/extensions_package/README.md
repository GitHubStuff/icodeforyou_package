# extensions_package

## Features

```dart
abstract class ObservingStatefulWidget<T extends StatefulWidget>
```

1. Adds **afterFirstLayout**, **didChangeAppLifecycleState**, **didChangePlatformBrightness** to StatefullWidget
2. Idea for ```StatefullWidget``` to simply/use ```postframe callbacks``` and ```observers```

## Getting started

Add to ```pubspec.yaml```

```yaml
dependencies:
  extensions_package:
    git: https://github.com/GitHubStuff/extensions_package.git
```

## Usage

```dart
import 'package:extensions_package/extensions_package.dart';

class _MyHomeScreen extends ObservingStatefulWidget<ExampleHomeScreen> {
```

## Additional information

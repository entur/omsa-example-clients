/// Central configuration for the Flutter client.
/// Override `bffBaseUrl` at build time with:
/// `flutter run --dart-define=BFF_BASE_URL=https://your-bff/api/v1`
const String kDefaultBffBaseUrl = 'http://localhost:8000/api/v1';

const String bffBaseUrl = String.fromEnvironment(
  'BFF_BASE_URL',
  defaultValue: kDefaultBffBaseUrl,
);

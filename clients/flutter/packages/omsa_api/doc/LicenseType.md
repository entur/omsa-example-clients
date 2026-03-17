# omsa_api.model.LicenseType

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** |  | 
**modes** | [**List<Mode>**](Mode.md) |  | [optional] [default to const []]
**licenseCode** | **String** | short string, display names (length 0-75) | [optional] 
**issuingCountry** | **String** | two-letter country codes according to ISO 3166-1 | [optional] 
**customFields** | [**Map<String, Object>**](Object.md) | dictionary for extra fields (bilatural agreements) | [optional] [default to const {}]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



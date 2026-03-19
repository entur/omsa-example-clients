# omsa_api.model.Error

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**errorcode** | **int** | for really small numbers (0-10) | [default to 0]
**type** | **String** | real short string, codes (length 0-10) | [optional] 
**title** | **String** | short string, display names (length 0-75) | 
**status** | **int** | for really small numbers (0-10) | [optional] [default to 0]
**detail** | **String** | long string, memos etc (length 0-10.000) | [optional] 
**instance** | **String** | valid URL | [optional] 
**links** | [**List<Link>**](Link.md) |  | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



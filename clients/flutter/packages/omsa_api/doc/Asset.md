# omsa_api.model.Asset

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** |  | [optional] 
**id** | **String** | default string, full names etc (length 0-200) | [optional] 
**visualId** | **String** | short string, display names (length 0-75) | [optional] 
**product** | [**ProductReference**](ProductReference.md) |  | [optional] 
**mode** | [**Mode**](Mode.md) |  | [optional] 
**subMode** | **String** | default string, full names etc (length 0-200) | [optional] 
**equipment** | [**List<EquipmentReference>**](EquipmentReference.md) | list of external references | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



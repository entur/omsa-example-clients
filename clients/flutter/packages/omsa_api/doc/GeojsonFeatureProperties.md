# omsa_api.model.GeojsonFeatureProperties

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
**deck** | **String** | short string, display names (length 0-75) | [optional] 
**space** | **String** | short string, display names (length 0-75) | [optional] 
**row** | **int** | a bit short integer (0-100) | [optional] [default to 0]
**seatNumber** | **int** | a bit short integer (0-100) | [optional] [default to 0]
**facing** | **String** |  | [optional] 
**byWindow** | **bool** |  | [optional] 
**legSpace** | **int** | a bit short integer (0-100) | [optional] [default to 0]
**byAisle** | **bool** |  | [optional] 
**hasArmRest** | **bool** |  | [optional] 
**hasTray** | **bool** |  | [optional] 
**hasAirco** | **bool** |  | [optional] 
**hasEnergySupply** | **bool** |  | [optional] 
**hasLight** | **bool** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



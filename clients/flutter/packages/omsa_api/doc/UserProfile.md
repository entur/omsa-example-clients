# omsa_api.model.UserProfile

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** |  | 
**entitlements** | [**TravelPartyEntitlements**](TravelPartyEntitlements.md) |  | [optional] 
**requirements** | [**TravelPartyRequirements**](TravelPartyRequirements.md) |  | [optional] 
**id** | **String** | default string, full names etc (length 0-200) | 
**count** | **int** | a bit short integer (0-100) | [optional] [default to 0]
**minimumAge** | **int** | a bit short integer (0-100) | [optional] [default to 0]
**maximumAge** | **int** | a bit short integer (0-100) | [optional] [default to 0]
**monthDayOnWhichAgeApplies** | **int** | a bit short integer (0-100) | [optional] [default to 0]
**ageGroup** | **String** |  | [optional] 
**minimumHeight** | **int** | a bit short integer (0-100) | [optional] [default to 0]
**maximumHeight** | **int** | a bit short integer (0-100) | [optional] [default to 0]
**localResident** | **bool** |  | [optional] 
**genderLimitation** | **bool** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



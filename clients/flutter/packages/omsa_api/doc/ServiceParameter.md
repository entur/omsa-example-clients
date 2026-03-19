# omsa_api.model.ServiceParameter

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** |  | 
**product** | [**ProductReference**](ProductReference.md) |  | [optional] 
**asset** | **String** | default string, full names etc (length 0-200) | [optional] 
**serviceJourney** | **String** | default string, full names etc (length 0-200) | [optional] 
**userNeeds** | [**List<UserNeedReference>**](UserNeedReference.md) |  | [optional] [default to const []]
**class_** | [**ClassOfUse**](ClassOfUse.md) |  | [optional] 
**onboardStay** | [**List<OnboardStay>**](OnboardStay.md) |  | [optional] [default to const []]
**accommodations** | [**List<Accommodation>**](Accommodation.md) |  | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



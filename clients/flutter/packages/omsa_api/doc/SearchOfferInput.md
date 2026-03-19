# omsa_api.model.SearchOfferInput

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** |  | 
**timestamp** | [**DateTime**](DateTime.md) | https://www.rfc-editor.org/rfc/rfc3339#section-5.6, date-time (2019-10-12T07:20:50.52Z) | [optional] 
**specification** | [**TravelSpecification**](TravelSpecification.md) |  | [optional] 
**pattern** | [**List<TripPatternInner>**](TripPatternInner.md) |  | [optional] [default to const []]
**packageToExchange** | **String** | default string, full names etc (length 0-200) | [optional] 
**travellers** | [**List<IndividualTraveller>**](IndividualTraveller.md) |  | [optional] [default to const []]
**profiles** | [**List<UserProfile>**](UserProfile.md) |  | [optional] [default to const []]
**travellingAssets** | [**List<TravellingAsset>**](TravellingAsset.md) |  | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



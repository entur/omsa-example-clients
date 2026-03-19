# omsa_api.model.TravelSpecification

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**from** | [**PlaceReference**](PlaceReference.md) |  | [optional] 
**via** | [**List<PlaceReference>**](PlaceReference.md) | use an ID contained in the **placeDefinitions** field, or from an external source, when using coordinates, please use the prefix 'gps:' | [optional] [default to const []]
**to** | [**PlaceReference**](PlaceReference.md) |  | [optional] 
**startTime** | [**DateTime**](DateTime.md) | https://www.rfc-editor.org/rfc/rfc3339#section-5.6, date-time (2019-10-12T07:20:50.52Z) | [optional] 
**endTime** | [**DateTime**](DateTime.md) | https://www.rfc-editor.org/rfc/rfc3339#section-5.6, date-time (2019-10-12T07:20:50.52Z) | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



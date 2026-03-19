# omsa_api.model.OfferProperties

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**legs** | [**List<Leg>**](Leg.md) |  | [optional] [default to const []]
**ancillaries** | [**List<Ancillary>**](Ancillary.md) |  | [optional] [default to const []]
**products** | [**List<Product>**](Product.md) |  | [optional] [default to const []]
**price** | [**AmountOfMoney**](AmountOfMoney.md) |  | [optional] 
**summary** | [**Map<String, Object>**](Object.md) |  | [optional] [default to const {}]
**guarantees** | [**List<Guarantee>**](Guarantee.md) |  | [optional] [default to const []]
**expiryTime** | [**DateTime**](DateTime.md) | https://www.rfc-editor.org/rfc/rfc3339#section-5.6, date-time (2019-10-12T07:20:50.52Z) | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



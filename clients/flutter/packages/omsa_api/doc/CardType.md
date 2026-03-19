# omsa_api.model.CardType

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | short string, display names (length 0-75) | 
**type** | **String** |  | 
**cardCategory** | **String** | The category of card<br> DISCOUNT - discount card, can be applied in the purchase process to get rebate<br> TRAVEL - (external) travel card, possibly paid for in other context, but also monthly, weekly or day-cards<br> BANK - bank card<br> CREDIT - credit card<br> ID - identification card, like an ID card<br> PASSPORT - passport to identify yourself<br> OTHER - unspecified, use 'subCategory' to specify the category of card | [optional] 
**subCategory** | **String** | short string, display names (length 0-75) | [optional] 
**relatedProduct** | [**ProductReference**](ProductReference.md) |  | [optional] 
**transportOrganisations** | [**List<OrganisationReference>**](OrganisationReference.md) | references to accepting parties, only if applicable | [optional] [default to const []]
**customFields** | [**Map<String, Object>**](Object.md) | dictionary for extra fields (bilatural agreements) | [optional] [default to const {}]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



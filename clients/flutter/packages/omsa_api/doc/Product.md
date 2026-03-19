# omsa_api.model.Product

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** |  | [optional] 
**productId** | [**ProductReference**](ProductReference.md) |  | [optional] 
**productName** | **String** | default string, full names etc (length 0-200) | [optional] 
**guarantees** | [**List<Guarantee>**](Guarantee.md) | references to products that are contained in this product (to facilitate e.g. travel through) If his combined product is named in a package, the referenced packages must be enlisted as well. | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



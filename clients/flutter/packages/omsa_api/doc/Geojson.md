# omsa_api.model.Geojson

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** |  | [optional] 
**features** | [**List<GeojsonFeature>**](GeojsonFeature.md) |  | [optional] [default to const []]
**properties** | [**Object**](.md) |  | [optional] 
**crs** | [**GeojsonCrs**](GeojsonCrs.md) |  | [optional] 
**numberMatched** | **int** |  | [optional] 
**numberReturned** | **int** |  | [optional] 
**links** | [**List<Link>**](Link.md) | actions that can be performed on this package, but also alternative (rel=alternative+1, alternative+2) offers or references to other resources In case it is an alternative, specify clearly in the description what the financial consequences are. | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



# omsa_api.model.CollectionInfo

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | identifier of the collection used, for example, in URIs | 
**title** | **String** | human readable title of the collection | [optional] 
**description** | **String** | a description of the data in the collection | [optional] 
**links** | [**List<Link>**](Link.md) |  | [default to const []]
**extent** | [**Object**](.md) |  | [optional] 
**itemType** | **String** | indicator about the type of the items in the collection if the collection has an accessible /collections/{collectionId}/items endpoint | [optional] [default to 'unknown']
**crs** | **List<String>** | the list of coordinate reference systems supported by the API; the first item is the default coordinate reference system | [optional] [default to const []]
**dataType** | [**DataType**](DataType.md) |  | [optional] 
**geometryDimension** | **int** | The geometry dimension of the features shown in this layer (0: points, 1: curves, 2: surfaces, 3: solids), unspecified: mixed or unknown | [optional] 
**minScaleDenominator** | **num** | Minimum scale denominator for usage of the collection | [optional] 
**maxScaleDenominator** | **num** | Maximum scale denominator for usage of the collection | [optional] 
**minCellSize** | **num** | Minimum cell size for usage of the collection | [optional] 
**maxCellSize** | **num** | Maximum cell size for usage of the collection | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



# omsa_api.model.PackageCollection

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** |  | 
**packages** | [**List<Package>**](Package.md) |  | [default to const []]
**numberMatched** | **int** | Total number of packages available (for pagination) | [optional] 
**numberReturned** | **int** | Number of packages in this response | [optional] 
**links** | [**List<Link>**](Link.md) | Actions that can be performed on this collection. | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



# omsa_api.model.Link

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**rel** | **String** | the action that can be performed OR part of the URI allowed values include the 'processId's, prefixes for the referenced data sources, prefixes for deeplinks ('apple' and 'android'), OGC compliant ones (alternative, next, etc) | 
**href** | **String** | valid URL | 
**type** | **String** | short string, display names (length 0-75) | [optional] 
**method** | **String** | to indicate the http method. | [optional] 
**description** | **String** | the description of the external data source | [optional] 
**body** | [**Object**](.md) | the (prefilled) body for the request | [optional] 
**headers** | **Map<String, String>** |  | [optional] [default to const {}]
**isMandatory** | **bool** | is this link informative, or must it be used? | [optional] 
**hash** | **String** | to validate that the content of the link hasn't been changed. | [optional] 
**validity** | [**TemporalParameter**](TemporalParameter.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



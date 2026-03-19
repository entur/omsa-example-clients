# omsa_api.model.PostalAddress

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**placeId** | [**PlaceReference**](PlaceReference.md) |  | [optional] 
**addressLine1** | **String** | long string, memos etc (length 0-10.000) | 
**addressLine2** | **String** | long string, memos etc (length 0-10.000) | 
**street** | **String** | default string, full names etc (length 0-200) | [optional] 
**houseNumber** | **int** | default length for an integer (0-1000) | [optional] [default to 0]
**houseNumberAddition** | **String** | real short string, codes (length 0-10) | [optional] 
**postalCode** | **String** | short string, display names (length 0-75) | [optional] 
**city** | **String** | short string, display names (length 0-75) | [optional] 
**province** | **String** | short string, display names (length 0-75) | [optional] 
**state** | **String** | short string, display names (length 0-75) | [optional] 
**country** | **String** | two-letter country codes according to ISO 3166-1 | [optional] 
**additionalInfo** | **String** | long string, memos etc (length 0-10.000) | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



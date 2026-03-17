# omsa_api.model.AmountOfMoney

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**amount** | **double** | This should be in the base unit as defined by the ISO 4217 currency code with the appropriate number of decimal places and omitting the currency symbol. e.g. if the price is in US Dollars the price would be 9.95. This is inclusive VAT | 
**taxPercentageUsed** | **double** | the travelled distance. Only if applicable. | [optional] 
**currencyCode** | **String** | ISO 4217 currency code | [optional] 
**vatCountryCode** | **String** | two-letter country codes according to ISO 3166-1 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



# omsa_api.model.FinancialDetail

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**amount** | [**AmountOfMoney**](AmountOfMoney.md) |  | [optional] 
**package** | **String** | default string, full names etc (length 0-200) | [optional] 
**offer** | **String** | default string, full names etc (length 0-200) | [optional] 
**leg** | **String** | default string, full names etc (length 0-200) | [optional] 
**category** | [**PaymentCategory**](PaymentCategory.md) |  | [optional] 
**expirationDate** | [**DateTime**](DateTime.md) | https://www.rfc-editor.org/rfc/rfc3339#section-5.6, date-time (2019-10-12T07:20:50.52Z) | [optional] 
**customFields** | [**Map<String, Object>**](Object.md) | dictionary for extra fields (bilatural agreements) | [optional] [default to const {}]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



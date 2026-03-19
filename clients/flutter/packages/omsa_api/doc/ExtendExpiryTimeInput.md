# omsa_api.model.ExtendExpiryTimeInput

## Load the model package
```dart
import 'package:omsa_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**packageId** | **String** | default string, full names etc (length 0-200) | 
**type** | **String** |  | 
**timestamp** | [**DateTime**](DateTime.md) | https://www.rfc-editor.org/rfc/rfc3339#section-5.6, date-time (2019-10-12T07:20:50.52Z) | [optional] 
**extensionReason** | **String** | in case operation is EXTEND_EXPIRY_TIME, the reason for extension must be supplied here.<br> _PURCHASE_PENDING_ - The internal purchase process on the MP side is not yet finished<br> _PAYMENT_PENDING_ - The customer is in the payment process<br> _OTHER_ - unspecified | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



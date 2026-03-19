# omsa_api.api.AuthenticationApi

## Load the API package
```dart
import 'package:omsa_api/api.dart';
```

All URIs are relative to *https://example.b5*

Method | HTTP request | Description
------------- | ------------- | -------------
[**oauthTokenPost**](AuthenticationApi.md#oauthtokenpost) | **POST** /oauth/token | Token Endpoint


# **oauthTokenPost**
> OauthTokenPost200Response oauthTokenPost(grantType, username, password, clientId, clientSecret)

Token Endpoint

This endpoint is used to obtain an access token and optionally an ID token through different OAuth 2.0 grant types, including Client Credentials Flow. Whenever the mTLS flow is taken, the properties will be ignored, and the access token will be generated based on the credentials in the certificate (O or CN).

### Example
```dart
import 'package:omsa_api/api.dart';

final api_instance = AuthenticationApi();
final grantType = grantType_example; // String | The grant type: 'client_credentials', 'password', or 'refresh_token'.
final username = username_example; // String | The username
final password = password_example; // String | The password
final clientId = clientId_example; // String | The client ID (Client Credentials Flow)
final clientSecret = clientSecret_example; // String | The client secret (Client Credentials Flow)

try {
    final result = api_instance.oauthTokenPost(grantType, username, password, clientId, clientSecret);
    print(result);
} catch (e) {
    print('Exception when calling AuthenticationApi->oauthTokenPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **grantType** | **String**| The grant type: 'client_credentials', 'password', or 'refresh_token'. | [optional] [default to 'client_credentials']
 **username** | **String**| The username | [optional] 
 **password** | **String**| The password | [optional] 
 **clientId** | **String**| The client ID (Client Credentials Flow) | [optional] 
 **clientSecret** | **String**| The client secret (Client Credentials Flow) | [optional] 

### Return type

[**OauthTokenPost200Response**](OauthTokenPost200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


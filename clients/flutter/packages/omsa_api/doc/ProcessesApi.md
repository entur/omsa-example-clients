# omsa_api.api.ProcessesApi

## Load the API package
```dart
import 'package:omsa_api/api.dart';
```

All URIs are relative to *https://example.b5*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addTravellerHandler**](ProcessesApi.md#addtravellerhandler) | **POST** /processes/add-traveller/execute | Add traveller processes
[**assignAncillaryProcessHandler**](ProcessesApi.md#assignancillaryprocesshandler) | **POST** /processes/assign-ancillary/execute | Handles assigning ancillary processes
[**assignAssetHandler**](ProcessesApi.md#assignassethandler) | **POST** /processes/assign-asset/execute | Handles assign asset processes
[**cancelPackageProcessHandler**](ProcessesApi.md#cancelpackageprocesshandler) | **POST** /processes/cancel-package/execute | Handles cancel package processes
[**claimRefundProcessHandler**](ProcessesApi.md#claimrefundprocesshandler) | **POST** /processes/claim-refund-option/execute | Handles claim of refund options
[**confirmPackageProcessHandler**](ProcessesApi.md#confirmpackageprocesshandler) | **POST** /processes/confirm-package/execute | Handles purchase processes
[**confirmRefundClaimProcessHandler**](ProcessesApi.md#confirmrefundclaimprocesshandler) | **POST** /processes/confirm-refund-option/execute | Handles confirmation of the refund claim
[**extendExpiryTimeProcessHandler**](ProcessesApi.md#extendexpirytimeprocesshandler) | **POST** /processes/extend-expiry-time/execute | Handles extending expiry time
[**purchaseOffersProcessHandler**](ProcessesApi.md#purchaseoffersprocesshandler) | **POST** /processes/purchase-offers/execute | Handles purchase of offers
[**purchasePackageProcessHandler**](ProcessesApi.md#purchasepackageprocesshandler) | **POST** /processes/purchase-package/execute | Handles purchase processes
[**releasePackageProcessHandler**](ProcessesApi.md#releasepackageprocesshandler) | **POST** /processes/release-package/execute | Handles purchase processes
[**removeTravellerHandler**](ProcessesApi.md#removetravellerhandler) | **POST** /processes/remove-traveller/execute | Remove traveller processes
[**searchOfferHandler**](ProcessesApi.md#searchofferhandler) | **POST** /processes/search-offers/execute | Handles search offers
[**selectOffersHandler**](ProcessesApi.md#selectoffershandler) | **POST** /processes/select-offers/execute | select offers in a package
[**twoPhasePurchasePackageProcessHandler**](ProcessesApi.md#twophasepurchasepackageprocesshandler) | **POST** /processes/2-phase-purchase-package/execute | Handles purchase processes
[**updateTravellerHandler**](ProcessesApi.md#updatetravellerhandler) | **POST** /processes/update-traveller/execute | Update traveller processes


# **addTravellerHandler**
> Package addTravellerHandler(acceptLanguage, authorization, addTravellerHandlerRequest)

Add traveller processes

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final addTravellerHandlerRequest = AddTravellerHandlerRequest(); // AddTravellerHandlerRequest | 

try {
    final result = api_instance.addTravellerHandler(acceptLanguage, authorization, addTravellerHandlerRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->addTravellerHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **addTravellerHandlerRequest** | [**AddTravellerHandlerRequest**](AddTravellerHandlerRequest.md)|  | 

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **assignAncillaryProcessHandler**
> Package assignAncillaryProcessHandler(acceptLanguage, authorization, assignAncillaryProcessHandlerRequest)

Handles assigning ancillary processes

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final assignAncillaryProcessHandlerRequest = AssignAncillaryProcessHandlerRequest(); // AssignAncillaryProcessHandlerRequest | 

try {
    final result = api_instance.assignAncillaryProcessHandler(acceptLanguage, authorization, assignAncillaryProcessHandlerRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->assignAncillaryProcessHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **assignAncillaryProcessHandlerRequest** | [**AssignAncillaryProcessHandlerRequest**](AssignAncillaryProcessHandlerRequest.md)|  | 

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **assignAssetHandler**
> Package assignAssetHandler(acceptLanguage, authorization, assignAssetHandlerRequest)

Handles assign asset processes

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final assignAssetHandlerRequest = AssignAssetHandlerRequest(); // AssignAssetHandlerRequest | 

try {
    final result = api_instance.assignAssetHandler(acceptLanguage, authorization, assignAssetHandlerRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->assignAssetHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **assignAssetHandlerRequest** | [**AssignAssetHandlerRequest**](AssignAssetHandlerRequest.md)|  | 

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cancelPackageProcessHandler**
> Package cancelPackageProcessHandler(acceptLanguage, authorization, purchasePackageProcessHandlerRequest)

Handles cancel package processes

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final purchasePackageProcessHandlerRequest = PurchasePackageProcessHandlerRequest(); // PurchasePackageProcessHandlerRequest | 

try {
    final result = api_instance.cancelPackageProcessHandler(acceptLanguage, authorization, purchasePackageProcessHandlerRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->cancelPackageProcessHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **purchasePackageProcessHandlerRequest** | [**PurchasePackageProcessHandlerRequest**](PurchasePackageProcessHandlerRequest.md)|  | 

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **claimRefundProcessHandler**
> Package claimRefundProcessHandler(acceptLanguage, authorization, claimRefundProcessHandlerRequest)

Handles claim of refund options

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final claimRefundProcessHandlerRequest = ClaimRefundProcessHandlerRequest(); // ClaimRefundProcessHandlerRequest | 

try {
    final result = api_instance.claimRefundProcessHandler(acceptLanguage, authorization, claimRefundProcessHandlerRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->claimRefundProcessHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **claimRefundProcessHandlerRequest** | [**ClaimRefundProcessHandlerRequest**](ClaimRefundProcessHandlerRequest.md)|  | 

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **confirmPackageProcessHandler**
> Package confirmPackageProcessHandler(acceptLanguage, authorization, purchasePackageProcessHandlerRequest, limit, offset, bbox)

Handles purchase processes

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final purchasePackageProcessHandlerRequest = PurchasePackageProcessHandlerRequest(); // PurchasePackageProcessHandlerRequest | 
final limit = 56; // int | The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
final offset = 56; // int | The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
final bbox = []; // List<num> | Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.

try {
    final result = api_instance.confirmPackageProcessHandler(acceptLanguage, authorization, purchasePackageProcessHandlerRequest, limit, offset, bbox);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->confirmPackageProcessHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **purchasePackageProcessHandlerRequest** | [**PurchasePackageProcessHandlerRequest**](PurchasePackageProcessHandlerRequest.md)|  | 
 **limit** | **int**| The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100. | [optional] [default to 100]
 **offset** | **int**| The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0. | [optional] [default to 0]
 **bbox** | [**List<num>**](num.md)| Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries. | [optional] [default to const []]

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **confirmRefundClaimProcessHandler**
> Package confirmRefundClaimProcessHandler(acceptLanguage, authorization, claimRefundProcessHandlerRequest)

Handles confirmation of the refund claim

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final claimRefundProcessHandlerRequest = ClaimRefundProcessHandlerRequest(); // ClaimRefundProcessHandlerRequest | 

try {
    final result = api_instance.confirmRefundClaimProcessHandler(acceptLanguage, authorization, claimRefundProcessHandlerRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->confirmRefundClaimProcessHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **claimRefundProcessHandlerRequest** | [**ClaimRefundProcessHandlerRequest**](ClaimRefundProcessHandlerRequest.md)|  | 

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **extendExpiryTimeProcessHandler**
> Package extendExpiryTimeProcessHandler(acceptLanguage, authorization, extendExpiryTimeProcessHandlerRequest)

Handles extending expiry time

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final extendExpiryTimeProcessHandlerRequest = ExtendExpiryTimeProcessHandlerRequest(); // ExtendExpiryTimeProcessHandlerRequest | 

try {
    final result = api_instance.extendExpiryTimeProcessHandler(acceptLanguage, authorization, extendExpiryTimeProcessHandlerRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->extendExpiryTimeProcessHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **extendExpiryTimeProcessHandlerRequest** | [**ExtendExpiryTimeProcessHandlerRequest**](ExtendExpiryTimeProcessHandlerRequest.md)|  | 

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **purchaseOffersProcessHandler**
> Package purchaseOffersProcessHandler(acceptLanguage, authorization, purchaseOffersProcessHandlerRequest)

Handles purchase of offers

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final purchaseOffersProcessHandlerRequest = PurchaseOffersProcessHandlerRequest(); // PurchaseOffersProcessHandlerRequest | 

try {
    final result = api_instance.purchaseOffersProcessHandler(acceptLanguage, authorization, purchaseOffersProcessHandlerRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->purchaseOffersProcessHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **purchaseOffersProcessHandlerRequest** | [**PurchaseOffersProcessHandlerRequest**](PurchaseOffersProcessHandlerRequest.md)|  | 

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **purchasePackageProcessHandler**
> Package purchasePackageProcessHandler(acceptLanguage, authorization, purchasePackageProcessHandlerRequest)

Handles purchase processes

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final purchasePackageProcessHandlerRequest = PurchasePackageProcessHandlerRequest(); // PurchasePackageProcessHandlerRequest | 

try {
    final result = api_instance.purchasePackageProcessHandler(acceptLanguage, authorization, purchasePackageProcessHandlerRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->purchasePackageProcessHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **purchasePackageProcessHandlerRequest** | [**PurchasePackageProcessHandlerRequest**](PurchasePackageProcessHandlerRequest.md)|  | 

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **releasePackageProcessHandler**
> Package releasePackageProcessHandler(acceptLanguage, authorization, purchasePackageProcessHandlerRequest, limit, offset, bbox)

Handles purchase processes

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final purchasePackageProcessHandlerRequest = PurchasePackageProcessHandlerRequest(); // PurchasePackageProcessHandlerRequest | 
final limit = 56; // int | The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
final offset = 56; // int | The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
final bbox = []; // List<num> | Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.

try {
    final result = api_instance.releasePackageProcessHandler(acceptLanguage, authorization, purchasePackageProcessHandlerRequest, limit, offset, bbox);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->releasePackageProcessHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **purchasePackageProcessHandlerRequest** | [**PurchasePackageProcessHandlerRequest**](PurchasePackageProcessHandlerRequest.md)|  | 
 **limit** | **int**| The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100. | [optional] [default to 100]
 **offset** | **int**| The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0. | [optional] [default to 0]
 **bbox** | [**List<num>**](num.md)| Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries. | [optional] [default to const []]

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeTravellerHandler**
> Package removeTravellerHandler(acceptLanguage, authorization, removeTravellerHandlerRequest)

Remove traveller processes

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final removeTravellerHandlerRequest = RemoveTravellerHandlerRequest(); // RemoveTravellerHandlerRequest | 

try {
    final result = api_instance.removeTravellerHandler(acceptLanguage, authorization, removeTravellerHandlerRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->removeTravellerHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **removeTravellerHandlerRequest** | [**RemoveTravellerHandlerRequest**](RemoveTravellerHandlerRequest.md)|  | 

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchOfferHandler**
> OfferCollection searchOfferHandler(acceptLanguage, authorization, searchOfferHandlerRequest, limit, offset, bbox)

Handles search offers

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final searchOfferHandlerRequest = SearchOfferHandlerRequest(); // SearchOfferHandlerRequest | 
final limit = 56; // int | The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
final offset = 56; // int | The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
final bbox = []; // List<num> | Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.

try {
    final result = api_instance.searchOfferHandler(acceptLanguage, authorization, searchOfferHandlerRequest, limit, offset, bbox);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->searchOfferHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **searchOfferHandlerRequest** | [**SearchOfferHandlerRequest**](SearchOfferHandlerRequest.md)|  | 
 **limit** | **int**| The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100. | [optional] [default to 100]
 **offset** | **int**| The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0. | [optional] [default to 0]
 **bbox** | [**List<num>**](num.md)| Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries. | [optional] [default to const []]

### Return type

[**OfferCollection**](OfferCollection.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **selectOffersHandler**
> Package selectOffersHandler(acceptLanguage, authorization, selectOffersHandlerRequest)

select offers in a package

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final selectOffersHandlerRequest = SelectOffersHandlerRequest(); // SelectOffersHandlerRequest | 

try {
    final result = api_instance.selectOffersHandler(acceptLanguage, authorization, selectOffersHandlerRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->selectOffersHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **selectOffersHandlerRequest** | [**SelectOffersHandlerRequest**](SelectOffersHandlerRequest.md)|  | 

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **twoPhasePurchasePackageProcessHandler**
> Package twoPhasePurchasePackageProcessHandler(acceptLanguage, authorization, purchasePackageProcessHandlerRequest, limit, offset, bbox)

Handles purchase processes

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final purchasePackageProcessHandlerRequest = PurchasePackageProcessHandlerRequest(); // PurchasePackageProcessHandlerRequest | 
final limit = 56; // int | The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
final offset = 56; // int | The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
final bbox = []; // List<num> | Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.

try {
    final result = api_instance.twoPhasePurchasePackageProcessHandler(acceptLanguage, authorization, purchasePackageProcessHandlerRequest, limit, offset, bbox);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->twoPhasePurchasePackageProcessHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **purchasePackageProcessHandlerRequest** | [**PurchasePackageProcessHandlerRequest**](PurchasePackageProcessHandlerRequest.md)|  | 
 **limit** | **int**| The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100. | [optional] [default to 100]
 **offset** | **int**| The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0. | [optional] [default to 0]
 **bbox** | [**List<num>**](num.md)| Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries. | [optional] [default to const []]

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateTravellerHandler**
> Package updateTravellerHandler(acceptLanguage, authorization, updateTravellerHandlerRequest)

Update traveller processes

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuthPKI
//defaultApiClient.getAuthentication<OAuth>('OAuthPKI').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ProcessesApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final updateTravellerHandlerRequest = UpdateTravellerHandlerRequest(); // UpdateTravellerHandlerRequest | 

try {
    final result = api_instance.updateTravellerHandler(acceptLanguage, authorization, updateTravellerHandlerRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProcessesApi->updateTravellerHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **updateTravellerHandlerRequest** | [**UpdateTravellerHandlerRequest**](UpdateTravellerHandlerRequest.md)|  | 

### Return type

[**Package**](Package.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


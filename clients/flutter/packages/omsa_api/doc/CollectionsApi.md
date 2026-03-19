# omsa_api.api.CollectionsApi

## Load the API package
```dart
import 'package:omsa_api/api.dart';
```

All URIs are relative to *https://example.b5*

Method | HTTP request | Description
------------- | ------------- | -------------
[**ancillariesCollectionHandler**](CollectionsApi.md#ancillariescollectionhandler) | **GET** /collections/ancillaries/items | Handles ancillaries collections
[**assetCollectionHandler**](CollectionsApi.md#assetcollectionhandler) | **GET** /collections/assets/items | Handles asset collections
[**changeOptionHandler**](CollectionsApi.md#changeoptionhandler) | **GET** /collections/change-options/items | Handles change options collections
[**getDataSources**](CollectionsApi.md#getdatasources) | **GET** /collections/datasources/items | Retrieves all (external) datasources, that are used in requests and responses
[**getPackage**](CollectionsApi.md#getpackage) | **GET** /collections/packages/items/{packageId} | Retrieve a single package
[**packageCollectionHandler**](CollectionsApi.md#packagecollectionhandler) | **GET** /collections/packages/items | Retrieve a history of purchased packages
[**refundOptionHandler**](CollectionsApi.md#refundoptionhandler) | **GET** /collections/refund-options/items | Handles refund options collections
[**traveldocumentsCollectionHandler**](CollectionsApi.md#traveldocumentscollectionhandler) | **GET** /collections/travel-documents/items | Handles travel documents


# **ancillariesCollectionHandler**
> List<AncillaryCollection> ancillariesCollectionHandler(packageId, legId, acceptLanguage, authorization, limit, offset)

Handles ancillaries collections

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

final api_instance = CollectionsApi();
final packageId = packageId_example; // String | the identifier of a package
final legId = legId_example; // String | leg identifier
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final limit = 56; // int | The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
final offset = 56; // int | The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.

try {
    final result = api_instance.ancillariesCollectionHandler(packageId, legId, acceptLanguage, authorization, limit, offset);
    print(result);
} catch (e) {
    print('Exception when calling CollectionsApi->ancillariesCollectionHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **packageId** | **String**| the identifier of a package | 
 **legId** | **String**| leg identifier | 
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **limit** | **int**| The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100. | [optional] [default to 100]
 **offset** | **int**| The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0. | [optional] [default to 0]

### Return type

[**List<AncillaryCollection>**](AncillaryCollection.md)

### Authorization

[OpenData](../README.md#OpenData), [OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **assetCollectionHandler**
> Geojson assetCollectionHandler(packageId, legId, acceptLanguage, authorization, limit, offset, bbox)

Handles asset collections

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

final api_instance = CollectionsApi();
final packageId = packageId_example; // String | the identifier of a package
final legId = legId_example; // String | leg identifier
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final limit = 56; // int | The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
final offset = 56; // int | The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
final bbox = []; // List<num> | Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.

try {
    final result = api_instance.assetCollectionHandler(packageId, legId, acceptLanguage, authorization, limit, offset, bbox);
    print(result);
} catch (e) {
    print('Exception when calling CollectionsApi->assetCollectionHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **packageId** | **String**| the identifier of a package | 
 **legId** | **String**| leg identifier | 
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **limit** | **int**| The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100. | [optional] [default to 100]
 **offset** | **int**| The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0. | [optional] [default to 0]
 **bbox** | [**List<num>**](num.md)| Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries. | [optional] [default to const []]

### Return type

[**Geojson**](Geojson.md)

### Authorization

[OpenData](../README.md#OpenData), [OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **changeOptionHandler**
> ChangeOptionCollection changeOptionHandler(packageId, acceptLanguage, authorization, legId)

Handles change options collections

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

final api_instance = CollectionsApi();
final packageId = packageId_example; // String | the identifier of a package
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final legId = legId_example; // String | leg identifier

try {
    final result = api_instance.changeOptionHandler(packageId, acceptLanguage, authorization, legId);
    print(result);
} catch (e) {
    print('Exception when calling CollectionsApi->changeOptionHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **packageId** | **String**| the identifier of a package | 
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **legId** | **String**| leg identifier | [optional] 

### Return type

[**ChangeOptionCollection**](ChangeOptionCollection.md)

### Authorization

[OpenData](../README.md#OpenData), [OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDataSources**
> List<Link> getDataSources(acceptLanguage, authorization)

Retrieves all (external) datasources, that are used in requests and responses

Retrieves all datasources

### Example
```dart
import 'package:omsa_api/api.dart';

final api_instance = CollectionsApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied

try {
    final result = api_instance.getDataSources(acceptLanguage, authorization);
    print(result);
} catch (e) {
    print('Exception when calling CollectionsApi->getDataSources: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 

### Return type

[**List<Link>**](Link.md)

### Authorization

[OpenData](../README.md#OpenData)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPackage**
> Package getPackage(acceptLanguage, authorization, packageId)

Retrieve a single package

### Example
```dart
import 'package:omsa_api/api.dart';
// TODO Configure HTTP Bearer authorization: BearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('BearerAuth').setAccessToken(yourTokenGeneratorFunction);
// TODO Configure OAuth2 access token for authorization: OAuth
//defaultApiClient.getAuthentication<OAuth>('OAuth').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = CollectionsApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final packageId = packageId_example; // String | The unique identifier of the package to retrieve

try {
    final result = api_instance.getPackage(acceptLanguage, authorization, packageId);
    print(result);
} catch (e) {
    print('Exception when calling CollectionsApi->getPackage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **packageId** | **String**| The unique identifier of the package to retrieve | 

### Return type

[**Package**](Package.md)

### Authorization

[BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **packageCollectionHandler**
> PackageCollection packageCollectionHandler(acceptLanguage, authorization, limit, offset, packageId, status)

Retrieve a history of purchased packages

Returns a paginated list of packages belonging to the authenticated user.

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

final api_instance = CollectionsApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final limit = 56; // int | The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
final offset = 56; // int | The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
final packageId = packageId_example; // String | the identifier of a package
final status = ; // PackageStatus | Filter packages by their lifecycle status (e.g. CONFIRMED, CANCELLED)

try {
    final result = api_instance.packageCollectionHandler(acceptLanguage, authorization, limit, offset, packageId, status);
    print(result);
} catch (e) {
    print('Exception when calling CollectionsApi->packageCollectionHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **limit** | **int**| The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100. | [optional] [default to 100]
 **offset** | **int**| The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0. | [optional] [default to 0]
 **packageId** | **String**| the identifier of a package | [optional] 
 **status** | [**PackageStatus**](.md)| Filter packages by their lifecycle status (e.g. CONFIRMED, CANCELLED) | [optional] 

### Return type

[**PackageCollection**](PackageCollection.md)

### Authorization

[OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refundOptionHandler**
> RefundOptionCollection refundOptionHandler(packageId, acceptLanguage, authorization, legId, travellerId, ancillaryId)

Handles refund options collections

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

final api_instance = CollectionsApi();
final packageId = packageId_example; // String | the identifier of a package
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final legId = legId_example; // String | leg identifier
final travellerId = travellerId_example; // String | traveller identifier
final ancillaryId = ancillaryId_example; // String | ancillary identifier

try {
    final result = api_instance.refundOptionHandler(packageId, acceptLanguage, authorization, legId, travellerId, ancillaryId);
    print(result);
} catch (e) {
    print('Exception when calling CollectionsApi->refundOptionHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **packageId** | **String**| the identifier of a package | 
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **legId** | **String**| leg identifier | [optional] 
 **travellerId** | **String**| traveller identifier | [optional] 
 **ancillaryId** | **String**| ancillary identifier | [optional] 

### Return type

[**RefundOptionCollection**](RefundOptionCollection.md)

### Authorization

[OpenData](../README.md#OpenData), [OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **traveldocumentsCollectionHandler**
> TravelDocumentCollection traveldocumentsCollectionHandler(acceptLanguage, authorization, packageId, legId)

Handles travel documents

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

final api_instance = CollectionsApi();
final acceptLanguage = acceptLanguage_example; // String | 
final authorization = authorization_example; // String | Header field, JWT must be supplied
final packageId = packageId_example; // String | the identifier of a package
final legId = legId_example; // String | leg identifier

try {
    final result = api_instance.traveldocumentsCollectionHandler(acceptLanguage, authorization, packageId, legId);
    print(result);
} catch (e) {
    print('Exception when calling CollectionsApi->traveldocumentsCollectionHandler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**|  | 
 **authorization** | **String**| Header field, JWT must be supplied | 
 **packageId** | **String**| the identifier of a package | 
 **legId** | **String**| leg identifier | [optional] 

### Return type

[**TravelDocumentCollection**](TravelDocumentCollection.md)

### Authorization

[OpenData](../README.md#OpenData), [OAuthPKI](../README.md#OAuthPKI), [BearerAuth](../README.md#BearerAuth), [OAuth](../README.md#OAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


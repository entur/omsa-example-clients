//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProcessesApi {
  ProcessesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Add traveller processes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [AddTravellerHandlerRequest] addTravellerHandlerRequest (required):
  Future<Response> addTravellerHandlerWithHttpInfo(String acceptLanguage, String authorization, AddTravellerHandlerRequest addTravellerHandlerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/add-traveller/execute';

    // ignore: prefer_final_locals
    Object? postBody = addTravellerHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Add traveller processes
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [AddTravellerHandlerRequest] addTravellerHandlerRequest (required):
  Future<Package?> addTravellerHandler(String acceptLanguage, String authorization, AddTravellerHandlerRequest addTravellerHandlerRequest,) async {
    final response = await addTravellerHandlerWithHttpInfo(acceptLanguage, authorization, addTravellerHandlerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Handles assigning ancillary processes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [AssignAncillaryProcessHandlerRequest] assignAncillaryProcessHandlerRequest (required):
  Future<Response> assignAncillaryProcessHandlerWithHttpInfo(String acceptLanguage, String authorization, AssignAncillaryProcessHandlerRequest assignAncillaryProcessHandlerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/assign-ancillary/execute';

    // ignore: prefer_final_locals
    Object? postBody = assignAncillaryProcessHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles assigning ancillary processes
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [AssignAncillaryProcessHandlerRequest] assignAncillaryProcessHandlerRequest (required):
  Future<Package?> assignAncillaryProcessHandler(String acceptLanguage, String authorization, AssignAncillaryProcessHandlerRequest assignAncillaryProcessHandlerRequest,) async {
    final response = await assignAncillaryProcessHandlerWithHttpInfo(acceptLanguage, authorization, assignAncillaryProcessHandlerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Handles assign asset processes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [AssignAssetHandlerRequest] assignAssetHandlerRequest (required):
  Future<Response> assignAssetHandlerWithHttpInfo(String acceptLanguage, String authorization, AssignAssetHandlerRequest assignAssetHandlerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/assign-asset/execute';

    // ignore: prefer_final_locals
    Object? postBody = assignAssetHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles assign asset processes
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [AssignAssetHandlerRequest] assignAssetHandlerRequest (required):
  Future<Package?> assignAssetHandler(String acceptLanguage, String authorization, AssignAssetHandlerRequest assignAssetHandlerRequest,) async {
    final response = await assignAssetHandlerWithHttpInfo(acceptLanguage, authorization, assignAssetHandlerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Handles cancel package processes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [PurchasePackageProcessHandlerRequest] purchasePackageProcessHandlerRequest (required):
  Future<Response> cancelPackageProcessHandlerWithHttpInfo(String acceptLanguage, String authorization, PurchasePackageProcessHandlerRequest purchasePackageProcessHandlerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/cancel-package/execute';

    // ignore: prefer_final_locals
    Object? postBody = purchasePackageProcessHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles cancel package processes
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [PurchasePackageProcessHandlerRequest] purchasePackageProcessHandlerRequest (required):
  Future<Package?> cancelPackageProcessHandler(String acceptLanguage, String authorization, PurchasePackageProcessHandlerRequest purchasePackageProcessHandlerRequest,) async {
    final response = await cancelPackageProcessHandlerWithHttpInfo(acceptLanguage, authorization, purchasePackageProcessHandlerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Handles claim of refund options
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [ClaimRefundProcessHandlerRequest] claimRefundProcessHandlerRequest (required):
  Future<Response> claimRefundProcessHandlerWithHttpInfo(String acceptLanguage, String authorization, ClaimRefundProcessHandlerRequest claimRefundProcessHandlerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/claim-refund-option/execute';

    // ignore: prefer_final_locals
    Object? postBody = claimRefundProcessHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles claim of refund options
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [ClaimRefundProcessHandlerRequest] claimRefundProcessHandlerRequest (required):
  Future<Package?> claimRefundProcessHandler(String acceptLanguage, String authorization, ClaimRefundProcessHandlerRequest claimRefundProcessHandlerRequest,) async {
    final response = await claimRefundProcessHandlerWithHttpInfo(acceptLanguage, authorization, claimRefundProcessHandlerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Handles purchase processes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [PurchasePackageProcessHandlerRequest] purchasePackageProcessHandlerRequest (required):
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  ///
  /// * [List<num>] bbox:
  ///   Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.
  Future<Response> confirmPackageProcessHandlerWithHttpInfo(String acceptLanguage, String authorization, PurchasePackageProcessHandlerRequest purchasePackageProcessHandlerRequest, { int? limit, int? offset, List<num>? bbox, }) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/confirm-package/execute';

    // ignore: prefer_final_locals
    Object? postBody = purchasePackageProcessHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (offset != null) {
      queryParams.addAll(_queryParams('', 'offset', offset));
    }
    if (bbox != null) {
      queryParams.addAll(_queryParams('csv', 'bbox', bbox));
    }

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles purchase processes
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [PurchasePackageProcessHandlerRequest] purchasePackageProcessHandlerRequest (required):
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  ///
  /// * [List<num>] bbox:
  ///   Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.
  Future<Package?> confirmPackageProcessHandler(String acceptLanguage, String authorization, PurchasePackageProcessHandlerRequest purchasePackageProcessHandlerRequest, { int? limit, int? offset, List<num>? bbox, }) async {
    final response = await confirmPackageProcessHandlerWithHttpInfo(acceptLanguage, authorization, purchasePackageProcessHandlerRequest,  limit: limit, offset: offset, bbox: bbox, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Handles confirmation of the refund claim
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [ClaimRefundProcessHandlerRequest] claimRefundProcessHandlerRequest (required):
  Future<Response> confirmRefundClaimProcessHandlerWithHttpInfo(String acceptLanguage, String authorization, ClaimRefundProcessHandlerRequest claimRefundProcessHandlerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/confirm-refund-option/execute';

    // ignore: prefer_final_locals
    Object? postBody = claimRefundProcessHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles confirmation of the refund claim
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [ClaimRefundProcessHandlerRequest] claimRefundProcessHandlerRequest (required):
  Future<Package?> confirmRefundClaimProcessHandler(String acceptLanguage, String authorization, ClaimRefundProcessHandlerRequest claimRefundProcessHandlerRequest,) async {
    final response = await confirmRefundClaimProcessHandlerWithHttpInfo(acceptLanguage, authorization, claimRefundProcessHandlerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Handles extending expiry time
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [ExtendExpiryTimeProcessHandlerRequest] extendExpiryTimeProcessHandlerRequest (required):
  Future<Response> extendExpiryTimeProcessHandlerWithHttpInfo(String acceptLanguage, String authorization, ExtendExpiryTimeProcessHandlerRequest extendExpiryTimeProcessHandlerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/extend-expiry-time/execute';

    // ignore: prefer_final_locals
    Object? postBody = extendExpiryTimeProcessHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles extending expiry time
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [ExtendExpiryTimeProcessHandlerRequest] extendExpiryTimeProcessHandlerRequest (required):
  Future<Package?> extendExpiryTimeProcessHandler(String acceptLanguage, String authorization, ExtendExpiryTimeProcessHandlerRequest extendExpiryTimeProcessHandlerRequest,) async {
    final response = await extendExpiryTimeProcessHandlerWithHttpInfo(acceptLanguage, authorization, extendExpiryTimeProcessHandlerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Handles purchase of offers
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [PurchaseOffersProcessHandlerRequest] purchaseOffersProcessHandlerRequest (required):
  Future<Response> purchaseOffersProcessHandlerWithHttpInfo(String acceptLanguage, String authorization, PurchaseOffersProcessHandlerRequest purchaseOffersProcessHandlerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/purchase-offers/execute';

    // ignore: prefer_final_locals
    Object? postBody = purchaseOffersProcessHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles purchase of offers
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [PurchaseOffersProcessHandlerRequest] purchaseOffersProcessHandlerRequest (required):
  Future<Package?> purchaseOffersProcessHandler(String acceptLanguage, String authorization, PurchaseOffersProcessHandlerRequest purchaseOffersProcessHandlerRequest,) async {
    final response = await purchaseOffersProcessHandlerWithHttpInfo(acceptLanguage, authorization, purchaseOffersProcessHandlerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Handles purchase processes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [PurchasePackageProcessHandlerRequest] purchasePackageProcessHandlerRequest (required):
  Future<Response> purchasePackageProcessHandlerWithHttpInfo(String acceptLanguage, String authorization, PurchasePackageProcessHandlerRequest purchasePackageProcessHandlerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/purchase-package/execute';

    // ignore: prefer_final_locals
    Object? postBody = purchasePackageProcessHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles purchase processes
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [PurchasePackageProcessHandlerRequest] purchasePackageProcessHandlerRequest (required):
  Future<Package?> purchasePackageProcessHandler(String acceptLanguage, String authorization, PurchasePackageProcessHandlerRequest purchasePackageProcessHandlerRequest,) async {
    final response = await purchasePackageProcessHandlerWithHttpInfo(acceptLanguage, authorization, purchasePackageProcessHandlerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Handles purchase processes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [PurchasePackageProcessHandlerRequest] purchasePackageProcessHandlerRequest (required):
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  ///
  /// * [List<num>] bbox:
  ///   Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.
  Future<Response> releasePackageProcessHandlerWithHttpInfo(String acceptLanguage, String authorization, PurchasePackageProcessHandlerRequest purchasePackageProcessHandlerRequest, { int? limit, int? offset, List<num>? bbox, }) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/release-package/execute';

    // ignore: prefer_final_locals
    Object? postBody = purchasePackageProcessHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (offset != null) {
      queryParams.addAll(_queryParams('', 'offset', offset));
    }
    if (bbox != null) {
      queryParams.addAll(_queryParams('csv', 'bbox', bbox));
    }

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles purchase processes
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [PurchasePackageProcessHandlerRequest] purchasePackageProcessHandlerRequest (required):
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  ///
  /// * [List<num>] bbox:
  ///   Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.
  Future<Package?> releasePackageProcessHandler(String acceptLanguage, String authorization, PurchasePackageProcessHandlerRequest purchasePackageProcessHandlerRequest, { int? limit, int? offset, List<num>? bbox, }) async {
    final response = await releasePackageProcessHandlerWithHttpInfo(acceptLanguage, authorization, purchasePackageProcessHandlerRequest,  limit: limit, offset: offset, bbox: bbox, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Remove traveller processes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [RemoveTravellerHandlerRequest] removeTravellerHandlerRequest (required):
  Future<Response> removeTravellerHandlerWithHttpInfo(String acceptLanguage, String authorization, RemoveTravellerHandlerRequest removeTravellerHandlerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/remove-traveller/execute';

    // ignore: prefer_final_locals
    Object? postBody = removeTravellerHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Remove traveller processes
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [RemoveTravellerHandlerRequest] removeTravellerHandlerRequest (required):
  Future<Package?> removeTravellerHandler(String acceptLanguage, String authorization, RemoveTravellerHandlerRequest removeTravellerHandlerRequest,) async {
    final response = await removeTravellerHandlerWithHttpInfo(acceptLanguage, authorization, removeTravellerHandlerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Handles search offers
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [SearchOfferHandlerRequest] searchOfferHandlerRequest (required):
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  ///
  /// * [List<num>] bbox:
  ///   Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.
  Future<Response> searchOfferHandlerWithHttpInfo(String acceptLanguage, String authorization, SearchOfferHandlerRequest searchOfferHandlerRequest, { int? limit, int? offset, List<num>? bbox, }) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/search-offers/execute';

    // ignore: prefer_final_locals
    Object? postBody = searchOfferHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (offset != null) {
      queryParams.addAll(_queryParams('', 'offset', offset));
    }
    if (bbox != null) {
      queryParams.addAll(_queryParams('csv', 'bbox', bbox));
    }

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles search offers
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [SearchOfferHandlerRequest] searchOfferHandlerRequest (required):
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  ///
  /// * [List<num>] bbox:
  ///   Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.
  Future<OfferCollection?> searchOfferHandler(String acceptLanguage, String authorization, SearchOfferHandlerRequest searchOfferHandlerRequest, { int? limit, int? offset, List<num>? bbox, }) async {
    final response = await searchOfferHandlerWithHttpInfo(acceptLanguage, authorization, searchOfferHandlerRequest,  limit: limit, offset: offset, bbox: bbox, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'OfferCollection',) as OfferCollection;
    
    }
    return null;
  }

  /// select offers in a package
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [SelectOffersHandlerRequest] selectOffersHandlerRequest (required):
  Future<Response> selectOffersHandlerWithHttpInfo(String acceptLanguage, String authorization, SelectOffersHandlerRequest selectOffersHandlerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/select-offers/execute';

    // ignore: prefer_final_locals
    Object? postBody = selectOffersHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// select offers in a package
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [SelectOffersHandlerRequest] selectOffersHandlerRequest (required):
  Future<Package?> selectOffersHandler(String acceptLanguage, String authorization, SelectOffersHandlerRequest selectOffersHandlerRequest,) async {
    final response = await selectOffersHandlerWithHttpInfo(acceptLanguage, authorization, selectOffersHandlerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Handles purchase processes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [PurchasePackageProcessHandlerRequest] purchasePackageProcessHandlerRequest (required):
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  ///
  /// * [List<num>] bbox:
  ///   Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.
  Future<Response> twoPhasePurchasePackageProcessHandlerWithHttpInfo(String acceptLanguage, String authorization, PurchasePackageProcessHandlerRequest purchasePackageProcessHandlerRequest, { int? limit, int? offset, List<num>? bbox, }) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/2-phase-purchase-package/execute';

    // ignore: prefer_final_locals
    Object? postBody = purchasePackageProcessHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (offset != null) {
      queryParams.addAll(_queryParams('', 'offset', offset));
    }
    if (bbox != null) {
      queryParams.addAll(_queryParams('csv', 'bbox', bbox));
    }

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles purchase processes
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [PurchasePackageProcessHandlerRequest] purchasePackageProcessHandlerRequest (required):
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  ///
  /// * [List<num>] bbox:
  ///   Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.
  Future<Package?> twoPhasePurchasePackageProcessHandler(String acceptLanguage, String authorization, PurchasePackageProcessHandlerRequest purchasePackageProcessHandlerRequest, { int? limit, int? offset, List<num>? bbox, }) async {
    final response = await twoPhasePurchasePackageProcessHandlerWithHttpInfo(acceptLanguage, authorization, purchasePackageProcessHandlerRequest,  limit: limit, offset: offset, bbox: bbox, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }

  /// Update traveller processes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [UpdateTravellerHandlerRequest] updateTravellerHandlerRequest (required):
  Future<Response> updateTravellerHandlerWithHttpInfo(String acceptLanguage, String authorization, UpdateTravellerHandlerRequest updateTravellerHandlerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/update-traveller/execute';

    // ignore: prefer_final_locals
    Object? postBody = updateTravellerHandlerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update traveller processes
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [UpdateTravellerHandlerRequest] updateTravellerHandlerRequest (required):
  Future<Package?> updateTravellerHandler(String acceptLanguage, String authorization, UpdateTravellerHandlerRequest updateTravellerHandlerRequest,) async {
    final response = await updateTravellerHandlerWithHttpInfo(acceptLanguage, authorization, updateTravellerHandlerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Package',) as Package;
    
    }
    return null;
  }
}

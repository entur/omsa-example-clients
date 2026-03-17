//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CollectionsApi {
  CollectionsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Handles ancillaries collections
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] packageId (required):
  ///   the identifier of a package
  ///
  /// * [String] legId (required):
  ///   leg identifier
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  Future<Response> ancillariesCollectionHandlerWithHttpInfo(String packageId, String legId, String acceptLanguage, String authorization, { int? limit, int? offset, }) async {
    // ignore: prefer_const_declarations
    final path = r'/collections/ancillaries/items';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'packageId', packageId));
      queryParams.addAll(_queryParams('', 'legId', legId));
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (offset != null) {
      queryParams.addAll(_queryParams('', 'offset', offset));
    }

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles ancillaries collections
  ///
  /// Parameters:
  ///
  /// * [String] packageId (required):
  ///   the identifier of a package
  ///
  /// * [String] legId (required):
  ///   leg identifier
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  Future<List<AncillaryCollection>?> ancillariesCollectionHandler(String packageId, String legId, String acceptLanguage, String authorization, { int? limit, int? offset, }) async {
    final response = await ancillariesCollectionHandlerWithHttpInfo(packageId, legId, acceptLanguage, authorization,  limit: limit, offset: offset, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<AncillaryCollection>') as List)
        .cast<AncillaryCollection>()
        .toList(growable: false);

    }
    return null;
  }

  /// Handles asset collections
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] packageId (required):
  ///   the identifier of a package
  ///
  /// * [String] legId (required):
  ///   leg identifier
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  ///
  /// * [List<num>] bbox:
  ///   Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.
  Future<Response> assetCollectionHandlerWithHttpInfo(String packageId, String legId, String acceptLanguage, String authorization, { int? limit, int? offset, List<num>? bbox, }) async {
    // ignore: prefer_const_declarations
    final path = r'/collections/assets/items';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'packageId', packageId));
      queryParams.addAll(_queryParams('', 'legId', legId));
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

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles asset collections
  ///
  /// Parameters:
  ///
  /// * [String] packageId (required):
  ///   the identifier of a package
  ///
  /// * [String] legId (required):
  ///   leg identifier
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  ///
  /// * [List<num>] bbox:
  ///   Only features that have a geometry that intersects the bounding box are selected. The bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth): * Lower left corner, coordinate axis 1 * Lower left corner, coordinate axis 2 * Minimum value, coordinate axis 3 (optional) * Upper right corner, coordinate axis 1 * Upper right corner, coordinate axis 2 * Maximum value, coordinate axis 3 (optional) If the value consists of four numbers, the coordinate reference system is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84) unless a different coordinate reference system is specified in the parameter `bbox-crs`. If the value consists of six numbers, the coordinate reference system is WGS 84 longitude/latitude/ellipsoidal height (http://www.opengis.net/def/crs/OGC/0/CRS84h) unless a different coordinate reference system is specified in the parameter `bbox-crs`. The query parameter `bbox-crs` is specified in OGC API - Features - Part 2: Coordinate Reference Systems by Reference. For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude. However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge). If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. If a feature has multiple spatial geometry properties, it is the decision of the server whether only a single spatial geometry property is used to determine the extent or all relevant geometries.
  Future<Geojson?> assetCollectionHandler(String packageId, String legId, String acceptLanguage, String authorization, { int? limit, int? offset, List<num>? bbox, }) async {
    final response = await assetCollectionHandlerWithHttpInfo(packageId, legId, acceptLanguage, authorization,  limit: limit, offset: offset, bbox: bbox, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Geojson',) as Geojson;
    
    }
    return null;
  }

  /// Handles change options collections
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] packageId (required):
  ///   the identifier of a package
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [String] legId:
  ///   leg identifier
  Future<Response> changeOptionHandlerWithHttpInfo(String packageId, String acceptLanguage, String authorization, { String? legId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/collections/change-options/items';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'packageId', packageId));
    if (legId != null) {
      queryParams.addAll(_queryParams('', 'legId', legId));
    }

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles change options collections
  ///
  /// Parameters:
  ///
  /// * [String] packageId (required):
  ///   the identifier of a package
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [String] legId:
  ///   leg identifier
  Future<ChangeOptionCollection?> changeOptionHandler(String packageId, String acceptLanguage, String authorization, { String? legId, }) async {
    final response = await changeOptionHandlerWithHttpInfo(packageId, acceptLanguage, authorization,  legId: legId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ChangeOptionCollection',) as ChangeOptionCollection;
    
    }
    return null;
  }

  /// Retrieves all (external) datasources, that are used in requests and responses
  ///
  /// Retrieves all datasources
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  Future<Response> getDataSourcesWithHttpInfo(String acceptLanguage, String authorization,) async {
    // ignore: prefer_const_declarations
    final path = r'/collections/datasources/items';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Retrieves all (external) datasources, that are used in requests and responses
  ///
  /// Retrieves all datasources
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  Future<List<Link>?> getDataSources(String acceptLanguage, String authorization,) async {
    final response = await getDataSourcesWithHttpInfo(acceptLanguage, authorization,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Link>') as List)
        .cast<Link>()
        .toList(growable: false);

    }
    return null;
  }

  /// Retrieve a single package
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
  /// * [String] packageId (required):
  ///   The unique identifier of the package to retrieve
  Future<Response> getPackageWithHttpInfo(String acceptLanguage, String authorization, String packageId,) async {
    // ignore: prefer_const_declarations
    final path = r'/collections/packages/items/{packageId}'
      .replaceAll('{packageId}', packageId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Retrieve a single package
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [String] packageId (required):
  ///   The unique identifier of the package to retrieve
  Future<Package?> getPackage(String acceptLanguage, String authorization, String packageId,) async {
    final response = await getPackageWithHttpInfo(acceptLanguage, authorization, packageId,);
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

  /// Retrieve a history of purchased packages
  ///
  /// Returns a paginated list of packages belonging to the authenticated user.
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
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  ///
  /// * [String] packageId:
  ///   the identifier of a package
  ///
  /// * [PackageStatus] status:
  ///   Filter packages by their lifecycle status (e.g. CONFIRMED, CANCELLED)
  Future<Response> packageCollectionHandlerWithHttpInfo(String acceptLanguage, String authorization, { int? limit, int? offset, String? packageId, PackageStatus? status, }) async {
    // ignore: prefer_const_declarations
    final path = r'/collections/packages/items';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (offset != null) {
      queryParams.addAll(_queryParams('', 'offset', offset));
    }
    if (packageId != null) {
      queryParams.addAll(_queryParams('', 'packageId', packageId));
    }
    if (status != null) {
      queryParams.addAll(_queryParams('', 'status', status));
    }

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Retrieve a history of purchased packages
  ///
  /// Returns a paginated list of packages belonging to the authenticated user.
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [int] limit:
  ///   The optional limit parameter limits the number of items that are presented in the response document. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Minimum = 1. Maximum = 10000. Default = 100.
  ///
  /// * [int] offset:
  ///   The optional offset parameter representing the starting index of the returned collection. Only items are counted that are on the first level of the collection in the response document. Nested objects contained within the explicitly requested items shall not be counted. Default = 0.
  ///
  /// * [String] packageId:
  ///   the identifier of a package
  ///
  /// * [PackageStatus] status:
  ///   Filter packages by their lifecycle status (e.g. CONFIRMED, CANCELLED)
  Future<PackageCollection?> packageCollectionHandler(String acceptLanguage, String authorization, { int? limit, int? offset, String? packageId, PackageStatus? status, }) async {
    final response = await packageCollectionHandlerWithHttpInfo(acceptLanguage, authorization,  limit: limit, offset: offset, packageId: packageId, status: status, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PackageCollection',) as PackageCollection;
    
    }
    return null;
  }

  /// Handles refund options collections
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] packageId (required):
  ///   the identifier of a package
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [String] legId:
  ///   leg identifier
  ///
  /// * [String] travellerId:
  ///   traveller identifier
  ///
  /// * [String] ancillaryId:
  ///   ancillary identifier
  Future<Response> refundOptionHandlerWithHttpInfo(String packageId, String acceptLanguage, String authorization, { String? legId, String? travellerId, String? ancillaryId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/collections/refund-options/items';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'packageId', packageId));
    if (legId != null) {
      queryParams.addAll(_queryParams('', 'legId', legId));
    }
    if (travellerId != null) {
      queryParams.addAll(_queryParams('', 'travellerId', travellerId));
    }
    if (ancillaryId != null) {
      queryParams.addAll(_queryParams('', 'ancillaryId', ancillaryId));
    }

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles refund options collections
  ///
  /// Parameters:
  ///
  /// * [String] packageId (required):
  ///   the identifier of a package
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [String] legId:
  ///   leg identifier
  ///
  /// * [String] travellerId:
  ///   traveller identifier
  ///
  /// * [String] ancillaryId:
  ///   ancillary identifier
  Future<RefundOptionCollection?> refundOptionHandler(String packageId, String acceptLanguage, String authorization, { String? legId, String? travellerId, String? ancillaryId, }) async {
    final response = await refundOptionHandlerWithHttpInfo(packageId, acceptLanguage, authorization,  legId: legId, travellerId: travellerId, ancillaryId: ancillaryId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RefundOptionCollection',) as RefundOptionCollection;
    
    }
    return null;
  }

  /// Handles travel documents
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
  /// * [String] packageId (required):
  ///   the identifier of a package
  ///
  /// * [String] legId:
  ///   leg identifier
  Future<Response> traveldocumentsCollectionHandlerWithHttpInfo(String acceptLanguage, String authorization, String packageId, { String? legId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/collections/travel-documents/items';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'packageId', packageId));
    if (legId != null) {
      queryParams.addAll(_queryParams('', 'legId', legId));
    }

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    headerParams[r'authorization'] = parameterToString(authorization);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Handles travel documents
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] authorization (required):
  ///   Header field, JWT must be supplied
  ///
  /// * [String] packageId (required):
  ///   the identifier of a package
  ///
  /// * [String] legId:
  ///   leg identifier
  Future<TravelDocumentCollection?> traveldocumentsCollectionHandler(String acceptLanguage, String authorization, String packageId, { String? legId, }) async {
    final response = await traveldocumentsCollectionHandlerWithHttpInfo(acceptLanguage, authorization, packageId,  legId: legId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TravelDocumentCollection',) as TravelDocumentCollection;
    
    }
    return null;
  }
}

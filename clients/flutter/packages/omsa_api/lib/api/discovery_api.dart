//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class DiscoveryApi {
  DiscoveryApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// This document
  ///
  /// This document
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] f:
  ///   The optional f parameter indicates the output format that the server shall provide as part of the response document.  The default format is JSON.
  Future<Response> apiGetWithHttpInfo({ String? f, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (f != null) {
      queryParams.addAll(_queryParams('', 'f', f));
    }

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

  /// This document
  ///
  /// This document
  ///
  /// Parameters:
  ///
  /// * [String] f:
  ///   The optional f parameter indicates the output format that the server shall provide as part of the response document.  The default format is JSON.
  Future<String?> apiGet({ String? f, }) async {
    final response = await apiGetWithHttpInfo( f: f, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'String',) as String;
    
    }
    return null;
  }

  /// describe the feature collection with id `collectionId`
  ///
  /// a (machine or human) readable description of this collection
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] collectionId (required):
  ///   local identifier of a collection
  ///
  /// * [String] acceptLanguage (required):
  Future<Response> describeCollectionWithHttpInfo(String collectionId, String acceptLanguage,) async {
    // ignore: prefer_const_declarations
    final path = r'/collections/{collectionId}'
      .replaceAll('{collectionId}', collectionId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);

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

  /// describe the feature collection with id `collectionId`
  ///
  /// a (machine or human) readable description of this collection
  ///
  /// Parameters:
  ///
  /// * [String] collectionId (required):
  ///   local identifier of a collection
  ///
  /// * [String] acceptLanguage (required):
  Future<CollectionInfo?> describeCollection(String collectionId, String acceptLanguage,) async {
    final response = await describeCollectionWithHttpInfo(collectionId, acceptLanguage,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CollectionInfo',) as CollectionInfo;
    
    }
    return null;
  }

  /// the feature collections in the dataset
  ///
  /// returns a collection of available collection (like offers, packages, legs, support-requests and payments)
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getCollectionsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/collections';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

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

  /// the feature collections in the dataset
  ///
  /// returns a collection of available collection (like offers, packages, legs, support-requests and payments)
  Future<Collections?> getCollections() async {
    final response = await getCollectionsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Collections',) as Collections;
    
    }
    return null;
  }

  /// API conformance definition
  ///
  /// A list of all conformance classes specified in a standard that the server conforms to.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] f:
  ///   The optional f parameter indicates the output format that the server shall provide as part of the response document.  The default format is JSON.
  Future<Response> getConformanceDeclarationWithHttpInfo(String acceptLanguage, { String? f, }) async {
    // ignore: prefer_const_declarations
    final path = r'/conformance';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (f != null) {
      queryParams.addAll(_queryParams('', 'f', f));
    }

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);

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

  /// API conformance definition
  ///
  /// A list of all conformance classes specified in a standard that the server conforms to.
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] f:
  ///   The optional f parameter indicates the output format that the server shall provide as part of the response document.  The default format is JSON.
  Future<ConfClasses?> getConformanceDeclaration(String acceptLanguage, { String? f, }) async {
    final response = await getConformanceDeclarationWithHttpInfo(acceptLanguage,  f: f, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ConfClasses',) as ConfClasses;
    
    }
    return null;
  }

  /// retrieve a process description
  ///
  /// The process description contains information about inputs and outputs and a link to the execution-endpoint for the process. The Core does not mandate the use of a specific process description to specify the interface of a process. That said, the Core requirements class makes the following recommendation: Implementations SHOULD consider supporting the OGC process description. For more information, see [Section 7.10](https://docs.ogc.org/is/18-062/18-062.html#sc_process_description). 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] processID (required):
  Future<Response> getProcessDescriptionWithHttpInfo(String acceptLanguage, String processID,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes/{processID}'
      .replaceAll('{processID}', processID);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);

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

  /// retrieve a process description
  ///
  /// The process description contains information about inputs and outputs and a link to the execution-endpoint for the process. The Core does not mandate the use of a specific process description to specify the interface of a process. That said, the Core requirements class makes the following recommendation: Implementations SHOULD consider supporting the OGC process description. For more information, see [Section 7.10](https://docs.ogc.org/is/18-062/18-062.html#sc_process_description). 
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] processID (required):
  Future<Object?> getProcessDescription(String acceptLanguage, String processID,) async {
    final response = await getProcessDescriptionWithHttpInfo(acceptLanguage, processID,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Object',) as Object;
    
    }
    return null;
  }

  /// retrieve the list of available processes
  ///
  /// The list of processes contains a summary of each process the OGC API - Processes offers, including the link to a more detailed description of the process.  For more information, see [Section 7.9](https://docs.ogc.org/is/18-062/18-062.html#sc_process_list). 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  Future<Response> getProcessesWithHttpInfo(String acceptLanguage,) async {
    // ignore: prefer_const_declarations
    final path = r'/processes';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);

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

  /// retrieve the list of available processes
  ///
  /// The list of processes contains a summary of each process the OGC API - Processes offers, including the link to a more detailed description of the process.  For more information, see [Section 7.9](https://docs.ogc.org/is/18-062/18-062.html#sc_process_list). 
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  Future<ProcessList?> getProcesses(String acceptLanguage,) async {
    final response = await getProcessesWithHttpInfo(acceptLanguage,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProcessList',) as ProcessList;
    
    }
    return null;
  }

  /// Landing page
  ///
  /// Gives a (technical & human readable) output describing how this API must be used. If  the parameter f=html is supplied, a human readable page must be responded.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] f:
  ///   The optional f parameter indicates the output format that the server shall provide as part of the response document.  The default format is JSON.
  Future<Response> landingPageWithHttpInfo(String acceptLanguage, { String? f, }) async {
    // ignore: prefer_const_declarations
    final path = r'/';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (f != null) {
      queryParams.addAll(_queryParams('', 'f', f));
    }

    headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);

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

  /// Landing page
  ///
  /// Gives a (technical & human readable) output describing how this API must be used. If  the parameter f=html is supplied, a human readable page must be responded.
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage (required):
  ///
  /// * [String] f:
  ///   The optional f parameter indicates the output format that the server shall provide as part of the response document.  The default format is JSON.
  Future<LandingPage?> landingPage(String acceptLanguage, { String? f, }) async {
    final response = await landingPageWithHttpInfo(acceptLanguage,  f: f, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LandingPage',) as LandingPage;
    
    }
    return null;
  }
}

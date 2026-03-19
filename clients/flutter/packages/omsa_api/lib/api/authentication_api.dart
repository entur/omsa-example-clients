//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AuthenticationApi {
  AuthenticationApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Token Endpoint
  ///
  /// This endpoint is used to obtain an access token and optionally an ID token through different OAuth 2.0 grant types, including Client Credentials Flow. Whenever the mTLS flow is taken, the properties will be ignored, and the access token will be generated based on the credentials in the certificate (O or CN).
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] grantType:
  ///   The grant type: 'client_credentials', 'password', or 'refresh_token'.
  ///
  /// * [String] username:
  ///   The username
  ///
  /// * [String] password:
  ///   The password
  ///
  /// * [String] clientId:
  ///   The client ID (Client Credentials Flow)
  ///
  /// * [String] clientSecret:
  ///   The client secret (Client Credentials Flow)
  Future<Response> oauthTokenPostWithHttpInfo({ String? grantType, String? username, String? password, String? clientId, String? clientSecret, }) async {
    // ignore: prefer_const_declarations
    final path = r'/oauth/token';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/x-www-form-urlencoded'];

    if (grantType != null) {
      formParams[r'grant_type'] = parameterToString(grantType);
    }
    if (username != null) {
      formParams[r'username'] = parameterToString(username);
    }
    if (password != null) {
      formParams[r'password'] = parameterToString(password);
    }
    if (clientId != null) {
      formParams[r'client_id'] = parameterToString(clientId);
    }
    if (clientSecret != null) {
      formParams[r'client_secret'] = parameterToString(clientSecret);
    }

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

  /// Token Endpoint
  ///
  /// This endpoint is used to obtain an access token and optionally an ID token through different OAuth 2.0 grant types, including Client Credentials Flow. Whenever the mTLS flow is taken, the properties will be ignored, and the access token will be generated based on the credentials in the certificate (O or CN).
  ///
  /// Parameters:
  ///
  /// * [String] grantType:
  ///   The grant type: 'client_credentials', 'password', or 'refresh_token'.
  ///
  /// * [String] username:
  ///   The username
  ///
  /// * [String] password:
  ///   The password
  ///
  /// * [String] clientId:
  ///   The client ID (Client Credentials Flow)
  ///
  /// * [String] clientSecret:
  ///   The client secret (Client Credentials Flow)
  Future<OauthTokenPost200Response?> oauthTokenPost({ String? grantType, String? username, String? password, String? clientId, String? clientSecret, }) async {
    final response = await oauthTokenPostWithHttpInfo( grantType: grantType, username: username, password: password, clientId: clientId, clientSecret: clientSecret, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'OauthTokenPost200Response',) as OauthTokenPost200Response;
    
    }
    return null;
  }
}

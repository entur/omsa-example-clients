//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SearchOfferInput {
  /// Returns a new [SearchOfferInput] instance.
  SearchOfferInput({
    required this.type,
    this.timestamp,
    this.specification,
    this.pattern = const [],
    this.packageToExchange,
    this.travellers = const [],
    this.profiles = const [],
    this.travellingAssets = const [],
  });

  String type;

  /// https://www.rfc-editor.org/rfc/rfc3339#section-5.6, date-time (2019-10-12T07:20:50.52Z)
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? timestamp;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TravelSpecification? specification;

  List<TripPatternInner> pattern;

  /// default string, full names etc (length 0-200)
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? packageToExchange;

  List<IndividualTraveller> travellers;

  List<UserProfile> profiles;

  List<TravellingAsset> travellingAssets;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SearchOfferInput &&
    other.type == type &&
    other.timestamp == timestamp &&
    other.specification == specification &&
    _deepEquality.equals(other.pattern, pattern) &&
    other.packageToExchange == packageToExchange &&
    _deepEquality.equals(other.travellers, travellers) &&
    _deepEquality.equals(other.profiles, profiles) &&
    _deepEquality.equals(other.travellingAssets, travellingAssets);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (type.hashCode) +
    (timestamp == null ? 0 : timestamp!.hashCode) +
    (specification == null ? 0 : specification!.hashCode) +
    (pattern.hashCode) +
    (packageToExchange == null ? 0 : packageToExchange!.hashCode) +
    (travellers.hashCode) +
    (profiles.hashCode) +
    (travellingAssets.hashCode);

  @override
  String toString() => 'SearchOfferInput[type=$type, timestamp=$timestamp, specification=$specification, pattern=$pattern, packageToExchange=$packageToExchange, travellers=$travellers, profiles=$profiles, travellingAssets=$travellingAssets]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'type'] = this.type;
    if (this.timestamp != null) {
      json[r'timestamp'] = this.timestamp!.toUtc().toIso8601String();
    } else {
      json[r'timestamp'] = null;
    }
    if (this.specification != null) {
      json[r'specification'] = this.specification;
    } else {
      json[r'specification'] = null;
    }
      json[r'pattern'] = this.pattern;
    if (this.packageToExchange != null) {
      json[r'packageToExchange'] = this.packageToExchange;
    } else {
      json[r'packageToExchange'] = null;
    }
      json[r'travellers'] = this.travellers;
      json[r'profiles'] = this.profiles;
      json[r'travellingAssets'] = this.travellingAssets;
    return json;
  }

  /// Returns a new [SearchOfferInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SearchOfferInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SearchOfferInput[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SearchOfferInput[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SearchOfferInput(
        type: mapValueOfType<String>(json, r'type')!,
        timestamp: mapDateTime(json, r'timestamp', r''),
        specification: TravelSpecification.fromJson(json[r'specification']),
        pattern: TripPatternInner.listFromJson(json[r'pattern']),
        packageToExchange: mapValueOfType<String>(json, r'packageToExchange'),
        travellers: IndividualTraveller.listFromJson(json[r'travellers']),
        profiles: UserProfile.listFromJson(json[r'profiles']),
        travellingAssets: TravellingAsset.listFromJson(json[r'travellingAssets']),
      );
    }
    return null;
  }

  static List<SearchOfferInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SearchOfferInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SearchOfferInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SearchOfferInput> mapFromJson(dynamic json) {
    final map = <String, SearchOfferInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SearchOfferInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SearchOfferInput-objects as value to a dart map
  static Map<String, List<SearchOfferInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SearchOfferInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SearchOfferInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'type',
  };
}


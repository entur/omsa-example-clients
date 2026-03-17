//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Error {
  /// Returns a new [Error] instance.
  Error({
    this.errorcode = 0,
    this.type,
    required this.title,
    this.status = 0,
    this.detail,
    this.instance,
    this.links = const [],
  });

  /// for really small numbers (0-10)
  ///
  /// Minimum value: 0
  /// Maximum value: 10
  int errorcode;

  /// real short string, codes (length 0-10)
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? type;

  /// short string, display names (length 0-75)
  String title;

  /// for really small numbers (0-10)
  ///
  /// Minimum value: 0
  /// Maximum value: 10
  int status;

  /// long string, memos etc (length 0-10.000)
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? detail;

  /// valid URL
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? instance;

  List<Link> links;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Error &&
    other.errorcode == errorcode &&
    other.type == type &&
    other.title == title &&
    other.status == status &&
    other.detail == detail &&
    other.instance == instance &&
    _deepEquality.equals(other.links, links);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (errorcode.hashCode) +
    (type == null ? 0 : type!.hashCode) +
    (title.hashCode) +
    (status.hashCode) +
    (detail == null ? 0 : detail!.hashCode) +
    (instance == null ? 0 : instance!.hashCode) +
    (links.hashCode);

  @override
  String toString() => 'Error[errorcode=$errorcode, type=$type, title=$title, status=$status, detail=$detail, instance=$instance, links=$links]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'errorcode'] = this.errorcode;
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
      json[r'title'] = this.title;
      json[r'status'] = this.status;
    if (this.detail != null) {
      json[r'detail'] = this.detail;
    } else {
      json[r'detail'] = null;
    }
    if (this.instance != null) {
      json[r'instance'] = this.instance;
    } else {
      json[r'instance'] = null;
    }
      json[r'links'] = this.links;
    return json;
  }

  /// Returns a new [Error] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Error? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Error[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Error[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Error(
        errorcode: mapValueOfType<int>(json, r'errorcode')!,
        type: mapValueOfType<String>(json, r'type'),
        title: mapValueOfType<String>(json, r'title')!,
        status: mapValueOfType<int>(json, r'status') ?? 0,
        detail: mapValueOfType<String>(json, r'detail'),
        instance: mapValueOfType<String>(json, r'instance'),
        links: Link.listFromJson(json[r'links']),
      );
    }
    return null;
  }

  static List<Error> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Error>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Error.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Error> mapFromJson(dynamic json) {
    final map = <String, Error>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Error.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Error-objects as value to a dart map
  static Map<String, List<Error>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Error>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Error.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'errorcode',
    'title',
  };
}


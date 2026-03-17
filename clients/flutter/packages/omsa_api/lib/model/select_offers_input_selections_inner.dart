//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SelectOffersInputSelectionsInner {
  /// Returns a new [SelectOffersInputSelectionsInner] instance.
  SelectOffersInputSelectionsInner({
    required this.offerId,
    this.selectedAncillaryIds = const [],
  });

  /// default string, full names etc (length 0-200)
  String offerId;

  /// List of ancillaryIds to include specifically for this offer instance.
  List<AncillaryReference> selectedAncillaryIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SelectOffersInputSelectionsInner &&
    other.offerId == offerId &&
    _deepEquality.equals(other.selectedAncillaryIds, selectedAncillaryIds);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (offerId.hashCode) +
    (selectedAncillaryIds.hashCode);

  @override
  String toString() => 'SelectOffersInputSelectionsInner[offerId=$offerId, selectedAncillaryIds=$selectedAncillaryIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'offerId'] = this.offerId;
      json[r'selectedAncillaryIds'] = this.selectedAncillaryIds;
    return json;
  }

  /// Returns a new [SelectOffersInputSelectionsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SelectOffersInputSelectionsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SelectOffersInputSelectionsInner[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SelectOffersInputSelectionsInner[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SelectOffersInputSelectionsInner(
        offerId: mapValueOfType<String>(json, r'offerId')!,
        selectedAncillaryIds: AncillaryReference.listFromJson(json[r'selectedAncillaryIds']),
      );
    }
    return null;
  }

  static List<SelectOffersInputSelectionsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SelectOffersInputSelectionsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SelectOffersInputSelectionsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SelectOffersInputSelectionsInner> mapFromJson(dynamic json) {
    final map = <String, SelectOffersInputSelectionsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SelectOffersInputSelectionsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SelectOffersInputSelectionsInner-objects as value to a dart map
  static Map<String, List<SelectOffersInputSelectionsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SelectOffersInputSelectionsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SelectOffersInputSelectionsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'offerId',
  };
}


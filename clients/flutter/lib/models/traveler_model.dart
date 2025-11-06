import 'package:uuid/uuid.dart';

enum TravelerCategory {
  senior(label: 'Senior', subtitle: '67+ years', minAge: 67, maxAge: 120),
  adult(label: 'Adult', subtitle: '23+ years', minAge: 23, maxAge: 66),
  youth(label: 'Youth', subtitle: '15-22 years', minAge: 15, maxAge: 22),
  child(label: 'Child', subtitle: '6-15 years', minAge: 6, maxAge: 14),
  infant(label: 'Infant', subtitle: '0-5 years', minAge: 0, maxAge: 5);

  final String label;
  final String subtitle;
  final int minAge;
  final int maxAge;

  const TravelerCategory({
    required this.label,
    required this.subtitle,
    required this.minAge,
    required this.maxAge,
  });

  static TravelerCategory fromAge(int age) {
    if (age >= 67) return senior;
    if (age >= 23) return adult;
    if (age >= 15) return youth;
    if (age >= 6) return child;
    return infant;
  }
}

enum Entitlement {
  student(label: 'Student', comingSoon: true),
  military(label: 'Military', comingSoon: true);

  final String label;
  final bool comingSoon;

  const Entitlement({required this.label, this.comingSoon = false});
}

class Traveler {
  final String id;
  final int age;
  final bool isDefaultTraveler;
  final List<Entitlement> entitlements;

  Traveler({
    String? id,
    required this.age,
    this.isDefaultTraveler = false,
    this.entitlements = const [],
  }) : id = id ?? const Uuid().v4();

  TravelerCategory get category => TravelerCategory.fromAge(age);

  String get displayName {
    if (isDefaultTraveler) return 'You';
    return category.label;
  }

  String get displaySummary {
    final parts = <String>['$age years'];
    if (entitlements.isNotEmpty) {
      parts.addAll(entitlements.map((e) => e.label));
    }
    return parts.join(', ');
  }

  Traveler copyWith({
    int? age,
    bool? isDefaultTraveler,
    List<Entitlement>? entitlements,
  }) {
    return Traveler(
      id: id,
      age: age ?? this.age,
      isDefaultTraveler: isDefaultTraveler ?? this.isDefaultTraveler,
      entitlements: entitlements ?? this.entitlements,
    );
  }

  // Convert to API format
  Map<String, dynamic> toApiTraveler() {
    return {
      'age': age,
      'entitlements': entitlements.map((e) => e.name.toUpperCase()).toList(),
    };
  }

  static Traveler defaultTraveler() {
    return Traveler(age: 22, isDefaultTraveler: true);
  }
}

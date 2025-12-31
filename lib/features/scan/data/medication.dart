import 'dart:convert';

class Medication {
  final String name;
  final String dosage;
  final String frequency;
  final String usage;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.usage,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'] ?? '',
      dosage: json['dosage'] ?? '',
      frequency: json['frequency'] ?? '',
      usage: json['usage'] ?? '',
    );
  }

  static List<Medication> fromJsonList(String jsonString) {
    try {
      final List<dynamic> list = json.decode(jsonString);
      return list.map((e) => Medication.fromJson(e)).toList();
    } catch (e) {
      // If parsing fails or it's not a list, return empty
      return [];
    }
  }
}

import 'package:hive_flutter/hive_flutter.dart';
import '../data/medication.dart';

class HistoryService {
  static const String _boxName = 'scan_history';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  Future<void> saveScan({
    required String imagePath,
    required List<Medication> medications,
  }) async {
    final box = Hive.box(_boxName);
    final timestamp = DateTime.now().toIso8601String();

    // Store as simple Map
    final item = {
      'id': timestamp, // Use timestamp as ID for simplicity
      'imagePath': imagePath,
      'timestamp': timestamp,
      'medications': medications
          .map(
            (m) => {
              'name': m.name,
              'dosage': m.dosage,
              'frequency': m.frequency,
              'usage': m.usage,
            },
          )
          .toList(),
    };

    await box.add(item);
  }

  List<Map<String, dynamic>> getHistory() {
    final box = Hive.box(_boxName);
    final List<Map<String, dynamic>> history = [];

    // Iterate keys/values safely
    for (var i = 0; i < box.length; i++) {
      final raw = box.getAt(i);
      if (raw is Map) {
        // Convert dynamic map to string keys
        history.add(Map<String, dynamic>.from(raw));
      }
    }

    // Sort by newest first
    history.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
    return history;
  }

  Future<void> clearHistory() async {
    final box = Hive.box(_boxName);
    await box.clear();
  }
}

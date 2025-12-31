import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../constants/app_constants.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: AppConstants.geminiApiKey,
    );
  }

  Future<String?> analyzePrescription(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    final content = [
      Content.multi([
        TextPart(
          'قم بتحليل صورة الروشتة هذه. استخرج المعلومات التالية لكل دواء موجود: الاسم (Name)، الجرعة (Dosage)، التكرار (Frequency)، وتعليمات الاستخدام (Usage). أرجِع النتيجة كسلسلة JSON خام (بدون checkticks) كقائمة من الكائنات بالمفاتيح: "name", "dosage", "frequency", "usage". جميع القيم يجب أن تكون باللغة العربية. إذا كانت الصورة ليست روشتة أو غير واضحة، أرجِع "INVALID".',
        ),
        DataPart('image/jpeg', imageBytes),
      ]),
    ];

    final response = await _model.generateContent(content);
    return response.text;
  }
}

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/gemini_service.dart';
import '../../../core/services/image_picker_service.dart';
import '../data/medication.dart';
import 'history_service.dart';
import 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  final ImagePickerService _imagePickerService;
  final GeminiService _geminiService;
  final HistoryService _historyService;

  ScanCubit(this._imagePickerService, this._geminiService, this._historyService)
    : super(ScanInitial());

  Future<void> pickImage(ImageSource source) async {
    emit(ScanLoading());
    final pickedFile = await _imagePickerService.pickImage(source);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      emit(ScanImagePicked(imageFile));
      // Optionally analyze immediately
      analyzeImage(imageFile);
    } else {
      emit(
        ScanInitial(),
      ); // Or Error if needed, but Initial is fine for cancellation
    }
  }

  Future<void> analyzeImage(File image) async {
    emit(ScanLoading());
    try {
      final resultString = await _geminiService.analyzePrescription(image);

      if (resultString == null) {
        emit(
          const ScanError(
            'فشل الاتصال بخدمة التحليل. تأكد من الإنترنت ومفتاح API.',
          ),
        );
        return;
      }

      if (resultString.trim() == 'INVALID') {
        emit(const ScanError('لم يتم التعرف على روشتة في هذه الصورة.'));
        return;
      }

      // Cleanup markdown code blocks if Gemini adds them
      String cleanersResult = resultString
          .replaceAll('```json', '')
          .replaceAll('```', '');

      final medications = Medication.fromJsonList(cleanersResult);
      if (medications.isEmpty) {
        emit(const ScanError('لم يتم العثور على أدوية أو التنسيق غير صالح.'));
      } else {
        await _historyService.saveScan(
          imagePath: image.path,
          medications: medications,
        );
        emit(ScanSuccess(medications, image));
      }
    } catch (e) {
      emit(ScanError('خطأ: $e')); // Show the actual error
    }
  }

  void reset() {
    emit(ScanInitial());
  }
}

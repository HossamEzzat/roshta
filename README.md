
# Roshta (روشتة) 💊

**Roshta** is an intelligent Flutter application designed to help users understand their medical prescriptions easily using Artificial Intelligence (AI). By simply scanning or uploading a prescription, the app analyzes the handwriting and extracts medication details in a clear, readable format.

## ✨ Features

- **AI-Powered Analysis**: Utilizes Google Gemini 1.5 Flash to decipher handwritten prescriptions with high accuracy.
- **Smart Scanning**: Capture images via Camera or pick from Gallery with integrated **Smart Cropping** to focus on the text.
- **Detailed Results**: Extracts and displays:
  - Medication Name
  - Dosage
  - Frequency
  - Usage Instructions
- **History (سجل الفحوصات)**: Automatically saves past scans locally using **Hive** for offline access.
- **Zoom & Inspect**: Pinch-to-zoom functionality to review the original prescription image alongside results.
- **Arabic Localization**: Fully localized interface and AI responses in Arabic (Egypt/Middle East focus).
- **Premium UI**: Modern, dark-themed design with smooth animations and intuitive navigation.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- **AI Model**: [Google Generative AI (Gemini)](https://pub.dev/packages/google_generative_ai)
- **Local Storage**: [Hive](https://pub.dev/packages/hive)
- **Image Handling**: `image_picker`, `image_cropper`, `photo_view`
- **UI/UX**: `flutter_animate`, `lottie`, `google_fonts` (Cairo Font)

## 📄 License

by Hossam Ezzat

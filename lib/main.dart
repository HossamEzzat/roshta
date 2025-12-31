import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/services/gemini_service.dart';
import 'core/services/image_picker_service.dart';
import 'core/theme/app_theme.dart';
import 'core/ui/splash_screen.dart';
import 'features/scan/logic/scan_cubit.dart';

import 'features/scan/logic/history_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final historyService = HistoryService();
  await historyService.init();

  runApp(RoshtaApp(historyService: historyService));
}

class RoshtaApp extends StatelessWidget {
  final HistoryService historyService;
  const RoshtaApp({super.key, required this.historyService});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => ImagePickerService()),
        RepositoryProvider(create: (_) => GeminiService()),
        RepositoryProvider.value(value: historyService),
      ],
      child: BlocProvider(
        create: (context) => ScanCubit(
          context.read<ImagePickerService>(),
          context.read<GeminiService>(),
          historyService,
        ),
        child: MaterialApp(
          title: 'روشتة',
          debugShowCheckedModeBanner: false,

          // Localization
          locale: const Locale('ar'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar')],

          // Theme
          theme: AppTheme.darkTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,

          home: const SplashScreen(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tab_newz/core/app_router.dart';
import 'package:tab_newz/theme/app_theme.dart';

class TabNewzApp extends StatelessWidget {
  const TabNewzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme().light,
      darkTheme: AppTheme().dark,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter().start,
    );
  }
}

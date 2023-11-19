

import 'package:flutter/material.dart';
import 'package:tab_newz/home_news/view/home_page.dart';
import 'package:tab_newz/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().light,
      darkTheme: AppTheme().dark,
      themeMode: ThemeMode.system,
      home: HomePage()
    );
  }
}

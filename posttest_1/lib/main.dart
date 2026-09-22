import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const FutsalKuApp());
}

class FutsalKuApp extends StatelessWidget {
  const FutsalKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FutsalKu',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

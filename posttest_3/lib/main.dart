import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/home_page.dart';
import 'screens/lapangan_page.dart';
import 'screens/booking_page.dart';
import 'screens/profil_page.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/lapangan': (context) => const LapanganPage(),
        '/booking': (context) => const BookingPage(),
        '/profil': (context) => const ProfilPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/booking_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/user_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}

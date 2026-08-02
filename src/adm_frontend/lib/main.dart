import 'package:flutter/material.dart';
import 'screens/kiosk_home_page.dart';

void main() {
  runApp(const ADMKioskApp());
}

class ADMKioskApp extends StatelessWidget {
  const ADMKioskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ADM Kiosk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      home: const KioskHomePage(),
    );
  }
}

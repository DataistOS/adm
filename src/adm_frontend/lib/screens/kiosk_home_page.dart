import 'package:flutter/material.dart';
import 'catalog_page.dart';

class KioskHomePage extends StatelessWidget {
  const KioskHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey.shade900, Colors.black87],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.devices_other,
                size: 100,
                color: Colors.cyanAccent,
              ),
              const SizedBox(height: 24),
              const Text(
                'به دستگاه توزیع محتوای دیتائیست (ADM) خوش آمدید',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'برای دریافت محتوا، مستندات و پکیج‌های آفلاین، صفحه را لمس کنید',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                // در بخش onPressed دکمه:
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CatalogPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.touch_app, size: 28),
                label: const Text(
                  'شروع دریافت محتوا',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

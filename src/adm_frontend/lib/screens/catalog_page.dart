import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final String apiUrl = 'http://localhost:9090/api/categories';

  Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    } else {
      throw Exception('خطا در دریافت اطلاعات از بک‌اند');
    }
  }

  IconData _getIconForTitle(String title) {
    if (title.contains('فیلم')) return Icons.movie;
    if (title.contains('سریال')) return Icons.tv;
    if (title.contains('موسیقی')) return Icons.music_note;
    if (title.contains('آموزش')) return Icons.school;
    if (title.contains('نقشه')) return Icons.map;
    if (title.contains('فرمت')) return Icons.usb;
    if (title.contains('نوبت')) return Icons.confirmation_number;
    return Icons.folder_zip;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('انتخاب پکیج محتوا و خدمات'),
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey.shade900, Colors.black87],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'لطفاً محتوا یا خدمت مورد نظر خود را جهت انتقال انتخاب کنید:',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: fetchCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.cyanAccent,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.redAccent,
                              size: 60,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'خطا در ارتباط با سرور بک‌اند:\n${snapshot.error}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      );
                    }

                    final categories = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final item = categories[index];
                        return Card(
                          color: Colors.blueGrey.shade800,
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(20),
                            leading: Icon(
                              _getIconForTitle(item['title'] ?? ''),
                              size: 48,
                              color: Colors.cyanAccent,
                            ),
                            title: Text(
                              item['title'] ?? '',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                item['desc'] ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            trailing: Chip(
                              label: Text(
                                item['size'] ?? '',
                                style: const TextStyle(color: Colors.black),
                              ),
                              backgroundColor: Colors.cyanAccent,
                            ),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('انتخاب شد: ${item['title']}'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

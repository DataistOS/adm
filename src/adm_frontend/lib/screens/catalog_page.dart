// src/adm_frontend/lib/screens/catalog_page.dart

import 'package:flutter/material.dart';
import '../core/api_service.dart';
import '../models/content_item.dart';
import '../widgets/nyan_progress_dialog.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late Future<List<CategoryContent>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  void _loadContent() {
    setState(() {
      _categoriesFuture = ApiService.fetchCategoriesContent();
    });
  }

  IconData _getIconForExtension(String extension) {
    switch (extension.toLowerCase()) {
      case 'mp4':
      case 'mkv':
      case 'avi':
        return Icons.movie;
      case 'mp3':
      case 'wav':
        return Icons.music_note;
      case 'pdf':
      case 'txt':
      case 'doc':
        return Icons.menu_book;
      case 'zip':
      case 'tar':
      case 'gz':
        return Icons.folder_zip;
      default:
        return Icons.insert_drive_file;
    }
  }

  void _handleTransfer(ContentItem item) async {
    const targetPath = './data/usb_target';

    Future<bool> transferTask = ApiService.transferFile(item.id, targetPath);

    bool? success = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          NyanProgressDialog(fileName: item.name, transferFuture: transferTask),
    );

    if (!mounted) return;

    if (success == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'فایل "${item.name}" با موفقیت توسط نایان کت به حافظه جانبی منتقل شد! 🐱🌈',
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    } else if (success == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('خطا در انجام عملیات انتقال فایل.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _openCategoryDetail(CategoryContent category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailPage(
          category: category,
          onTransfer: _handleTransfer,
          getIcon: _getIconForExtension,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('انتخاب پکیج محتوا و خدمات (دستگاه ADM)'),
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadContent,
            tooltip: 'بارگذاری مجدد دسته‌بندی‌ها',
          ),
        ],
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
                'دسته‌بندی‌های محتوایی روی کیوسک:',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<CategoryContent>>(
                  future: _categoriesFuture,
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
                    if (categories.isEmpty) {
                      return const Center(
                        child: Text(
                          'هیچ دسته‌بندی یا فایلی در پوشه محتوا یافت نشد.\n(لطفاً پوشه‌های محتوا را در /data/content بررسی کنید)',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        return Card(
                          color: Colors.blueGrey.shade800,
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(20),
                            leading: const Icon(
                              Icons.folder,
                              size: 48,
                              color: Colors.cyanAccent,
                            ),
                            title: Text(
                              cat.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${cat.desc}\nتعداد فایل‌ها: ${cat.items.length}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            isThreeLine: true,
                            trailing: Chip(
                              label: Text(
                                cat.formattedSize,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.cyanAccent,
                            ),
                            onTap: () => _openCategoryDetail(cat),
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

class CategoryDetailPage extends StatelessWidget {
  final CategoryContent category;
  final Function(ContentItem) onTransfer;
  final IconData Function(String) getIcon;

  const CategoryDetailPage({
    super.key,
    required this.category,
    required this.onTransfer,
    required this.getIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
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
              Text(
                category.desc,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: category.items.isEmpty
                    ? const Center(
                        child: Text(
                          'فایلی در این دسته‌بندی وجود ندارد.',
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: category.items.length,
                        itemBuilder: (context, index) {
                          final item = category.items[index];
                          return Card(
                            color: Colors.blueGrey.shade800,
                            margin: const EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Icon(
                                getIcon(item.extension),
                                size: 40,
                                color: Colors.cyanAccent,
                              ),
                              title: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                'پسوند: .${item.extension.toUpperCase()}',
                                style: const TextStyle(color: Colors.white60),
                              ),
                              trailing: Chip(
                                label: Text(
                                  item.formattedSize,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: Colors.cyanAccent,
                              ),
                              onTap: () => onTransfer(item),
                            ),
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

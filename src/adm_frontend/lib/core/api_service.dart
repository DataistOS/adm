// src/adm_frontend/lib/core/api_service.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/content_item.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:9090';

  static Future<List<CategoryContent>> fetchCategoriesContent() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/v1/categories'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> items = data['data'] ?? [];
        return items.map((item) => CategoryContent.fromJson(item)).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching categories: $e');
      }
    }
    return [];
  }

  static Future<bool> transferFile(String fileId, String targetPath) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/transfer'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'file_id': fileId, 'target_path': targetPath}),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error transferring file: $e');
      }
    }
    return false;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String baseUrl = "https://api.bimbel-kamu.com/v1"; // Ganti dengan URL API-mu
  final _storage = const FlutterSecureStorage();

  // 10. Security: Mengambil Token Keamanan dari Secure Storage
  Future<Map<String, String>> _getHeaders() async {
    String? token = await _storage.read(key: "auth_token");
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token ?? ''}",
    };
  }

  // 7. REST API: Mengirim Data Pendaftaran ke Server
  Future<bool> sendPendaftaranToServer(Map<String, dynamic> data) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/pendaftaran'),
        headers: headers,
        body: jsonEncode(data),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false; // Offline atau server error
    }
  }
}
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const baseUrl = 'https://previews-missa.uk/backend';

  static Future<Map<String, dynamic>> register(
    String name,
    String phone,
    String pin,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/registrar_usuario.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'phone': phone, 'pin': pin}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'error': 'Error de red'};
    }
  }

  static Future<Map<String, dynamic>> login(String phone, String pin) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login_usuario.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone, 'pin': pin}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'error': 'Error de red'};
    }
  }
}

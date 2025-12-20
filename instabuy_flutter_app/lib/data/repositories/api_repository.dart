import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRepository {
  static Future<Map<String, dynamic>?> fetchLayout({required String subdomain}) async {
    final url = Uri.parse('https://api.instabuy.com.br/apiv3/layout?subdomain=$subdomain');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return data;
      } else {
        print('Erro na requisição: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao buscar layout: $e');
      return null;
    }
  }
}

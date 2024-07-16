import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static const String apiUrl = 'https://cbu.uz/uz/arkhiv-kursov-valyut/json/';

  Future<List<dynamic>> fetchCurrencies() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load currencies');
    }
  }
}

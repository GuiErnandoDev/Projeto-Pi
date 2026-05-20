import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey;

  GeminiService(this.apiKey);

  Future<String> sendMessage(String message) async {
    // Use um modelo público disponível para contas gratuitas, como gemini-1.0
    final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0:generateContent?key=$apiKey');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': message}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
      if (text != null) {
        return text.trim();
      } else {
        throw Exception('Resposta inesperada da IA: ${response.body}');
      }
    } else {
      throw Exception('Erro ao se comunicar com Gemini: ${response.body}');
    }
  }
}

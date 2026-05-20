import 'package:google_generative_ai/google_generative_ai.dart';


class GeminiAiService {
  final String apiKey;
  late final GenerativeModel _model;

  GeminiAiService(this.apiKey) {
    _model = GenerativeModel(
      model: 'models/gemini-2.5-flash',
      apiKey: apiKey,
    );
  }

  Future<String> sendMessage(String prompt) async {
    const contexto = '''
Você é um assistente do app Ativvo. O app possui as seguintes funcionalidades:
- Visualização e gestão de faturas
- Consulta e gerenciamento de contratos
- Acompanhamento de consumo de energia
- Visualização de economia gerada
Responda dúvidas do usuário sobre essas funcionalidades de forma clara e objetiva.
''';
    final promptFinal = '$contexto\nPergunta do usuário: $prompt';
    final content = [Content.text(promptFinal)];
    final response = await _model.generateContent(content);
    return response.text ?? 'Sem resposta da IA.';
  }
}

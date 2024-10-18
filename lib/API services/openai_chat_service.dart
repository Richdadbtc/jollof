import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIChatService {
  final String _apiKey = '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';

  Future<String> getResponse(String userInput) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-4",  // You can use "gpt-4" or other models
        "messages": [
          {"role": "system", "content": "You are a helpful assistant."},
          {"role": "user", "content": userInput},
        ],
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String botResponse = data['choices'][0]['message']['content'];
      return botResponse;
    } else {
      throw Exception('Failed to load response');
    }
  }
}

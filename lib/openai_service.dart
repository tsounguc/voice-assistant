import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:venus/secrets.dart';

class OpenAIService {
  final List<Map<String, String>> messages = [];
  Future<String> isArtPromptAPI(String prompt) async {
    final headers = {
      "Content-Type": " application/json",
      "Authorization": "Bearer $openAIApikey",
    };
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: headers,
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content":
                  "Does this message want to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no.",
            }
          ],
        }),
      );

      debugPrint(res.body);
      if (res.statusCode == 200) {
        debugPrint('yay');
        String content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim().toLowerCase();
        switch (content) {
          case "yes" || "yes.":
            final result = await dallEAPI(prompt);
            return result;
          default:
            final result = await chatGPTAPI(prompt);
            return result;
        }
      }
      return "An internal error occurred";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});
    final headers = {
      "Content-Type": " application/json",
      "Authorization": "Bearer $openAIApikey",
    };
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: headers,
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        messages.add({'role': 'assistant', 'content': content});
        return content;
      }
      return "An internal error occurred";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    return 'Dall-E';
  }
}

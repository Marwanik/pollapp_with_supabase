import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static const String answersKey = 'answers';

  Future<void> saveAnswer(int questionId, String questionText, int answerId, String answerText) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? answers = prefs.getStringList(answersKey) ?? [];
    String answerJson = jsonEncode({
      'questionId': questionId,
      'questionText': questionText,
      'answerId': answerId,
      'answerText': answerText,
    });
    answers.add(answerJson);
    await prefs.setStringList(answersKey, answers);
  }

  Future<List<Map<String, dynamic>>> fetchAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? answers = prefs.getStringList(answersKey) ?? [];
    return answers.map((answer) {
      try {
        final decoded = jsonDecode(answer);
        return Map<String, dynamic>.from(decoded); // Ensure correct type
      } catch (e) {
        print('Error decoding answer: $e');
        return <String, dynamic>{};
      }
    }).toList();
  }

  Future<void> clearAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(answersKey);
  }
}

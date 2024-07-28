import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  // Method to mark a form as completed
  Future<void> markFormAsCompleted(int formId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('form_$formId', true);
  }

  // Method to check if a form is completed
  Future<bool> isFormCompleted(int formId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('form_$formId') ?? false;
  }

  // Method to save an answer
  Future<void> saveAnswer(int questionId, String questionText, int answerId, String answerText) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('answer_${questionId}_text', answerText);
    await prefs.setInt('answer_${questionId}_id', answerId);
  }
}

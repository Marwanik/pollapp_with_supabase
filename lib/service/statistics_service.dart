import 'local_storage_service.dart';



class StatisticsService {
  Future<Map<String, Map<String, int>>> fetchStatistics() async {
    final localStorageService = LocalStorageService();
    final answers = await localStorageService.fetchAnswers();
    final Map<String, Map<String, int>> statistics = {};

    for (var answer in answers) {
      if (answer.isEmpty) continue; // Skip if the answer couldn't be decoded
      final questionText = answer['questionText'];
      final answerText = answer['answerText'];

      if (!statistics.containsKey(questionText)) {
        statistics[questionText] = {};
      }

      statistics[questionText]![answerText] = (statistics[questionText]![answerText] ?? 0) + 1;
    }

    return statistics;
  }
}

Future<Map<String, Map<String, int>>> fetchStatistics() async {
  final localStorageService = LocalStorageService();
  final answers = await localStorageService.fetchAnswers();
  final Map<String, Map<String, int>> statistics = {};

  for (var answer in answers) {
    if (answer.isEmpty) continue; // Skip if the answer couldn't be decoded
    print('Processing answer: $answer'); // Debug print
    final questionText = answer['questionText'];
    final answerText = answer['answerText'];

    if (!statistics.containsKey(questionText)) {
      statistics[questionText] = {};
    }

    statistics[questionText]![answerText] = (statistics[questionText]![answerText] ?? 0) + 1;
  }

  return statistics;
}

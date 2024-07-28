import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:pollapp/data/data_sources/supabase_data_source.dart';
import 'package:pollapp/data/models/answer_option_model.dart';
import 'package:pollapp/data/models/question_model.dart';
import 'package:pollapp/data/models/statistic_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminProvider {
  final SupabaseDataSource dataSource;

  AdminProvider(this.dataSource);

  Future<void> updateQuestion(int questionId, String newText) async {
    await dataSource.updateQuestion(questionId, newText);
  }

  Future<void> addAnswerOption(int questionId, String optionText) async {
    await dataSource.addAnswerOption(questionId, optionText);
  }

  Future<void> deleteAnswerOption(int optionId) async {
    await dataSource.deleteAnswerOption(optionId);
  }

  Future<List<StatisticModel>> fetchStatistics() async {
    return await dataSource.fetchStatistics();
  }
}

// Define supabaseClientProvider
final supabaseClientProvider = riverpod.Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// Define supabaseDataSourceProvider
final supabaseDataSourceProvider = riverpod.Provider<SupabaseDataSource>((ref) {
  return SupabaseDataSource(ref.watch(supabaseClientProvider));
});

// Define fetchStatisticsProvider
final fetchStatisticsProvider = riverpod.FutureProvider<List<StatisticModel>>((ref) async {
  final dataSource = ref.watch(supabaseDataSourceProvider);
  return await dataSource.fetchStatistics();
});

// Define fetchQuestionsProvider
final fetchQuestionsProvider = riverpod.FutureProvider<List<QuestionModel>>((ref) async {
  final dataSource = ref.watch(supabaseDataSourceProvider);
  return await dataSource.fetchAllQuestions();
});

// Define fetchAnswerOptionsProvider
final fetchAnswerOptionsProvider = riverpod.FutureProvider.family<List<AnswerOptionModel>, int>((ref, questionId) async {
  final dataSource = ref.watch(supabaseDataSourceProvider);
  return await dataSource.fetchAnswerOptions(questionId);
});

// Define adminProvider
final adminProvider = riverpod.Provider<AdminProvider>((ref) {
  return AdminProvider(ref.watch(supabaseDataSourceProvider));
});

import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:pollapp/data/data_sources/supabase_data_source.dart';
import 'package:pollapp/data/models/answer_option_model.dart';
import 'package:pollapp/data/models/form_model.dart';
import 'package:pollapp/data/models/question_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final supabaseClientProvider = riverpod.Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final supabaseDataSourceProvider = riverpod.Provider<SupabaseDataSource>((ref) {
  return SupabaseDataSource(ref.watch(supabaseClientProvider));
});

final fetchFormsProvider = riverpod.FutureProvider.family<List<FormModel>, String>((ref, category) async {
  final dataSource = ref.watch(supabaseDataSourceProvider);
  return await dataSource.fetchForms(category);
});

final fetchQuestionsProvider = riverpod.FutureProvider.family<List<QuestionModel>, int>((ref, formId) async {
  final dataSource = ref.watch(supabaseDataSourceProvider);
  return await dataSource.fetchQuestions(formId);
});

final fetchAnswerOptionsProvider = riverpod.FutureProvider.family<List<AnswerOptionModel>, int>((ref, questionId) async {
  final dataSource = ref.watch(supabaseDataSourceProvider);
  return await dataSource.fetchAnswerOptions(questionId);
});

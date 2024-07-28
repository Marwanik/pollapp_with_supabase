import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/form_model.dart';
import '../models/question_model.dart';
import '../models/answer_option_model.dart';
import '../models/statistic_model.dart';
import '../models/user_model.dart';

class SupabaseDataSource {
  final SupabaseClient client;

  SupabaseDataSource(this.client);

  Future<List<FormModel>> fetchForms(String category) async {
    final response =
        await client.from('forms').select().eq('category', category).execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    return (response.data as List)
        .map((form) => FormModel.fromJson(form))
        .toList();
  }

  Future<List<QuestionModel>> fetchQuestions(int formId) async {
    final response =
        await client.from('questions').select().eq('form_id', formId).execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    return (response.data as List)
        .map((question) => QuestionModel.fromJson(question))
        .toList();
  }

  Future<List<AnswerOptionModel>> fetchAnswerOptions(int questionId) async {
    final response = await client
        .from('answer_options')
        .select()
        .eq('question_id', questionId)
        .execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    return (response.data as List)
        .map((option) => AnswerOptionModel.fromJson(option))
        .toList();
  }

  Future<void> signUp(UserModel user) async {
    final response = await client.from('users').insert(user.toJson()).execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    if (response.data == null || response.data.isEmpty) {
      throw Exception('Failed to sign up');
    }
  }

  Future<UserModel?> signIn(String email, String password) async {
    final response = await client
        .from('users')
        .select()
        .eq('email', email)
        .eq('password', password)
        .maybeSingle()
        .execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    final data = response.data;
    if (data != null) {
      return UserModel.fromJson(data as Map<String, dynamic>);
    }

    return null;
  }

  Future<void> updateQuestion(int questionId, String newText) async {
    final response = await client
        .from('questions')
        .update({'question_text': newText})
        .eq('id', questionId)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> addAnswerOption(int questionId, String optionText) async {
    final response = await client.from('answer_options').insert(
        {'question_id': questionId, 'option_text': optionText}).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> deleteAnswerOption(int optionId) async {
    final response = await client
        .from('answer_options')
        .delete()
        .eq('id', optionId)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<List<StatisticModel>> fetchStatistics() async {
    final response = await client.rpc('fetch_statistics').execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return (response.data as List)
        .map((stat) => StatisticModel.fromJson(stat))
        .toList();
  }

  Future<List<QuestionModel>> fetchAllQuestions() async {
    final response = await client.from('questions').select().execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    return (response.data as List)
        .map((question) => QuestionModel.fromJson(question))
        .toList();
  }

  Future<void> updateUser(UserModel user) async {
    final response = await client
        .from('users')
        .update(user.toJson())
        .eq('id', user.id)
        .execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    if (response.data == null || response.data.isEmpty) {
      throw Exception('Failed to update user');
    }
  }
}

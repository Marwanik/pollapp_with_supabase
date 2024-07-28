import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pollapp/data/models/answer_option_model.dart';
import 'package:pollapp/domain/entities/user.dart';
import 'package:pollapp/presentation/pages/mobile/HomeScreen.dart';
import 'package:pollapp/presentation/providers/form_provider.dart';
import 'package:pollapp/presentation/widgets/LocalStorageService.dart';

import 'package:pollapp/presentation/widgets/notificationService.dart';
import 'package:pollapp/presentation/widgets/question_widget.dart';

import 'package:pollapp/service/achievement_service.dart';


class FormPage extends ConsumerWidget {
  final User user;
  final int formId;
  final String formName;

  FormPage({required this.user, required this.formId, required this.formName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsAsyncValue = ref.watch(fetchQuestionsProvider(formId));
    final achievementService = AchievementService();
    final notificationService = NotificationService();
    final localStorageService = LocalStorageService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
        backgroundColor: Color(0xff4D7EFA),
      ),
      body: questionsAsyncValue.when(
        data: (questions) {
          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              return QuestionWidget(question: question);
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff4D7EFA),
        onPressed: () async {
          if (questionsAsyncValue.value != null) {
            for (var question in questionsAsyncValue.value!) {
              if (question.selectedOption != null) {
                final answerOption = question.answerOptions?.firstWhere(
                      (option) => option.id == question.selectedOption,
                  orElse: () => AnswerOptionModel(
                    id: -1,
                    questionId: question.id,
                    optionText: 'Invalid Option',
                  ),
                );
                if (answerOption != null && answerOption.id != -1) {
                  await localStorageService.saveAnswer(
                    question.id,
                    question.questionText,
                    answerOption.id,
                    answerOption.optionText,
                  );
                }
              }
            }
          }

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('Submitting Done'),
                content: Text('Your form has been submitted successfully.'),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await achievementService.addAchievement(user.id!, 'Collected a prize');
                      await localStorageService.markFormAsCompleted(formId);
                      await notificationService.showNotification('Prize Collected', 'You have collected your prize.');
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(user: user),
                        ),
                      );
                    },
                    child: Text('Collect Prize'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

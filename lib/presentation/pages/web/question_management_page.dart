import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pollapp/presentation/providers/admin_provider.dart' as admin;
import 'package:pollapp/presentation/pages/web/edit_question_page.dart';

class QuestionManagementPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsAsyncValue = ref.watch(admin.fetchQuestionsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Manage Questions'), backgroundColor: Color(0xFF343A40)),
      body: questionsAsyncValue.when(
        data: (questions) {
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text(question.questionText),
                  trailing: Icon(Icons.arrow_forward, color: Color(0xFFD7A977)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditQuestionPage(question: question),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

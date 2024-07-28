import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/question_model.dart';
import '../../providers/admin_provider.dart';

class EditQuestionPage extends ConsumerStatefulWidget {
  final QuestionModel question;

  EditQuestionPage({required this.question});

  @override
  _EditQuestionPageState createState() => _EditQuestionPageState();
}

class _EditQuestionPageState extends ConsumerState<EditQuestionPage> {
  final questionTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    questionTextController.text = widget.question.questionText;
  }

  @override
  Widget build(BuildContext context) {
    final answerOptionsAsyncValue = ref.watch(fetchAnswerOptionsProvider(widget.question.id));

    return Scaffold(
      appBar: AppBar(title: Text('Edit Question'), backgroundColor: Color(0xFF343A40)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Question',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: questionTextController,
              decoration: InputDecoration(
                labelText: 'Question Text',
                filled: true,
                fillColor: Color(0xFFf0e6d2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Answer Options',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            answerOptionsAsyncValue.when(
              data: (answerOptions) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: answerOptions.length,
                    itemBuilder: (context, index) {
                      final option = answerOptions[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(option.optionText),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Implement delete option logic
                              ref.read(adminProvider).deleteAnswerOption(option.id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement update question logic
                    ref.read(adminProvider).updateQuestion(
                      widget.question.id,
                      questionTextController.text,
                    );
                  },
                  child: Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color(0xFFD7A977),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement add new option logic
                    showAddOptionDialog(context);
                  },
                  child: Text('Add New Option'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color(0xFFD7A977),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAddOptionDialog(BuildContext context) {
    final optionTextController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Option'),
          content: TextFormField(
            controller: optionTextController,
            decoration: InputDecoration(labelText: 'Option Text'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Implement add option logic
                ref.read(adminProvider).addAnswerOption(
                  widget.question.id,
                  optionTextController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFFD7A977),
              ),
            ),
          ],
        );
      },
    );
  }
}

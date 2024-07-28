
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pollapp/data/models/question_model.dart';
import 'package:pollapp/presentation/providers/form_provider.dart';


class QuestionWidget extends ConsumerStatefulWidget {
  final QuestionModel question;

  QuestionWidget({required this.question});

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends ConsumerState<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    final answerOptionsAsyncValue = ref.watch(fetchAnswerOptionsProvider(widget.question.id));

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Color(0xff0948EA).withOpacity(0.2), Color(0xff0948EA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.question.questionText, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              answerOptionsAsyncValue.when(
                data: (options) {
                  widget.question.answerOptions = options;
                  if (options.isEmpty) {
                    return Text('No options available');
                  }
                  return Column(
                    children: options.map((option) {
                      return RadioListTile<int>(
                        activeColor: Color(0xff0948EA),
                        title: Text(option.optionText),
                        value: option.id,
                        groupValue: widget.question.selectedOption,
                        onChanged: (value) {
                          setState(() {
                            widget.question.selectedOption = value;
                          });
                        },
                      );
                    }).toList(),
                  );
                },
                loading: () => CircularProgressIndicator(),
                error: (error, stack) {
                  print('Error fetching options: $error');
                  return Text('Error: $error');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
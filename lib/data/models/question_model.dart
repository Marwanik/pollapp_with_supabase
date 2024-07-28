import 'answer_option_model.dart';

class QuestionModel {
  final int id;
  final int formId;
  final String questionText;
  int? selectedOption; // Add this property to track the selected option
  List<AnswerOptionModel>? answerOptions; // Add this property

  QuestionModel({
    required this.id,
    required this.formId,
    required this.questionText,
    this.selectedOption,
    this.answerOptions,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      formId: json['form_id'],
      questionText: json['question_text'],
      selectedOption: json['selected_option'], // Update to handle JSON parsing
      answerOptions: (json['answer_options'] as List?)
          ?.map((e) => AnswerOptionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'form_id': formId,
      'question_text': questionText,
      'selected_option': selectedOption, // Update to handle JSON serialization
      'answer_options': answerOptions?.map((e) => e.toJson()).toList(),
    };
  }
}

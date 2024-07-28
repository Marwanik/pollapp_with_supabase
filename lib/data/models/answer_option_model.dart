class AnswerOptionModel {
  final int id;
  final int questionId;
  final String optionText;

  AnswerOptionModel({
    required this.id,
    required this.questionId,
    required this.optionText,
  });

  factory AnswerOptionModel.fromJson(Map<String, dynamic> json) {
    return AnswerOptionModel(
      id: json['id'],
      questionId: json['question_id'],
      optionText: json['option_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_id': questionId,
      'option_text': optionText,
    };
  }
}

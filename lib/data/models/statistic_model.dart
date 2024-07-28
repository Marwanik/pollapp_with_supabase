class StatisticModel {
  final String questionText;
  final int answerCount;

  StatisticModel({
    required this.questionText,
    required this.answerCount,
  });

  factory StatisticModel.fromJson(Map<String, dynamic> json) {
    return StatisticModel(
      questionText: json['question_text'],
      answerCount: json['answer_count'],
    );
  }
}

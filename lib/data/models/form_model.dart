class FormModel {
  final int id;
  final String name;
  final String category;

  FormModel({
    required this.id,
    required this.name,
    required this.category,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
    );
  }
}

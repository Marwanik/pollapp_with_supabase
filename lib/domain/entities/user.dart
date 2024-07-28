class User {
  final String? id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;
  final String maritalState;
  final String education;
  final String address;
  final String socialState;
  final int numberOfChildren;
  final String phoneNumber;
  final bool hasAJob;
  final String role;
  final String? avatarUrl;
  final List<String> achievements; // Add this field

  User({
    this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.maritalState,
    required this.education,
    required this.address,
    required this.socialState,
    required this.numberOfChildren,
    required this.phoneNumber,
    required this.hasAJob,
    required this.role,
    this.avatarUrl,
    required this.achievements, // Initialize this field
  });
}

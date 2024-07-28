import '../entities/user.dart';

abstract class UserRepository {
  Future<void> signUp(User user);
  Future<User?> signIn(String email, String password);
  Future<void> updateUser(User user); // Add this method
}

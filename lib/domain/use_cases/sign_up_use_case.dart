import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SignUpUseCase {
  final UserRepository repository;

  SignUpUseCase(this.repository);

  Future<void> execute(User user) async {
    await repository.signUp(user);
  }
}

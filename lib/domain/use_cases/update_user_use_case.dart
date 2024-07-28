import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateUserUseCase {
  final UserRepository repository;

  UpdateUserUseCase(this.repository);

  Future<void> execute(User user) async {
    await repository.updateUser(user);
  }
}

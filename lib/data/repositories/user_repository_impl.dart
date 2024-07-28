import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/supabase_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<void> signUp(User user) async {
    final userModel = UserModel.fromEntity(user);
    await dataSource.signUp(userModel);
  }

  @override
  Future<User?> signIn(String email, String password) async {
    final userModel = await dataSource.signIn(email, password);
    return userModel?.toEntity();
  }

  @override
  Future<void> updateUser(User user) async {
    final userModel = UserModel.fromEntity(user);
    await dataSource.updateUser(userModel);
  }
}

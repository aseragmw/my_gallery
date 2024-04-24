import 'package:dartz/dartz.dart';
import 'package:pro_mina_task/core/errors/failures.dart';
import 'package:pro_mina_task/features/auth/domain/entities/user_entitiy.dart';
import 'package:pro_mina_task/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});
  Future<Either<Failure, UserEntity>> call(String email, String password) => authRepository.login(email, password);
}

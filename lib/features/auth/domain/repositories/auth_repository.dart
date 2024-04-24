import 'package:dartz/dartz.dart';
import 'package:pro_mina_task/core/errors/failures.dart';
import 'package:pro_mina_task/features/auth/domain/entities/user_entitiy.dart';
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email,String password);
}

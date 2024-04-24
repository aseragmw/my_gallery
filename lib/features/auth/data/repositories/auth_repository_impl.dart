import 'package:dartz/dartz.dart';
import 'package:pro_mina_task/core/errors/failures.dart';
import 'package:pro_mina_task/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pro_mina_task/features/auth/domain/entities/user_entitiy.dart';
import 'package:pro_mina_task/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async{
     try {
      final user = await authRemoteDataSource.login(email, password);
      return Right(user);
    } catch (e) {
      return const Left(Failure(message: 'Login Failed, Try again later'));
    }
  }
  


  

}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_mina_task/core/constants/app_constants.dart';
import 'package:pro_mina_task/core/constants/cache_constants.dart';
import 'package:pro_mina_task/core/utils/cache_helper.dart';
import 'package:pro_mina_task/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pro_mina_task/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pro_mina_task/features/auth/domain/usecases/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<LoginEvent>(
      (event, emit) async {
        emit(LoginLoadingState());
        LoginUsecase loginUsecase =
            LoginUsecase(authRepository: AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSourceImplWithDio()));

        final either = await loginUsecase.call(event.email, event.password);
        either.fold((l) {
          emit(LoginErrorState(message: l.message));
        }, (r) => emit(LoginSuccessState()));
      },
    );

    on<LogoutEvent>(
      (event, emit) async {
        emit(LogoutLoadingState());
        try {
          CacheHelper.remove(currentUserCache);
          AppConstants.CachedCurrentUserObject = null;
          emit(LogoutSuccessState());
        } catch (e) {
          emit(const LogoutErrorState(message: "Logout Failed, Try Again Later"));
        }
      },
    );
  }
}

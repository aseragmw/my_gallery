import 'package:pro_mina_task/core/constants/api_conatsants.dart';
import 'package:pro_mina_task/core/constants/app_constants.dart';
import 'package:pro_mina_task/core/constants/cache_constants.dart';
import 'package:pro_mina_task/core/network/api_caller.dart';
import 'package:pro_mina_task/core/utils/cache_helper.dart';
import 'package:pro_mina_task/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImplWithDio extends AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    final res = await ApiCaller.postHTTP("auth/login", {emailAPI: email, passwordAPI: password});
    final userRes = UserModel.fromJson(res.data);
    CacheHelper.put(currentUserCache, userRes);
    AppConstants.CachedCurrentUserObject = userRes.toJson();
    return userRes;
  }
}

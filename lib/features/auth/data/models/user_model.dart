import 'package:pro_mina_task/core/constants/api_conatsants.dart';
import 'package:pro_mina_task/features/auth/domain/entities/user_entitiy.dart';

class UserModel extends UserEntity {
  const UserModel({required super.id, required super.email, required super.name, required super.token});
  

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        id: jsonData[userAPI][idAPI],
        email: jsonData[userAPI][emailAPI],
        name: jsonData[userAPI][nameAPI],
         token: jsonData[tokenAPI],
       );
  }
  Map<String, dynamic> toJson() {
    return {
      idAPI: id,
      emailAPI: email,
      nameAPI: name,
      tokenAPI: token,
    };
  }
}

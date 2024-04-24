import 'dart:convert';

import 'package:pro_mina_task/core/constants/cache_constants.dart';
import 'package:pro_mina_task/core/utils/cache_helper.dart';


class AppConstants {
  static  Map<String, dynamic>? CachedCurrentUserObject;

  static void initAppConstants() async {
    final cachedData = CacheHelper.get(currentUserCache);
    if (cachedData != null) {
      CachedCurrentUserObject = json.decode(cachedData);
    }
    
  }
}

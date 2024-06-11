import 'dart:convert';

import 'package:get/get.dart';
import 'package:squch/core/shared_pref/shared_pref.dart';
import 'package:squch/core/shared_pref/shared_pref_impl.dart';
import '../../features/user_auth_feature/data/models/login_response.dart';


class AuthService extends GetxService {
  final loginData = LoginData().obs;
  final user = User().obs;
  //final oldUser = User().obs;
 late SharedPref _box;

 // late UserRepository _usersRepo;

  AuthService() {
    //_usersRepo = new UserRepository();
    _box = SharedPrefImpl();
  }

  Future<AuthService> init() async {
    loginData.listen((LoginData _user) {
    /*  if (Get.isRegistered<SettingsService>()) {
        Get.find<SettingsService>().address.value.userId = _user.id;
      }*/
      // _box.write('current_user', _user.toJson());
      // _box.write('current_old_user', _user.toJson());
      _box.setLogindata(jsonEncode(_user));
    });
    await getCurrentUser();
    return this;
  }

  Future getCurrentUser() async {
    if (loginData.value!=null && loginData.value.user!=null) {
      user.value = loginData.value.user!;
    } else {

    }
  }

 /* Future getCurrentOldUser() async {
    if (oldUser.value.auth == null && _box.hasData('current_old_user')) {
      oldUser.value = User.fromJson(await _box.read('current_old_user'));
      oldUser.value.auth = true;
    } else {
      oldUser.value.auth = false;
    }
    return oldUser.value;
  }*/

  /*Future removeCurrentUser() async {
    await _usersRepo.signOut(user.value).then((value) {
      if (value) user.value = User();
      return null;
    });
    await _box.remove('current_user');
  }

  Future removeCurrentOldUser() async {
    await _usersRepo.signOut(user.value).then((value) {
      if (value) user.value = User();
      return null;
    });
    await _box.remove('current_old_user');
  }*/

  bool get isAuth => loginData.value.user!=null? true : false;

  String? get apiToken => loginData.value!= null? "": loginData.value.token;
 // Salon? get salon => (user.value.salons?.isNotEmpty ?? false) ? user.value.salons?.first : Salon();
}

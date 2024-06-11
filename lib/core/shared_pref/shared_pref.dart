


import 'package:squch/features/map_page_feature/presentation/controller/ride_status.dart';
import 'package:squch/features/user_auth_feature/data/models/login_response.dart';

import '../../features/map_page_feature/data/models/start_ride_response.dart';

abstract class SharedPref {

  Future<String> getSelectedLanguage();
  Future setLanguage(String language);


  Future<bool> isLoggedin();
  Future setIntroScreenShown(bool isShown);
  Future<bool> isIntroScreenShown();
  Future setLoggedin(bool isLoggedin);
  Future setLogindata(String data);
  Future setLoggedinIdPassword(String? id, String? password);
  Future<LoginData?> getLogindata();
  Future<String?> getLoginId();
  Future<String?> getLoginPassword();
  Future setRememberMe(bool remember);
  Future<bool> isRememberMe();
  Future setFCMToken(String token);
  Future<String> getFCMToken();
  Future setToken(String token);
  Future<String> getToken();
  Future setCurrentState(RideStatus rideStatus);
  Future setCurrentTrip(String data);
  Future<RideStatus> getCurrentState();
  Future<StartRideData?> getCurrentTrip();
  Future clearData();
}
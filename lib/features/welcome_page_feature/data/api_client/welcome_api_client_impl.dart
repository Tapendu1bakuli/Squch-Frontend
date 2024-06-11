import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:squch/core/shared_pref/shared_pref.dart';
import 'package:squch/features/user_auth_feature/data/models/login_error_response.dart';
import 'package:squch/features/user_auth_feature/data/models/login_response.dart';
import 'package:squch/features/user_auth_feature/data/models/registration_master_data_model.dart';
import 'package:squch/features/user_auth_feature/data/models/verify_otp_success_response.dart';
import 'package:squch/features/welcome_page_feature/data/api_client/welcome_api_client.dart';


import '../../../../../core/apiHelper/api_constant.dart';
import '../../../../../core/utils/Resource.dart';
import '../../../../../core/utils/Status.dart';

import '../../../../core/apiHelper/core_service.dart';
import '../../../../core/constant/constant.dart';
import '../../../user_auth_feature/data/models/registration_success_response.dart';
import '../models/intro_screen_response_model.dart';


class WelcomeApiClientImpl extends GetConnect implements WelcomeApiClient {
  @override
  void onInit() {
    httpClient.timeout =  const Duration(minutes: TIMEOUT_DURATION);
    httpClient.baseUrl = BASE_URL;
  }

  @override
  Future<Resource> getIntroData({required Map<String, dynamic> body,required Map<String, dynamic> header}) async {
    final response = await CoreService().apiService(
      baseURL: BASE_URL,
      method: METHOD.POST,
      body: body,
      header: header,
      endpoint: INTRO_SCREEN,
    );
    if(response["status"] == true){

      try {
        IntroScreenResponseModel initRideResponse = IntroScreenResponseModel.fromJson(response);
        return Resource(status: STATUS.SUCCESS, data: initRideResponse.data,message: initRideResponse.message);
      } catch (e) {
        print(e);
        return Resource.error(message: SOMETHING_WENT_WRONG);
      }
    }
    else{
      return Resource(status: STATUS.ERROR, message: response["message"]);
    }
  }



}

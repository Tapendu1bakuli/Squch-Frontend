import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:squch/core/shared_pref/shared_pref.dart';
import 'package:squch/features/map_page_feature/data/models/start_ride_response.dart';
import 'package:squch/features/user_auth_feature/data/models/login_error_response.dart';
import 'package:squch/features/user_auth_feature/data/models/login_response.dart';
import 'package:squch/features/user_auth_feature/data/models/registration_master_data_model.dart';
import 'package:squch/features/user_auth_feature/data/models/verify_otp_success_response.dart';


import '../../../../../core/apiHelper/api_constant.dart';
import '../../../../../core/utils/Resource.dart';
import '../../../../../core/utils/Status.dart';

import '../../../../core/apiHelper/core_service.dart';
import '../../../../core/constant/constant.dart';
import '../../../user_auth_feature/data/models/registration_success_response.dart';
import '../models/get_cancel_reasons_response.dart';
import '../models/init_ride_response.dart';
import 'map_api_client.dart';

class MapApiClientImpl extends GetConnect implements MapApiClient {
  @override
  void onInit() {
    httpClient.timeout =  const Duration(minutes: TIMEOUT_DURATION);
    httpClient.baseUrl = BASE_URL;
  }
  @override
  Future<GetCancelRideReasonModel> findReasonToCancelRide({required Map<String, dynamic> header}) async {
    final response = await CoreService().apiService(
      baseURL: BASE_URL,
      method: METHOD.POST,
      header: header,
      endpoint: GET_CANCEL_RIDE_REASON,
    );
    if(response["status"] == true){

      try {
        GetCancelRideReasonModel getCancelRideReasonModel = GetCancelRideReasonModel.fromJson(response);
        return getCancelRideReasonModel;
      } catch (e) {
        print(e);
        return GetCancelRideReasonModel();
      }
    }
    else{
      return GetCancelRideReasonModel();
    }
  }


  @override
  Future<Resource> initRide({required Map<String, dynamic> body,required Map<String, dynamic> header}) async {
    final response = await CoreService().apiService(
      baseURL: BASE_URL,
      method: METHOD.POST,
      body: body,
      header: header,
      endpoint: INIT_RIDE,
    );
    if(response["status"] == true){

      try {
        InitRideResponse initRideResponse = InitRideResponse.fromJson(response);
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

  @override
  Future<Resource> findADriver({required Map<String, dynamic> body, required Map<String, dynamic> header}) async {
    final response = await CoreService().apiService(
      baseURL: BASE_URL,
      method: METHOD.POST,
      body: body,
      header: header,
      endpoint: FIND_A_DRIVER,
    );
    if(response!= null &&response["status"] == true){

      try {
        StartRideResponse startRideResponse = StartRideResponse.fromJson(response);
        return Resource(status: STATUS.SUCCESS, data: startRideResponse.data,message: startRideResponse.message);
      } catch (e) {
        print(e);
        return Resource.error(message: SOMETHING_WENT_WRONG);
      }
    }
    else{
      if(response != null) {
        return Resource(status: STATUS.ERROR, message: response["message"]);
      }else{
        return Resource(status: STATUS.ERROR, message: SOMETHING_WENT_WRONG);
      }
    }
  }



}

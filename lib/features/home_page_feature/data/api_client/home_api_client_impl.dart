
import 'package:get/get.dart';
import 'package:squch/core/shared_pref/shared_pref.dart';
import 'package:squch/core/utils/Resource.dart';
import 'package:squch/features/map_page_feature/data/models/start_ride_response.dart';



import '../../../../../core/apiHelper/api_constant.dart';


import '../../../../core/apiHelper/core_service.dart';

import 'home_api_client.dart';


class HomeApiClientImpl extends GetConnect implements HomeApiClient {
  @override
  void onInit() {
    httpClient.timeout =  const Duration(minutes: TIMEOUT_DURATION);
    httpClient.baseUrl = BASE_URL;
  }
  @override
  Future<Resource> getActiveRideData({required Map<String, String> header}) async {
    final response = await CoreService().apiService(
      baseURL: BASE_URL,
      method: METHOD.POST,
      header: header,
      endpoint: GET_ACTIVE_RIDE,
    );
    if(response["status"] == true){
      try {
        StartRideData startRideData = StartRideData.fromJson(response["data"]);
        return Resource.success(data: startRideData,message: response["message"]);
      } catch (e) {
        print(e);
        return  Resource.error(message: response["message"]);
      }
    }
    else{
      return Resource.error(message: response["message"]);
    }
  }



}

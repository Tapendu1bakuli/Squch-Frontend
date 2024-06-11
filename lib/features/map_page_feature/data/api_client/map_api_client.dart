


import '../../../../../core/utils/Resource.dart';
import '../models/get_cancel_reasons_response.dart';

abstract class MapApiClient {

  Future<Resource> initRide({required Map<String, dynamic> body,required Map<String, dynamic> header});
  Future<Resource> findADriver({required Map<String, dynamic> body,required Map<String, dynamic> header});
  Future<GetCancelRideReasonModel> findReasonToCancelRide({required Map<String, dynamic> header});

}
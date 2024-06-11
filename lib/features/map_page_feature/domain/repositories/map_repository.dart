import 'package:squch/core/utils/Resource.dart';

import '../../data/models/get_cancel_reasons_response.dart';

abstract class MapRepository {

  Future<Resource> initRide(Map<String,dynamic>body,Map<String,dynamic>header);
  Future<Resource> findADriver(Map<String,dynamic>body,Map<String,dynamic>header);
  Future<GetCancelRideReasonModel> findReasonToCancelRide(Map<String,dynamic>header);

}
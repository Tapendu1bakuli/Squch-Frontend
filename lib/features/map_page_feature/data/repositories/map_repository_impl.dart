import 'package:squch/core/utils/Resource.dart';
import 'package:squch/features/map_page_feature/domain/repositories/map_repository.dart';
import '../api_client/map_api_client.dart';
import '../models/get_cancel_reasons_response.dart';


class MapRepositoryImpl extends MapRepository {
  final MapApiClient apiClient;

  MapRepositoryImpl({required this.apiClient});

  @override
  Future<Resource> initRide(Map<String,dynamic>body,Map<String,dynamic>header) async {
    return await apiClient.initRide(body: body,header:header);
  }

 @override
  Future<Resource> findADriver(Map<String,dynamic>body,Map<String,dynamic>header) async {
    return await apiClient.findADriver(body: body,header:header);
  }


  @override
  Future<GetCancelRideReasonModel> findReasonToCancelRide(Map<String,dynamic>header) async {
    return await apiClient.findReasonToCancelRide(header:header);
  }


}

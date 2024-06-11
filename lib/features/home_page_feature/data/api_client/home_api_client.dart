


import '../../../../../core/utils/Resource.dart';


abstract class HomeApiClient {
  Future<Resource> getActiveRideData({required Map<String, String> header});


}
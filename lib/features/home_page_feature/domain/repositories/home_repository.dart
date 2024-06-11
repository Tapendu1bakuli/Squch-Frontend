import 'package:squch/core/utils/Resource.dart';



abstract class HomeRepository {

  Future<Resource> getActiveRideData(Map<String,String> header);

}
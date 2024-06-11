import 'package:squch/core/utils/Resource.dart';

abstract class WelcomeRepository {

  Future<Resource> getIntroData(Map<String,dynamic>body,Map<String,dynamic>header);

}
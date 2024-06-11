import 'package:get/get.dart';
import 'package:squch/features/home_page_feature/presentation/controller/home_controller.dart';
import 'package:squch/features/map_page_feature/data/api_client/map_api_client.dart';
import 'package:squch/features/map_page_feature/data/api_client/map_api_client_impl.dart';
import 'package:squch/features/map_page_feature/data/repositories/map_repository_impl.dart';
import 'package:squch/features/map_page_feature/domain/repositories/map_repository.dart';
import 'package:squch/features/map_page_feature/presentation/controller/map_controller.dart';
import '../../../../core/shared_pref/shared_pref.dart';
import '../../../../core/shared_pref/shared_pref_impl.dart';
import '../../../chat_screen_features/presentation/controller/chat_controller.dart';




class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedPref>(() => SharedPrefImpl(),);
    Get.lazyPut<MapApiClient>(() => MapApiClientImpl(),);
    Get.lazyPut<MapRepository>(() => MapRepositoryImpl(apiClient: Get.find()),);
    Get.lazyPut<MapController>(() => MapController(sharedPref: Get.find(),mapRepository: Get.find()),);
  }
}

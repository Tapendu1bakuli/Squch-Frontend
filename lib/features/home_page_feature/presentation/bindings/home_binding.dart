import 'package:get/get.dart';
import 'package:squch/features/home_page_feature/presentation/controller/home_controller.dart';
import 'package:squch/features/map_page_feature/data/api_client/map_api_client.dart';
import 'package:squch/features/map_page_feature/data/api_client/map_api_client_impl.dart';
import 'package:squch/features/map_page_feature/data/repositories/map_repository_impl.dart';
import 'package:squch/features/map_page_feature/domain/repositories/map_repository.dart';
import '../../../../core/network_checker/common_network_checker_controller.dart';
import '../../../../core/shared_pref/shared_pref.dart';
import '../../../../core/shared_pref/shared_pref_impl.dart';
import '../../../chat_screen_features/presentation/controller/chat_controller.dart';
import '../../../map_page_feature/presentation/controller/map_controller.dart';
import '../../data/api_client/home_api_client.dart';
import '../../data/api_client/home_api_client_impl.dart';
import '../../data/repositories/map_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';




class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedPref>(() => SharedPrefImpl(),);
    Get.lazyPut<MapApiClient>(() => MapApiClientImpl(),);
    Get.lazyPut<HomeApiClient>(() => HomeApiClientImpl(),);
    Get.lazyPut<MapRepository>(() => MapRepositoryImpl(apiClient: Get.find()),);
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(apiClient: Get.find()),);
    Get.lazyPut<MapController>(() => MapController(sharedPref: Get.find(), mapRepository: Get.find()),);
    Get.lazyPut<HomeController>(() => HomeController(sharedPref: Get.find(), homeRepository: Get.find()),);
    Get.lazyPut<CommonNetWorkStatusCheckerController>(() => CommonNetWorkStatusCheckerController(),);
  }
}

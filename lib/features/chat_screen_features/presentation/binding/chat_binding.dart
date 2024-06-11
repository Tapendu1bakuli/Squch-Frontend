import 'package:get/get.dart';
import 'package:squch/features/chat_screen_features/presentation/controller/chat_controller.dart';
import '../../../../core/network_checker/common_network_checker_controller.dart';


class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController(sharedPref: Get.find()));
    Get.lazyPut<CommonNetWorkStatusCheckerController>(() => CommonNetWorkStatusCheckerController(),);
  }
}
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:squch/core/shared_pref/shared_pref.dart';
import 'package:squch/features/map_page_feature/presentation/controller/map_controller.dart';

import '../../../../core/apiHelper/api_constant.dart';
import '../../../../core/service/Socket_Service.dart';
import '../../data/models/chat_history_model.dart';

class ChatController extends GetxController {

  TextEditingController chatMessageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  RxBool isLoading = false.obs;
  RxBool isLoadingAllMessages = false.obs;
  final SharedPref sharedPref;
  ChatController({required this.sharedPref});
  RxBool isOnline = false.obs;
  RxBool chatSendOption = false.obs;
  RxList<Messages> messageList = <Messages>[].obs;
  late MapController mapController;
  @override
  void onInit() {
    print("I am good");
    super.onInit();
    mapController =  Get.find<MapController>();
    chatMessageController.addListener(() {
      if (chatMessageController.text.trim().isEmpty) {
        chatSendOption.value = false;
      } else {
        chatSendOption.value = true;
      }
    });
    fetchMessages(true);
    notifyUserForNewChat();
  }
  void _scrollDown() {
    print("ScrollController:${scrollController.hasClients}");
    if(scrollController.hasClients){
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  void fetchMessages(bool isCallingFirstTime) {
    if(isCallingFirstTime == true){
      isLoadingAllMessages.value = true;
    }
      Get.find<SocketService>().emitWithSocket(rideFetchMessage,{"tripId": mapController.trip.value.trip?.id});
      Get.find<SocketService>().listenWithSocket(rideFetchMessage, (data) {
        ChatHistoryModel chatHistoryModel = ChatHistoryModel.fromJson(data);
        print("chatHistoryModel:${chatHistoryModel.toJson()}");
        messageList.clear();
        messageList?.addAll(
            chatHistoryModel.data?.messages ?? <Messages>[]);
         print("All Messages 1 ${messageList.length}");
        isLoadingAllMessages.value = false;
        _scrollDown();
      });
  }

  void sendMessages() {
      isLoading.value = true;
      Get.find<SocketService>().emitWithSocket(rideSendMessage, {"tripId": mapController.trip.value.trip?.id, "message": chatMessageController.text});
      Get.find<SocketService>().listenWithSocket(rideSendMessage,
              (data) {
                print("All Messages $data");
                if(data["status"] == true){
                  isLoading.value = false;
                  chatMessageController.clear();
                  fetchMessages(false);
                }
          });
}

  void notifyUserForNewChat() {
    Get.find<SocketService>().listenWithSocket(rideNewMessage,
            (data) {
          print("All Messages $data");
          fetchMessages(false);
        });
  }

}
import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:squch/features/welcome_page_feature/domain/repositories/welcome_repository.dart';
import 'package:video_player/video_player.dart';
import '../../../../common/widget/introWidget.dart';
import '../../../../core/model/dropdown_model.dart';
import '../../../../core/network_checker/common_network_checker_controller.dart';
import '../../../../core/service/LocalizationService.dart';
import '../../../../core/shared_pref/shared_pref.dart';
import '../../../../core/utils/Resource.dart';
import '../../../../core/utils/Status.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/image_utils.dart';
import '../../../../core/utils/utils.dart';
import '../../data/models/intro_screen_response_model.dart';

class IntroductionController extends GetxController {

  RxList<Widget> pageList = <Widget>[
    IntroWidget(
      index: 0,
      image: ImageUtils.introScreenOne,
      title: AppStrings.introPageOne,
      subtitle: AppStrings.introPageOneSubCaption,
    ),
    IntroWidget(
      index: 1,
      image: ImageUtils.introScreenTwo,
      title: AppStrings.introPageTwo,
      subtitle: AppStrings.introPageTwoSubCaption,
    ),
    IntroWidget(
      index: 2,
      image: ImageUtils.introScreenThree,
      title: AppStrings.introPageThree,
      subtitle: AppStrings.introPageThreeSubCaption,
    ),
    IntroWidget(
      index: 3,
      image: ImageUtils.introScreenFour,
      title: AppStrings.introPageFour,
      subtitle: AppStrings.introPageFourSubCaption,
    ),
    IntroWidget(
      index: 4,
      image: ImageUtils.introScreenFive,
      title: AppStrings.introPageFive,
      subtitle: AppStrings.introPageFiveSubCaption,
    ),
    IntroWidget(
      index: 5,
      image: ImageUtils.landing,
      title: AppStrings.landingTitle,
      subtitle: AppStrings.landingSubCaption,
    ),
  ].obs;
  RxInt index = 0.obs;
  final PageController pageController = PageController();




    final SharedPref sharedPref;
    final WelcomeRepository welcomeRepository;
    IntroductionController({required this.sharedPref,required this.welcomeRepository});
    CarouselController controllerEvents = new CarouselController();
    RxInt currentEvent = 0.obs;
    final CommonNetWorkStatusCheckerController _netWorkStatusChecker = Get.put(CommonNetWorkStatusCheckerController());
    RxBool isLoading = false.obs;
    Rx<VideoPlayerController> video_controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')).obs;
    late Future<void> initializeVideoPlayerFuture;
    final RxList<String> imgList = /*[
      *//*'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
*//*    ]*/
        [""].obs;
    @override
    void onInit(){
      _netWorkStatusChecker.updateConnectionStatus();
      getLanguageData();
      video_controller.value.addListener(() {

      });
      video_controller.value.setLooping(false);
      initializeVideoPlayerFuture = video_controller.value.initialize();
      if(index == 5) video_controller.value.play();
      // Get called when controller is created
      super.onInit();
    }

  var languageList = [
    DropdownModel(label: "English",id: "en",uniqueid: 0,dependentId: "en"),
    DropdownModel(label: "Spanish",id: "es",uniqueid: 1,dependentId: "es"),
    DropdownModel(label: "French",id: "fr",uniqueid: 2,dependentId: "fr")
  ].obs;

  Rx<DropdownModel> selectedLanguage = DropdownModel(label: "English",id: "en",uniqueid: 0,dependentId: "en").obs;
  Rx<IntroScreenData> howToUseAppData = IntroScreenData().obs;
  Rx<IntroScreenData> cancelBydriverData = IntroScreenData().obs;

  Future<void> changeLanguage()async{
    await sharedPref.setLanguage(selectedLanguage.value.id);
    LocalizationService().changeLocale(lang:selectedLanguage.value.id);

  }

  void getLanguageData() async{
    String? selectdLanguage = await sharedPref.getSelectedLanguage();
    debugPrint("Selected Language ======>> "+selectdLanguage.toString());
    if(selectedLanguage!= null){
      for(var language in languageList){
        if(selectdLanguage == language.id){
          selectedLanguage.value = language;
          changeLanguage();
        }
      }
    }
  }

    Future getIntroData(String section)async{

        if (await _netWorkStatusChecker.isInternetAvailable()) {
          isLoading.value = true;
          var body = {
            "slug": section
          };
          var header = {"":""};
          Resource resource = await welcomeRepository.getIntroData(body,header);
          if (resource.status == STATUS.SUCCESS) {
            isLoading.value = false;
            if(section =="driver-canellation-policy" || section == "user-ride-instruction" ){
              cancelBydriverData.value = resource.data;
            }else{
              howToUseAppData.value =  resource.data;
              var sliderImages =  howToUseAppData.value.content?.sliders;
              if(sliderImages!= null && sliderImages.isNotEmpty){
                imgList.clear();
                for (var slide in sliderImages){
                  imgList.value.add(slide.image??"") ;
                }

              }

            }

          } else {
            isLoading.value = false;
            showFailureSnackbar(
                "Failed", resource.message ?? "Data Load Failed");
            Get.back();
          }
        }else{
          Future.delayed(Duration(milliseconds: 500));
          Get.back();
        }

    }
    @override
    void dispose() {
      super.dispose();
      video_controller.value.dispose();
    }
  void tapNext() {
    index.value++;
    pageController.animateToPage(index.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastEaseInToSlowEaseOut);
    //if(index.value == 4) sharedPref.setIntroScreenShown(true);
  }

  void onSkip() {
    index.value = 5;
    pageController.animateToPage(pageList.length,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn);
    //sharedPref.setIntroScreenShown(true);
  }
}
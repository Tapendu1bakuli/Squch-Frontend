import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:squch/core/network_checker/common_network_checker_controller.dart';
import 'package:squch/core/utils/Resource.dart';
import 'package:squch/features/home_page_feature/presentation/tabs/home_tab.dart';
import 'package:squch/features/home_page_feature/presentation/tabs/inbox_tab.dart';
import 'package:squch/features/home_page_feature/presentation/tabs/profile_tab.dart';
import 'package:squch/features/map_page_feature/data/models/address_model.dart';
import 'package:squch/features/map_page_feature/presentation/controller/map_controller.dart';
import 'package:squch/features/map_page_feature/presentation/controller/ride_status.dart';
import 'package:squch/features/map_page_feature/presentation/map_page.dart';
import 'package:squch/features/map_page_feature/presentation/search_ride.dart';
import 'package:squch/features/user_auth_feature/data/models/login_response.dart';

import '../../../../core/model/dropdown_model.dart';
import '../../../../core/place_service/place_provider.dart';
import '../../../../core/service/LocalizationService.dart';
import '../../../../core/service/page_route_service/routes.dart';
import '../../../../core/shared_pref/shared_pref.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/utils/Status.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/image_utils.dart';
import '../../../map_page_feature/data/models/start_ride_response.dart';
import '../../domain/repositories/home_repository.dart';
import '../tabs/activity_tab.dart';
import '../tabs/wallet_tab.dart';

class HomeController extends GetxController {
  final SharedPref sharedPref;
  final HomeRepository homeRepository;
  HomeController({required this.sharedPref,required this.homeRepository});
  RxString token = "".obs;

  Rx<User?> userData = User().obs;
  RxString userName = "Guest".obs;
  TextEditingController searchController = TextEditingController();
  PlaceApiProvider placeApiProvider = PlaceApiProvider("ghug");
  final CommonNetWorkStatusCheckerController _netWorkStatusChecker =
      Get.find();

  late RxList<BottomNavigationBarItem> bottomBarItems;
  Timer? _throttle;
  RxList<Address> locationList = <Address>[].obs;
  RxList<Address> routeList = <Address>[].obs;
  RxBool enableSearch = false.obs;
  bool isSourceEnable = true;
  RxInt selectedIndex = 0.obs;
    RxList<Widget> widgetOptions = <Widget>[
    HomeTab(),
     ActivityTab(),
     WalletTab(),
    InboxTab(),
    ProfileTab(),
  ].obs;
  var languageList = [
    DropdownModel(label: "English", id: "en", uniqueid: 0, dependentId: "en"),
    DropdownModel(label: "Spanish", id: "es", uniqueid: 1, dependentId: "es"),
    DropdownModel(label: "French", id: "fr", uniqueid: 2, dependentId: "fr")
  ].obs;

  Rx<DropdownModel> selectedLanguage =
      DropdownModel(label: "English", id: "en", uniqueid: 0, dependentId: "en")
          .obs;


  void onItemTapped(int index) {
      selectedIndex.value = index;
  }
  @override
  void onInit() {
    _netWorkStatusChecker.updateConnectionStatus();
    getLanguageData();
    ///TESTING POURPOSE OFF
    ///ACTIVE OF RIDE STATE
    ///getActiveTripData();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getCurrentPosition() async {
    var hasPermission;
    try{
      hasPermission = await _handleLocationPermission();
    }catch(e){
      debugPrint("ERROR: $e");
    }
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      getAddressFromLatLng(position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(
          SnackBar(content: Text("location_services_are_disabled".tr)));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(
            SnackBar(content: Text("location_permissions_are_denied".tr)));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(SnackBar(
          content: Text("location permissions_are_permanently_denied".tr)));
      return false;
    }
    return true;
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      routeList.insert(
          0,
          Address(
              address:
                  '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}',
              description: place.subAdministrativeArea,
              latitude: position.latitude,
              longitude: position.longitude));
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }


  Future<void> changeLanguage() async {
    await sharedPref.setLanguage(selectedLanguage.value.id);
    LocalizationService().changeLocale(lang: selectedLanguage.value.id);
  }

  void getLanguageData() async {
    String? selectdLanguage = await sharedPref.getSelectedLanguage();
    debugPrint("Selected Language ======>> " + selectdLanguage.toString());
    if (selectedLanguage != null) {
      for (var language in languageList) {
        if (selectdLanguage == language.id) {
          selectedLanguage.value = language;
          changeLanguage();
        }
      }
    }
  }

  void getUserData() async {
    LoginData? loginData = await sharedPref.getLogindata();
    if (loginData != null) userData.value = loginData.user!;
    debugPrint("UserData ======>> " + userData.toString());
    if (userData.value != null) {
      setData(userData.value!);
    }
  }

  void setData(User userData) {
    userName.value = userData.firstName ?? "Guest";
  }

  void getActiveTripData() async{
    token.value = await sharedPref.getToken();
    Resource resource = await homeRepository.getActiveRideData({"x-access-token": token.value});
    if(resource.status == STATUS.SUCCESS){
      sharedPref.setCurrentTrip(jsonEncode(resource.data));
      MapController mapController = Get.find<MapController>();
      mapController.setCurrentMapStateOnActiveRide(trip: resource.data);
      Get.toNamed(Routes.SEARCH_RIDE);
      Get.toNamed(Routes.MAP_PAGE);
    }else{
      sharedPref.setCurrentTrip(jsonEncode(null));
      sharedPref.setCurrentState(RideStatus.INITIAL_MAP);
    }
  }


}

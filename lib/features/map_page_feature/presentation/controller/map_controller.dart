import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/model/country_model.dart';
import 'package:squch/core/network_checker/common_network_checker_controller.dart';
import 'package:squch/core/service/page_route_service/routes.dart';
import 'package:squch/features/chat_screen_features/presentation/controller/chat_controller.dart';
import 'package:squch/features/map_page_feature/data/models/init_ride_response.dart';
import 'package:squch/features/map_page_feature/data/models/start_ride_response.dart';
import 'package:squch/features/map_page_feature/domain/repositories/map_repository.dart';
import 'package:squch/features/map_page_feature/presentation/controller/ride_status.dart';
import 'package:squch/features/map_page_feature/presentation/widgets/end_point_marker.dart';
import 'package:squch/features/user_auth_feature/data/models/login_response.dart';

import '../../../../config/keys.dart';
import '../../../../core/apiHelper/api_constant.dart';
import '../../../../core/model/dropdown_model.dart';
import '../../../../core/network_checker/common_no_network_widget.dart';
import '../../../../core/service/LocalizationService.dart';
import '../../../../core/service/Socket_Service.dart';
import '../../../../core/shared_pref/shared_pref.dart';
import '../../../../core/utils/Resource.dart';
import '../../../../core/utils/Status.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/fonts.dart';
import '../../../../core/utils/image_utils.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/gap.dart';
import '../../../chat_screen_features/data/models/new_message_arrived_model.dart';
import '../../../home_page_feature/data/models/socket_send_data_model.dart';
import '../../../welcome_page_feature/data/api_client/welcome_api_client.dart';
import '../../../welcome_page_feature/data/api_client/welcome_api_client_impl.dart';
import '../../../welcome_page_feature/data/models/intro_screen_response_model.dart';
import '../../../welcome_page_feature/data/repositories/welcome_repository_impl.dart';
import '../../../welcome_page_feature/domain/repositories/welcome_repository.dart';
import '../../../welcome_page_feature/presenation/cancel_by_driver.dart';
import '../../../welcome_page_feature/presenation/controller/introduction_controller.dart';
import '../../data/models/address_model.dart';
import '../../data/models/get_cancel_reasons_response.dart';
import '../../data/models/ride_booking_bid_response.dart';
import '../../data/models/ride_type_model.dart';
import '../widgets/start_point_marker.dart';

class MapController extends GetxController {
  final SharedPref sharedPref;
  final MapRepository mapRepository;
  RxList<Address> savedList = <Address>[
    Address(
        description: "Work",
        address: "Tiretti, Kolkata, West Bengal, India",
        latitude: 22.5601,
        longitude: 88.3525,
        image: ImageUtils.clock),
    Address(
        description: "Office",
        address: "College Square, Kolkata, West Bengal, India",
        latitude: 22.5601,
        longitude: 88.3525,
        image: ImageUtils.apple),
    Address(
        description: "Home",
        address: "Debendra Mullick Street, Tiretti, Kolkata",
        latitude: 22.5601,
        longitude: 88.3525,
        image: ImageUtils.homeFilled),
    Address(
        description: "Google Office",
        address: "45/1a, Radha Nath Mullick Lane, Newland",
        latitude: 22.5601,
        longitude: 88.3525,
        image: ImageUtils.google),
  ].obs;
  RxList<Address> planList = <Address>[
    Address(
        description: "Grab Now",
        address: "Tiretti, Kolkata, West Bengal, India",
        latitude: 22.5601,
        longitude: 88.3525,
        image: ImageUtils.clock),
    Address(
        description: "One way",
        address: "College Square, Kolkata, West Bengal, India",
        latitude: 262.501,
        longitude: 88.3525,
        image: ImageUtils.apple),
    Address(
        description: "For Member",
        address: "Debendra Mullick Street, Tiretti, Kolkata",
        latitude: 22.5601,
        longitude: 88.3525,
        image: ImageUtils.homeFilled),
    Address(
        description: "Google Office",
        address: "45/1a, Radha Nath Mullick Lane, Newland",
        latitude: 22.5601,
        longitude: 88.3525,
        image: ImageUtils.google),
  ].obs;
  RxList<Address> nearbyCarList = <Address>[
    Address(
        description: "Grab Now",
        address: "Tiretti, Kolkata, West Bengal, India",
        latitude: 22.572749776591444,
        longitude: 88.36444009040875,
        image: ImageUtils.carOnMap),
    Address(
        description: "One way",
        address: "College Square, Kolkata, West Bengal, India",
        latitude: 22.573158436876938,
        longitude: 88.3649336168474,
        image: ImageUtils.carOnMap),
    Address(
        description: "H9F7+9C Kolkata, West Bengal",
        address:
            "18A, Radha Nath Mullick Ln, Lalbajar, College Square, Kolkata, West Bengal 700012",
        latitude: 22.573442421630592,
        longitude: 88.3635869759021,
        image: ImageUtils.carOnMap),
    Address(
        description: "College Square, Kolkata, West Bengal 700009",
        address: "College Square, Kolkata, West Bengal 700009",
        latitude: 22.575337753341962,
        longitude: 88.36604536523038,
        image: ImageUtils.carOnMap),
    Address(
        description: "Google Office",
        address:
            "Sri GM Lane, Newland, College Square, Kolkata, West Bengal 700012",
        latitude: 22.57337561163519,
        longitude: 88.36456483865615,
        image: ImageUtils.carOnMap),
    Address(
        description: "Eliot Park",
        address:
            "Sri GM Lane, Newland, College Square, Kolkata, West Bengal 700012",
        latitude: 22.576177087410706,
        longitude: 22.576177087410706,
        image: ImageUtils.carOnMap),
  ].obs;
  RxDouble mapZoomLevel = 14.4746.obs;
  RxString driverStatus = "".obs;
  DraggableScrollableController scrollableController =
      new DraggableScrollableController();
  BitmapDescriptor? pinLocationIcon;
  BitmapDescriptor? pinLocationTaxiIcon;

  MapController({required this.sharedPref, required this.mapRepository});

  //NEGOTATION
  RxDouble originalPrice = 0.0.obs;
  RxDouble minimumPrice = 0.0.obs;
  RxDouble maximumPrice = 0.0.obs;
  RxBool isLimitReachedMaximum = false.obs;
  RxBool isLimitReachedMinimum = false.obs;
  Rx<User?> userData = User().obs;
  RxString userName = "".obs;
  RxString token = "".obs;
  RxInt numberOfTextFields = 0.obs;
  RxInt maxTextFields = 3.obs;
  RxInt tappedStoppageIndex = 0.obs;
  RxBool isNegetiveActive = false.obs;
  RxBool isMapCreated = false.obs;
  late Size size = Get.size;

  Rx<TextEditingController> searchPickUpController =
      TextEditingController().obs;
  Rx<TextEditingController> searchDestController = TextEditingController().obs;
  Rx<TextEditingController> mapSearchBoxController =
      TextEditingController().obs;
  RxList<TextEditingController> textEditingControllers =
      <TextEditingController>[].obs;

  final CommonNetWorkStatusCheckerController _netWorkStatusChecker =
      Get.put(CommonNetWorkStatusCheckerController());
  Timer? _throttle;
  RxList<String> location = <String>[].obs;
  List<String> subText = [];
  List<double> latitude = [];
  List<double> longitude = [];
  double currLat = 0.0;
  double currLong = 0.0;
  late double destLat;
  late double destLong;
  RxDouble mapBottomPadding = 200.0.obs;
  RxDouble bottomSheetMinSize = 0.0.obs;
  RxDouble bottomSheetMaxSize = 0.0.obs;
  RxDouble bottomSheetIntSize = 0.0.obs;
  Rx<IntroScreenData> passengerInstructionContent = IntroScreenData().obs;

  RxBool enableSearch = false.obs;
  RxList<Address> locationList = <Address>[].obs;
  RxList<Address> routeList = <Address>[].obs;
  RxList<Address> stoppageList = <Address>[].obs;
  Rx<Address?> sourceAddress = Address().obs;
  Rx<Address?> destinationAddress = Address().obs;
  RxList<CancelReasons>? cancelReasons = <CancelReasons>[].obs;
  RxBool searchingForDriver = false.obs;
  RxBool isLoading = false.obs;
  RxBool isMapSearchBoxVisible = true.obs;
  RxBool isSourceEnable = true.obs;
  RxBool isStoppage = true.obs;

  Rx<RideStatus> rideStatus = RideStatus.INITIAL_MAP.obs;

  RxBool isRideDriverSearching = false.obs;
  final MarkerId markerIdPickup = const MarkerId("markerPickup");
  final MarkerId markerIdDestination = const MarkerId("markerDestination");
  final RxSet<Polyline> polyline = Set<Polyline>().obs;
  PolylinePoints polylinePoints = PolylinePoints();

  //MAP Page
  static const CameraPosition defaultLocation = CameraPosition(
    target: LatLng(23.030357, 72.517845),
    zoom: 14.4746,
  );

  final mapController = Completer<GoogleMapController>();
  Rx<GoogleMapController>? googleMapController;
  var defaultPinTheme;
  var focusedPinTheme;
  var submittedPinTheme;

  RxList<RideTypeModel> rideTypes = <RideTypeModel>[
    RideTypeModel(
        rideTypeId: "0",
        rideTypeName: AppStrings.ride.tr,
        icon: ImageUtils.rideIcon,
        isSelected: true),
    RideTypeModel(
        rideTypeId: "1",
        rideTypeName: AppStrings.shareRide.tr,
        icon: ImageUtils.rideShare,
        isSelected: false),
    RideTypeModel(
        rideTypeId: "2",
        rideTypeName: AppStrings.scheduleLater.tr,
        icon: ImageUtils.rideShare,
        isSelected: false)
  ].obs;

  RxInt acceptedBid = 0.obs;
  late Rx<Bids> selectedBid = Bids().obs;

  @override
  void onInit() {
    //
    //mapSize.value = size.height;
    getUserData();
    getCurrentPosition();
    _netWorkStatusChecker.updateConnectionStatus();
    searchPickUpController.value.addListener(onSearchChangedPickup);
    searchDestController.value.addListener(onSearchChangedDropOff);
    getLanguageData();
    pinController.setText("");
    defaultPinTheme = PinTheme(
      width: 30.ss,
      height: 30.ss,
      textStyle: TextStyle(
          fontSize: 20.fss,
          color: AppColors.colorWhite,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.buttonColor),
          color: AppColors.buttonColor),
    );

    focusedPinTheme = defaultPinTheme.copyDecorationWith(
        border: Border.all(color: AppColors.colorWhite),
        color: AppColors.buttonColor);

    submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColors.buttonColor,
      ),
    );
    super.onInit();
  }

  @override
  void onClose() {
    searchPickUpController.value.removeListener(onSearchChangedPickup);
    searchPickUpController.value.dispose();
    searchDestController.value.removeListener(onSearchChangedDropOff);
    searchDestController.value.dispose();
    googleMapController?.value.dispose();
    super.onClose();
  }

  Rx<DropdownModel> selectedLanguage =
      DropdownModel(label: "English", id: "en", uniqueid: 0, dependentId: "en")
          .obs;
  RxList<Charges> charges = <Charges>[].obs;
  Rx<CountryModel> countryModel = CountryModel.empty().obs;
  RxInt selectedCarTypeChargeIndex = 0.obs;
  Rx<Charges> selectedCharge = Charges().obs;
  Rx<InitRideData?> initRideData = InitRideData().obs;
  Rx<StartRideData?> startRideData = StartRideData().obs;
  RxBool isOtherReasonsTapped = false.obs;
  RxString cancellationReason = "".obs;
  TextEditingController reasonForOtherCancellation = TextEditingController();
  TextEditingController reasonChangingPrice = TextEditingController();
  final pinController = TextEditingController();
  RxList<MarkerData>? customMarkers = <MarkerData>[].obs;
  Rx<RideBookingBidDataData> trip = RideBookingBidDataData().obs;
  RxString newMessage = "".obs;
  RxBool isNewMessageArrived = false.obs;

  void notifyUserForNewChat() {
    Get.find<SocketService>().listenWithSocket(rideNewMessage, (data) {
      NewMessageArrivedModel newMessageArrivedModel =
          NewMessageArrivedModel.fromJson(data);
      print("newMessageArrivedModel:${newMessageArrivedModel.toJson()}");
      print("All Messages 1 ${newMessageArrivedModel.message?.inbox?.tripId}");
      if (newMessageArrivedModel.message?.inbox?.tripId ==
          trip.value.trip?.id) {
        isNewMessageArrived.value = true;
        newMessage.value = newMessageArrivedModel.message?.message ?? "";
      }
    });
  }

  Future<void> changeLanguage() async {
    await sharedPref.setLanguage(selectedLanguage.value.id);
    LocalizationService().changeLocale(lang: selectedLanguage.value.id);
  }

  void getLocationResults(String input) async {
    final String androidKey = mapApiKey;
    final String iosKey = mapApiKey;
    final apiKey = Platform.isAndroid ? androidKey : iosKey;
    if (input.isEmpty) {
      enableSearch.value = false;
    } else {
      enableSearch.value = true;
      String request =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&location=${currLat}%2C${currLong}&radius=20000&key=$apiKey";
      debugPrint("REQ: $request");
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        locationList.clear();
        var parsed = json.decode(utf8.decode(response.bodyBytes));
        List predictions = parsed['predictions'];
        print(predictions);
        for (int i = 0; i < predictions.length; i++) {
          locationList.add(Address(
              id: parsed['predictions'][i]['place_id'],
              description: parsed['predictions'][i]['description'],
              address: parsed['predictions'][i]['structured_formatting']
                  ['main_text']));
          debugPrint(locationList[i].toJson().toString());
        }
      } else {
        var parsed = json.decode(utf8.decode(response.bodyBytes));
        debugPrint(parsed);
      }
    }
  }

  void getLanguageData() async {
    String? selectdLanguage = await sharedPref.getSelectedLanguage();
    debugPrint("Selected Language ======>> " + selectdLanguage.toString());
  }

  void getUserData() async {
    LoginData? loginData = await sharedPref.getLogindata();
    if (loginData != null) {
      userData.value = loginData.user!;
      token.value = loginData.token!;
      debugPrint("UserData ======>> " + userData.toString());
      debugPrint("Token ======>> " + token.value.toString());
    }
    if (userData.value != null) {
      setData(userData.value!);
    }
  }

  void setData(User userData) {
    userName.value = userData.firstName ?? "";
  }

  Future<void> getCurrentPosition() async {
    searchDestController.value.text = "";
    /* if (routeList.length > 1) {
      try {
        routeList.removeAt(1);
      } catch (e) {}
    }*/
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currLat = position.latitude;
      currLong = position.longitude;
      getAddressFromLatLng(LatLng(position.latitude, position.longitude));
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

  Future<void> getAddressFromLatLng(LatLng position, {int? index}) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks.last;
      debugPrint("Address = ${place.toJson()}");
      debugPrint("Full Address = ${placemarks}");
      debugPrint(
          'Place: ${place.street}, ${place.locality}, /*${place.administrativeArea},*/ ${place.postalCode}');

      debugPrint("Route Index ${index}");

      if (index != null) {
        /* if (routeList.length > 1) {
          routeList.removeAt(index);

          routeList.insert(
              index,destinationAddress.value
              );
        }*/
        destinationAddress.value = Address(
            address: '${place.locality}',
            description:
                '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}',
            latitude: position.latitude,
            longitude: position.longitude);

        ///Set Destination to the textbox

        if (searchDestController.value.hasListeners) {
          searchDestController.value.removeListener(onSearchChangedPickup);
          searchDestController.value.text =
              destinationAddress.value!.getAddress;
          Future.delayed(Duration(milliseconds: 100));
          searchDestController.value.addListener(onSearchChangedPickup);
        } else {
          searchDestController.value = TextEditingController();
          searchDestController.value.text =
              destinationAddress.value!.getAddress;
          Future.delayed(Duration(milliseconds: 100));
          searchDestController.value.addListener(onSearchChangedPickup);
        }
      } else {
        sourceAddress.value = Address(
            address: '${place.locality}',
            description:
                '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}',
            latitude: position.latitude,
            longitude: position.longitude);

        ///Set Source to the text box

        if (searchPickUpController.value.hasListeners) {
          searchPickUpController.value.removeListener(onSearchChangedPickup);
          searchPickUpController.value.text = sourceAddress.value!.getAddress;
          Future.delayed(Duration(milliseconds: 100));
          searchPickUpController.value.addListener(onSearchChangedPickup);
        } else {
          searchPickUpController.value = TextEditingController();
          searchPickUpController.value.text = sourceAddress.value!.getAddress;
          Future.delayed(Duration(milliseconds: 100));
          searchPickUpController.value.addListener(onSearchChangedPickup);
        }
        /*  routeList.insert(
            0,sourceAddress.value?
           );*/
      }
      /*if (index != null && routeList.isNotEmpty) {
        if (searchDestController.value.hasListeners) {
          searchDestController.value.removeListener(onSearchChangedPickup);
          // searchDestController.value.text = routeList.first.getAddress;
          searchDestController.value.text = destinationAddress.value?.getAddress;
          Future.delayed(Duration(milliseconds: 100));
          searchDestController.value.addListener(onSearchChangedPickup);
        } else {
          searchDestController.value = TextEditingController();
          // searchDestController.value.text = routeList.first.getAddress;
          searchDestController.value.text = sourceAddress.value?.getAddress;
          Future.delayed(Duration(milliseconds: 100));
          searchDestController.value.addListener(onSearchChangedPickup);
        }
      }
      else {
        if (searchPickUpController.value.hasListeners) {
          searchPickUpController.value.removeListener(onSearchChangedPickup);
          // searchPickUpController.value.text = routeList.first.getAddress;
          searchPickUpController.value.text = sourceAddress.value?.getAddress;
          Future.delayed(Duration(milliseconds: 100));
          searchPickUpController.value.addListener(onSearchChangedPickup);
        } else {
          searchPickUpController.value = TextEditingController();
          // searchPickUpController.value.text = routeList.first.getAddress;
          searchPickUpController.value.text = destinationAddress.value?.getAddress;
          Future.delayed(Duration(milliseconds: 100));
          searchPickUpController.value.addListener(onSearchChangedPickup);
        }
      }*/

      refresh();
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  onSearchChangedPickup() {
    if (_throttle?.isActive ?? false) _throttle?.cancel();
    _throttle = Timer(const Duration(milliseconds: 500), () {
      getLocationResults(searchPickUpController.value.text);
    });
  }

  onSearchChangedDropOff() {
    if (_throttle?.isActive ?? false) _throttle?.cancel();
    _throttle = Timer(const Duration(milliseconds: 500), () {
      getLocationResults(searchDestController.value.text);
    });
  }

  onSearchChangedStoppage() {
    debugPrint(
        "Text Changed : ${textEditingControllers[tappedStoppageIndex.value].text}");
    if (_throttle?.isActive ?? false) _throttle?.cancel();
    _throttle = Timer(const Duration(milliseconds: 500), () {
      getLocationResults(
          textEditingControllers[tappedStoppageIndex.value].text);
    });
  }

  void callInitRideApi(BuildContext context, {bool? isDragChange}) async {
    debugPrint("Source ===>>> ${sourceAddress.value?.getAddress}");
    debugPrint("Destination ===>>> ${destinationAddress.value?.getAddress!}");

    if (isDragChange == null) {
      manageMapState(RideStatus.DRIVER_SEARCHING);
    } else {
      //do nothing
    }
    if (await _netWorkStatusChecker.isInternetAvailable()) {
      isLoading.value = true;
      var header = {"x-access-token": token.value};

      var body = {
        /* "pickup_lat": routeList.value.first.latitude,
        "pickup_long": routeList.value.first.longitude,
        "destination_lat": routeList.value.last.latitude,
        "destination_long": routeList.value.last.longitude*/

        "pickup_lat": sourceAddress.value?.latitude,
        "pickup_long": sourceAddress.value?.longitude,
        "destination_lat": destinationAddress.value?.latitude,
        "destination_long": destinationAddress.value?.longitude,
        "stoppages": stoppageList.value.map((v) => v.toJson()).toList()
      };
      print("Request body =>> " + body.toString());
      Resource initRideResource = await mapRepository.initRide(body, header);
      if (initRideResource.status == STATUS.SUCCESS) {
        initRideData.value = initRideResource.data;
        charges.value = initRideData.value!.charges ?? [];
        countryModel.value =
            initRideData.value?.countryModel ?? CountryModel.empty();
        isLoading.value = false;
        if (isDragChange == null) {
          manageMapState(RideStatus.VEHICLE_TYPE_BOTTOM_SHEET_SHOWING);
          selectedCarTypeChargeIndex.value = 0;
          originalPrice.value = charges.value.first.price?.toDouble() ?? 0.0;
          minimumPrice.value =
              charges.value.first.minAskingPrice?.toDouble() ?? 0.0;
          maximumPrice.value =
              charges.value.first.maxAskingPrice?.toDouble() ?? 0.0;
        } else {
          manageMapState(RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING);
        }
        mapSearchBoxController.value.text =
            initRideData.value?.origin?.description ?? "";
        if (charges.value.isNotEmpty) {
          //createMarker();
        } else
          showFailureSnackbar(
              "Failure", initRideResource.message ?? "No type of ride found");
      } else {
        isLoading.value = false;
        showFailureSnackbar(
            "Failed", initRideResource.message ?? "Loading Failed");
      }
    } else {
      Get.dialog(const CommonNoInterNetWidget());
    }
  }

  void callFindADriverApi(
      {required BuildContext context,
      required String vehicleId,
      required String askingPrice,
      required String paymentMode}) async {
    debugPrint("Destination ===>>> ${destinationAddress.value?.address!}");
    manageMapState(RideStatus.INITIAL_MAP);
    if (await _netWorkStatusChecker.isInternetAvailable()) {
      isLoading.value = true;
      var header = {"x-access-token": token.value};
      var body = {
        /*"pickup_lat": routeList.first.latitude,
        "pickup_long": routeList.first.longitude,
        "destination_lat": routeList.last.latitude,
        "destination_long": routeList.last.longitude,*/

        "pickup_lat": sourceAddress.value?.latitude,
        "pickup_long": sourceAddress.value?.longitude,
        "destination_lat": destinationAddress.value?.latitude,
        "destination_long": destinationAddress.value?.longitude,
        "stoppages": stoppageList.value,
        "vehicleTypeId": vehicleId,
        "askingPrice": askingPrice,
        "paymentMode": paymentMode
      };
      Resource startRideResource =
          await mapRepository.findADriver(body, header);

      if (startRideResource.status == STATUS.SUCCESS) {
        startRideData.value = startRideResource.data;
        print("FindDriver Response : ${startRideData.value?.toJson()}");
        isLoading.value = false;
        isRideDriverSearching.value == true;
        manageMapState(RideStatus.DRIVER_SEARCHING);
        startActiveRideWithSocket();
        sharedPref.setCurrentTrip(jsonEncode(startRideData.value));
        sharedPref.setCurrentState(RideStatus.DRIVER_SEARCHING);
      } else {
        isLoading.value = false;
        manageMapState(RideStatus.RIDE_DETAILS_BOTTOM_SHEET_SHOWING);
        showFailureSnackbar(
            "Failed", startRideResource.message ?? "Loading Failed");
      }
    } else {
      Get.dialog(const CommonNoInterNetWidget());
    }
  }

  void findReasonToCancelRide() async {
    if (await _netWorkStatusChecker.isInternetAvailable()) {
      isLoading.value = true;
      var header = {"x-access-token": token.value};
      GetCancelRideReasonModel getCancelRideReasonModel =
          await mapRepository.findReasonToCancelRide(header);
      if (getCancelRideReasonModel.status ?? false) {
        manageMapState(RideStatus.REASON_TO_CANCEL_RIDE);
        cancelReasons?.clear();
        cancelReasons?.addAll(
            getCancelRideReasonModel.data?.cancelReasons ?? <CancelReasons>[]);
        print("Cancel Ride:${cancelReasons?.length}");
      } else {
        isLoading.value = false;
        showFailureSnackbar(
            "Failed", getCancelRideReasonModel.message ?? "Loading Failed");
      }
    } else {
      Get.dialog(const CommonNoInterNetWidget());
    }
    isLoading.value = false;
  }

  void showFreeCallDriverBottomSheet(BuildContext context) {
    Get.bottomSheet(
        ignoreSafeArea: true,
        Container(
          decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.ss),
                topLeft: Radius.circular(15.ss),
              )),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 10.ss),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(10.ss),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 5.ss,
                            width: 80.ss,
                            color: AppColors.colorgrey,
                          ),
                        ],
                      ),
                      Gap(10.ss),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.ss),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.CallWithoutSharingYourNumber.tr,
                              style: CustomTextStyle(
                                  fontSize: 16.fss,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.titleColor),
                            ),
                          ],
                        ),
                      ),
                      Gap(10.ss),
                      Divider(
                          color: AppColors.titleColor.withOpacity(0.5),
                          thickness: 0.3.ss),
                      Gap(10.ss),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.ss),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              "Turn on in-app calling to call your driver using cellular data, and keep your phone number private.",
                              style: CustomTextStyle(
                                  fontSize: 12.fss,
                                  fontWeight: FontWeight.w600),
                              overflow: TextOverflow.clip,
                            )),
                          ],
                        ),
                      ),
                      Gap(10.ss),
                      Divider(
                          color: AppColors.titleColor.withOpacity(0.5),
                          thickness: 0.3.ss),
                      Gap(10.ss),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.ss),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 40.ss,
                                width: size.width - 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.ss)),
                                    color: AppColors.buttonColor),
                                child: Center(
                                    child: Text("NEXT",
                                        style: CustomTextStyle(
                                            fontSize: 14.fss,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.colorWhite))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(10.ss),
                      Divider(
                          color: AppColors.titleColor.withOpacity(0.5),
                          thickness: 0.3.ss),
                      Gap(10.ss),
                      Positioned(
                        bottom: 1.ss,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                "Cancel",
                                style: CustomTextStyle(color: Colors.redAccent),
                              ),
                            )
                          ],
                        ),
                      ),
                      Gap(20.ss),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: false);
  }

  Future driverSearch() async {
    Future.delayed(Duration(seconds: 1), () {
      isRideDriverSearching.value = false;
      update();
    });
  }

  void tappedOnSaved({required Address address}) {
    searchDestController.value.removeListener(onSearchChangedDropOff);
    searchDestController.value.text = address.getAddress;
    Future.delayed(Duration(milliseconds: 100));
    searchDestController.value.addListener(onSearchChangedDropOff);
  }

  void createMarker(
      {bool? drivertopickuppoint, Image? sourcePin, Image? destPin}) {
    customMarkers!.clear();

    ///For adding nearby cars
    /*  nearbyCarList.forEach((element) {
      customMarkers?.add(MarkerData(
        marker: Marker(
            markerId: MarkerId(DateTime.now().toString()),
            position: LatLng(element.latitude ?? 0.0, element.longitude ?? 0.0),
            ),
        child: Container(child: Image.asset(ImageUtils.carOnMap),),

      ));
    });*/

    customMarkers?.add(MarkerData(
        marker: Marker(
          markerId: markerIdPickup,
          position: drivertopickuppoint ?? false
              ? LatLng(routeList.first.latitude ?? 0.0,
                  routeList.first.longitude ?? 0.0)
              : LatLng(sourceAddress.value?.latitude ?? 0.0,
                  sourceAddress.value?.longitude ?? 0.0),
          draggable:
              rideStatus.value == RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING
                  ? true
                  : false,
          onTap: () {},
          consumeTapEvents:
              rideStatus.value == RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING
                  ? true
                  : false,
          onDragEnd: ((newPosition) async {
            changeSourceFromMap(newPosition);
          }),
          onDrag: ((position) {
            debugPrint("Draging ${position.longitude}");
          }),
          onDragStart: ((position) {}),
        ),
        child: StartPointMarker(
            description: drivertopickuppoint ?? false
                ? routeList.first.getDescription.split(",").first
                : sourceAddress.value?.getAddress,
            pin: sourcePin)));

    customMarkers?.add(MarkerData(
        marker: Marker(
          markerId: markerIdDestination,
          position: drivertopickuppoint ?? false
              ? LatLng(routeList.last.latitude ?? 0.0,
                  routeList.last.longitude ?? 0.0)
              : LatLng(destinationAddress.value?.latitude ?? 0.0,
                  destinationAddress.value?.longitude ?? 0.0),
          draggable:
              rideStatus.value == RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING
                  ? true
                  : false,
          consumeTapEvents:
              rideStatus.value == RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING
                  ? true
                  : false,
          onDragEnd: ((newPosition) async {
            changeDestinationFromMap(newPosition);
          }),
          onDrag: ((position) {
            debugPrint("Draging ${position.longitude}");
          }),
          onDragStart: ((position) {}),
        ),
        child: EndPointMarker(
          driverDuration:
              "${initRideData.value?.distanceMatrix?.param?.duration?.text ?? ""}",
          description: drivertopickuppoint ?? false
              ? routeList.last.getDescription.split(",").first
              : destinationAddress.value?.getDescription.split(",").first,
          pin: destPin,
        )));

    if (drivertopickuppoint == null || drivertopickuppoint == false) {
      for (int i = 0; i < stoppageList.length; i++) {
        customMarkers?.add(MarkerData(
            marker: Marker(
              markerId: MarkerId(i.toString()),
              position: LatLng(stoppageList[i].latitude ?? 0.0,
                  stoppageList[i].longitude ?? 0.0),
            ),
            child: Image.asset(
              ImageUtils.stoppageMarker,
              height: 12.ss,
              width: 12.ss,
            )));
      }
    }
    getDirections();
    updateMapToBounds(
        merchantLatLong: LatLng(sourceAddress.value?.latitude ?? 0.0,
            sourceAddress.value?.longitude ?? 0.0),
        userLatLong: LatLng(destinationAddress.value?.latitude ?? 0.00,
            destinationAddress.value?.longitude ?? 0.0),
        includeStoppages: !(drivertopickuppoint ?? false));
  }

  void onMapCreated(GoogleMapController _controller) async {
    print("MAP Created ");
    googleMapController?.value = _controller;
    /* updateMapToBounds(
      _controller,
      LatLng(routeList.first.latitude ?? 0.0, routeList.first.longitude ?? 0.0),
      LatLng(routeList.last.latitude ?? 0.0, routeList.last.longitude ?? 0.0),
    );*/
    await updateCameraLocation(
        LatLng(sourceAddress.value?.latitude ?? 0.0,
            sourceAddress.value?.longitude ?? 0.0),
        LatLng(destinationAddress.value?.latitude ?? 0.0,
            destinationAddress.value?.longitude ?? 0.0),
        _controller);
    if (!mapController.isCompleted) {
      mapController.complete(_controller);
    }
    print("MAP Created Done: ${customMarkers?.length}");
  }

  void getDirections(
      {PointLatLng? startPoint,
      PointLatLng? endPoint,
      Color? polylineColor,
      bool? wayPointInclude = true}) async {
    List<LatLng> polylineCoordinates = [];
    List<PolylineWayPoint> waypoints = [];
    if (wayPointInclude == true) {
      for (int i = 0; i < stoppageList.length; i++) {
        waypoints.add(PolylineWayPoint(
            location:
                "${stoppageList[i].latitude},${stoppageList[i].longitude}",
            stopOver: true));
      }
    }
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        mapApiKey,
        startPoint ??
            PointLatLng(sourceAddress.value?.latitude ?? 0.0,
                sourceAddress.value?.longitude ?? 0.0),
        endPoint ??
            PointLatLng(destinationAddress.value?.latitude ?? 0.0,
                destinationAddress.value?.longitude ?? 0.0),
        wayPoints: waypoints,
        travelMode: TravelMode.driving,
        optimizeWaypoints: true,
        avoidFerries: true);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      debugPrint(result.errorMessage);
    }
    polyline.clear();
    polyline.add(Polyline(
      polylineId: const PolylineId("polyline_id"),
      visible: true,
      points: polylineCoordinates,
      color: polylineColor ?? Colors.black,
      width: 2,
    ));

    refresh();
  }

  LatLngBounds computeBounds(List<LatLng> list) {
    assert(list.isNotEmpty);
    var firstLatLng = list.first;
    var s = firstLatLng.latitude,
        n = firstLatLng.latitude,
        w = firstLatLng.longitude,
        e = firstLatLng.longitude;
    for (var i = 1; i < list.length; i++) {
      var latlng = list[i];
      s = min(s, latlng.latitude);
      n = max(n, latlng.latitude);
      w = min(w, latlng.longitude);
      e = max(e, latlng.longitude);
    }
    return LatLngBounds(southwest: LatLng(s, w), northeast: LatLng(n, e));
  }

  double getBoundsZoomLevel(LatLngBounds bounds, Size mapDimensions) {
    const double padding = 50.0;
    var worldDimension = Get.size;

    double latRad(lat) {
      var sinValue = sin(lat * pi / 180);
      var radX2 = log((1 + sinValue) / (1 - sinValue)) / 2;
      return max(min(radX2, pi), -pi) / 2;
    }

    double zoom(mapPx, worldPx, fraction) {
      return (log(mapPx / worldPx / fraction) / ln2).floorToDouble();
    }

    var ne = bounds.northeast;
    var sw = bounds.southwest;

    var latFraction = (latRad(ne.latitude) - latRad(sw.latitude)) / pi;

    var lngDiff = ne.longitude - sw.longitude;
    var lngFraction = ((lngDiff < 0) ? (lngDiff + 360) : lngDiff) / 360;

    var latZoom =
        zoom(mapDimensions.height, worldDimension.height, latFraction);
    var lngZoom = zoom(mapDimensions.width, worldDimension.width, lngFraction);

    if (latZoom < 0) return lngZoom;
    if (lngZoom < 0) return latZoom;

    return min(latZoom, lngZoom);
  }

  LatLng getCentralLatlng(List<LatLng> geoCoordinates) {
    if (geoCoordinates.length == 1) {
      return geoCoordinates.first;
    }

    double x = 0.0;
    double y = 0.0;
    double z = 0.0;

    for (var geoCoordinate in geoCoordinates) {
      var latitude = geoCoordinate.latitude * pi / 180;
      var longitude = geoCoordinate.longitude * pi / 180;

      x += cos(latitude) * cos(longitude);
      y += cos(latitude) * sin(longitude);
      z += sin(latitude);
    }

    var total = geoCoordinates.length;

    x = x / total;
    y = y / total;
    z = z / total;

    var centralLongitude = atan2(y, x);
    var centralSquareRoot = sqrt(x * x + y * y);
    var centralLatitude = atan2(z, centralSquareRoot);

    return LatLng(centralLatitude * 180 / pi, centralLongitude * 180 / pi);
  }

  Future updateMapToBounds(
      {required LatLng userLatLong,
      required LatLng merchantLatLong,
      required bool includeStoppages}) async {
    List<LatLng> geoCoordinates = [merchantLatLong, userLatLong];
    if (includeStoppages) {
      for (int i = 0; i < stoppageList.length; i++) {
        if (stoppageList[i].latitude != null &&
            stoppageList[i].longitude != null) {
          geoCoordinates.add(LatLng(stoppageList[i].latitude ?? 0.0,
              stoppageList[i].longitude ?? 0.0));
        }
      }
    }
    await Future.delayed(Duration(milliseconds: 50));

    mapZoomLevel.value = getBoundsZoomLevel(
            //getCurrentBounds(merchantLatLong, userLatLong),
            computeBounds(geoCoordinates),
            Size(
              Get.size.width - 40.ss,
              Get.size.height - mapBottomPadding.value - 20.ss,
            )) -
        0.2;

    print("New Center Lat Long = ${getCentralLatlng(geoCoordinates)}");
    print("Zoom Level = $mapZoomLevel");

    googleMapController?.value.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: getCentralLatlng(geoCoordinates),
        zoom: 6.8,
      )),
    );
    customMarkers?.refresh();
  }

  void changeRideType(int index) {
    debugPrint(index.toString());
    for (int i = 0; i < rideTypes.length; i++) {
      if (i == index) {
        rideTypes[i].isSelected = true;
      } else {
        rideTypes[i].isSelected = false;
      }
      if (index == 0) {
        numberOfTextFields.value = 0;
        textEditingControllers.clear();
        stoppageList.clear();
        isNegetiveActive.value = false;
        createMarker();
      }
    }
    rideTypes.refresh();
    update();
    refresh();
  }

  void sendRideRequestToDrivers() async {
    SocketSendDataModel dataModel =
        SocketSendDataModel(tripId: startRideData.value?.trip?.id.toString());
    Get.find<SocketService>()
        .emitWithSocket(customerRideBidFetch, dataModel.toJson());
  }

  void cancelRide(String reason) async {
    SocketSendDataModel dataModel = SocketSendDataModel(
        tripId: startRideData.value?.trip?.id.toString(),
        cancelReason: reason,
        status: RideTripStatus.cancelled);

    Get.find<SocketService>()
        .emitWithSocket(customerCancelRide, dataModel.toJson());
    Get.find<SocketService>().listenWithSocketOnce(customerCancelRide, (data) {
      print("customerCancelRide DATA: $data");
      if (data['status']) {
        manageMapState(RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING);
        stopAllSocketListner();
      } else {
        showFailureSnackbar(AppStrings.failed.tr, data['message']);
      }
    });
  }

  void getNewDriverFromSocket() async {
    Get.find<SocketService>().listenWithSocket(customerRideNewBid, (data) {
      print("New Driver Came: $data");
      addNewDriverFromSocket();
    });
  }

  void declineDriverRequest({required String tripId, required String bidId}) {
    Get.find<SocketService>().emitWithSocket(
        customerRideBidReject, {"tripId": tripId, "bidId": bidId});
    addNewDriverFromSocket();
  }

  void getTripStatusFromSocket() async {
    Get.find<SocketService>().listenWithSocket(rideStatusUpdate, (data) {
      debugPrint("Trip Status Update: $data", wrapWidth: 1024);
      try {
        Trip updatedTrip = Trip.fromJson(data['trip']);
        trip.value.trip?.update(trip: updatedTrip);
        stoppageList.value = trip.value.trip?.stoppages ?? [];
        debugPrint("Trip Status Update Json : ${trip.value.trip?.toJson()}", wrapWidth: 1024);
        trip.refresh();
      } catch (e) {
        e.printError();
      }
      manageStateStatusOnUpdate(data: data);
    });
  }

  void getBidSearchOutEventFromSocket() async {
    Get.find<SocketService>().listenWithSocket(customerRideBidOut, (data) {
      if (data != null) addNewDriverFromSocket();
    });
  }

  void addNewDriverFromSocket() async {
    RideBookingBidResponse rideBookingBidResponse;
    Get.find<SocketService>().emitWithSocket(customerRideBidFetch,
        {"tripId": startRideData.value?.trip?.id.toString()});
    Get.find<SocketService>().listenWithSocketOnce(customerRideBidFetch,
        (data) {
      debugPrint("New Driver Came One Time: $data", wrapWidth: 1024);
      rideBookingBidResponse = RideBookingBidResponse.fromJson(data);
      if (rideBookingBidResponse.data != null) {
        trip.value = rideBookingBidResponse.data!;
        if (trip.value != null &&
            trip.value.bids != null &&
            trip.value.bids!.isNotEmpty) {
          manageMapState(RideStatus.DRIVER_BID_ARRIVED);
        } else {
          manageMapState(RideStatus.DRIVER_SEARCHING);
        }
        trip.refresh();
        update();
      }
    });
  }

  void clearTextFields() {
    searchPickUpController.value.clear();
    searchDestController.value.clear();
    FocusScope.of(Get.context!).unfocus();
  }

  Future showPassengerInstruction() async {
    WelcomeApiClient welcomeApiClient = WelcomeApiClientImpl();
    WelcomeRepository welcomeRepository =
        WelcomeRepositoryImpl(apiClient: welcomeApiClient);

    IntroductionController introductionController = Get.put(
        IntroductionController(
            welcomeRepository: welcomeRepository, sharedPref: sharedPref));
    introductionController.getIntroData("user-ride-instruction");
    Get.to(CancelByDriver(
      pageTitle: AppStrings.passengerInstruction.tr,
    ));
  }

  void acceptDriver(
      {required String tripId, required String bidId, required int index}) {
    acceptedBid.value = index;
    selectedBid.value = trip.value.bids![index];
    Get.find<SocketService>().emitWithSocket(
        customerRideBidAccept, {"tripId": tripId, "bidId": bidId});
    startRideData.value?.trip?.driver = trip.value.bids![index].driver;
    notifyUserForNewChat();
    // manageMapState(RideStatus.RIDE_CONFIRMATION_PIN_BOTTOM_SHEET_SHOWING);
  }

  void onAnimationEnd({required Bids bids}) {
    trip.value.bids?.removeWhere((element) => element.id == bids.id);
  }

  void negotiationPriceSetting(
      double minimum, double original, double maximum, bool isIncrease) {
    if (kDebugMode) {
      print("isIncrease:$isIncrease");
      print("minimum:$minimum");
      print("original:$original");
      print("maximum:$maximum");
    }
    if (isIncrease == true) {
      if (originalPrice.value <= maximumPrice.value) {
        originalPrice.value = original + 5;
        original = originalPrice.value;
        print("Increased Fare:$originalPrice");
      }
      if (originalPrice.value >= maximumPrice.value) {
        isLimitReachedMaximum.value = true;
        isLimitReachedMinimum.value = false;
      } else {
        isLimitReachedMinimum.value = false;
        isLimitReachedMaximum.value = false;
      }
    } else {
      if (originalPrice.value >= minimumPrice.value) {
        originalPrice.value = original - 5;
        original = originalPrice.value;
        print("Decreased Fare:$originalPrice");
      }
      if (originalPrice.value <= minimumPrice.value) {
        isLimitReachedMinimum.value = true;
        isLimitReachedMaximum.value = false;
      } else {
        isLimitReachedMinimum.value = false;
        isLimitReachedMaximum.value = false;
      }
    }
    isLimitReachedMaximum.refresh();
    isLimitReachedMinimum.refresh();
  }

  RxBool isCancelledTappedFromRideDetailsPage = false.obs;

  void manageMapState(RideStatus status) {
    switch (status) {
      case RideStatus.INITIAL_MAP:
        bottomSheetIntSize.value = 0.55;
        bottomSheetMinSize.value = 0.40;
        bottomSheetMaxSize.value = 0.95;
        mapBottomPadding.value = size.height / 3;
        break;
      case RideStatus.RIDE_TYPE_BOTTOM_SHEET_SHOWING:
        bottomSheetIntSize.value = 0.65;
        bottomSheetMinSize.value = 0.40;
        bottomSheetMaxSize.value = 0.95;
        mapBottomPadding.value = size.height / 2;
        //For recreate marker so that marker can be drag.
        rideStatus.value = status;
        if (stoppageList.isNotEmpty) {
          changeRideType(1);
        } else {
          changeRideType(0);
        }
        createMarker();
        break;
      case RideStatus.VEHICLE_TYPE_BOTTOM_SHEET_SHOWING:
        bottomSheetIntSize.value = 0.6;
        bottomSheetMinSize.value = 0.40;
        bottomSheetMaxSize.value = 0.95;
        mapBottomPadding.value = size.height / 3;
        //For recreate marker so that marker can't be drag.
        rideStatus.value = status;
        createMarker();
        break;
      case RideStatus.RIDE_DETAILS_BOTTOM_SHEET_SHOWING:
        bottomSheetIntSize.value = 0.90;
        bottomSheetMinSize.value = 0.85;
        bottomSheetMaxSize.value = 0.98;
        mapBottomPadding.value = size.height;

        break;
      case RideStatus.RIDE_NEGOTIATION_BOTTOM_SHEET_SHOWING:
        bottomSheetIntSize.value = 0.7;
        bottomSheetMinSize.value = 0.48;
        bottomSheetMaxSize.value = 0.8;
        mapBottomPadding.value = size.height / 2;
        changePolyLineColor();
        break;
      case RideStatus.RIDE_NEGOTIATION_BOTTOM_SHEET_SHOWING_FOR_COMMENT:
        bottomSheetIntSize.value = 0.5;
        bottomSheetMinSize.value = 0.28;
        bottomSheetMaxSize.value = 0.5;
        mapBottomPadding.value = size.height / 2;
        changePolyLineColor();
        break;
      case RideStatus.DRIVER_SEARCHING:
        bottomSheetIntSize.value = 0.5;
        bottomSheetMinSize.value = 0.5;
        bottomSheetMaxSize.value = 0.5;
        mapBottomPadding.value = size.height / 2;
        break;
      case RideStatus.RIDE_CONFIRMATION_PIN_BOTTOM_SHEET_SHOWING:
        bottomSheetIntSize.value = 0.5;
        bottomSheetMinSize.value = 0.40;
        bottomSheetMaxSize.value = 0.95;
        mapBottomPadding.value = size.height / 2;
        createMarkerAndPolyLineForDriverToPickupPoint(
          driverLocation: Address(
            latitude: double.parse(trip.value?.trip?.driver?.latitude ?? "0.0"),
            longitude:
                double.parse(trip.value?.trip?.driver?.longitude ?? "0.0"),
            description: trip.value?.trip?.driver?.address,
            address: trip.value?.trip?.driver?.address,
          ),
          pickupPoint: Address(
            latitude: double.parse(trip.value?.trip?.sceLat ?? "0.0"),
            longitude: double.parse(trip.value?.trip?.sceLong ?? "0.0"),
            address: trip.value?.trip?.sceLocation,
            description: trip.value?.trip?.sceLocation,
          ),
          driverDuration:
              selectedBid.value.driverDistance?.duration?.text ?? "",
        );

        break;
      case RideStatus.RIDE_IN_PROGRESS:
        bottomSheetIntSize.value = 0.25;
        bottomSheetMinSize.value = 0.25;
        bottomSheetMaxSize.value = 0.80;
        mapBottomPadding.value = size.height / 2;
        createMarker(
            sourcePin: Image.asset(ImageUtils.carOnMap),
            destPin: Image.asset(
              ImageUtils.pinBlue,
              height: 25.ss,
            ));
        changePolyLineColor();
        break;
      case RideStatus.WANT_TO_CANCEL_RIDE:
        bottomSheetIntSize.value = 0.28;
        bottomSheetMinSize.value = 0.28;
        bottomSheetMaxSize.value = 0.28;
        mapBottomPadding.value = size.height * 2 / 3;
        break;
      case RideStatus.DRIVER_BID_ARRIVED:
        bottomSheetIntSize.value = 0.95;
        bottomSheetMinSize.value = 0.95;
        bottomSheetMaxSize.value = 0.95;
        mapBottomPadding.value = size.height / 5;
        break;
      case RideStatus.WANT_TO_CANCEL_RIDE_AFTER_DRIVER_ACCEPT:
        bottomSheetIntSize.value = 0.28;
        bottomSheetMinSize.value = 0.28;
        bottomSheetMaxSize.value = 0.28;
        mapBottomPadding.value = size.height * 2 / 3;
        break;
      case RideStatus.REASON_TO_CANCEL_RIDE:
        bottomSheetIntSize.value = 0.5;
        bottomSheetMinSize.value = 0.5;
        bottomSheetMaxSize.value = isOtherReasonsTapped.value ? 0.6 : 0.8;
        mapBottomPadding.value = size.height / 2;
        break;
      case RideStatus.RIDE_COMPLETED:
        Get.offAndToNamed(Routes.RATE_RIDE);
        stopAllSocketListner();
        clearPreviousUiData();
        break;
    }
    rideStatus.value = status;
  }

  void changeSourceFromMap(LatLng newPosition) async {
    await getAddressFromLatLng(newPosition);
    callInitRideApi(Get.context!, isDragChange: true);
  }

  void changeDestinationFromMap(LatLng newPosition) async {
    await getAddressFromLatLng(newPosition, index: 1);
    callInitRideApi(Get.context!, isDragChange: true);
    customMarkers?.refresh();
    searchDestController.refresh();
    /* onMapCreated(googleMapController!.value);
    refresh();
    update();*/
  }

  void clearPreviousUiData() {
    stoppageList.clear();
    isNegetiveActive.value = false;
    numberOfTextFields.value = 0;
    textEditingControllers.clear();
    polyline.clear();
    customMarkers?.clear();
    routeList.clear();
  }

  void stopAllSocketListner() {
    Get.find<SocketService>().stopListenWithSocket(customerRideBidFetch);
    Get.find<SocketService>().stopListenWithSocket(customerRideBidAccept);
    Get.find<SocketService>().stopListenWithSocket(rideStatusUpdate);
    Get.find<SocketService>().stopListenWithSocket(customerRideNewBid);
    Get.find<SocketService>().stopListenWithSocket(customerRideBidReject);
    Get.find<SocketService>().stopListenWithSocket(customerRideBidOut);
    Get.find<SocketService>().stopListenWithSocket(customerCancelRide);
    Get.find<SocketService>().stopListenWithSocket(rideSendMessage);
    Get.find<SocketService>().stopListenWithSocket(rideNewMessage);
    Get.find<SocketService>().stopListenWithSocket(rideFetchMessage);
  }

  void startActiveRideWithSocket() {
    sendRideRequestToDrivers();
    getNewDriverFromSocket();
    getBidSearchOutEventFromSocket();
    getTripStatusFromSocket();
  }

  void createMarkerAndPolyLineForDriverToPickupPoint(
      {required Address driverLocation,
      required Address pickupPoint,
      required String driverDuration}) async {
    customMarkers?.clear();
    print("Pickup Point => ${pickupPoint.toJson()}");
    print("Driver Point => ${driverLocation.toJson()}");
    customMarkers?.add(MarkerData(
        marker: Marker(
          markerId: markerIdPickup,
          position: LatLng(
              driverLocation.latitude ?? 0.0, driverLocation.longitude ?? 0.0),
        ),
        child: StartPointMarker(
          description: driverLocation.getDescription.split(",").first,
          pin: Image.asset(ImageUtils.carOnMap),
        )));

    customMarkers?.add(MarkerData(
        marker: Marker(
          markerId: markerIdDestination,
          position:
              LatLng(pickupPoint.latitude ?? 0.0, pickupPoint.longitude ?? 0.0),
        ),
        child: EndPointMarker(
          description: pickupPoint.description,
          driverDuration: driverDuration,
          pin: Image.asset(ImageUtils.pinBlue),
        )));
    changePolyLineColor(
        startPoint: PointLatLng(
            driverLocation.latitude ?? 0.0, driverLocation.longitude ?? 0.0),
        endPoint: PointLatLng(
            pickupPoint.latitude ?? 0.0, pickupPoint.longitude ?? 0.0));

    // updateMapToBounds(googleMapController?.value, LatLng(driverLocation.latitude ?? 0.0, driverLocation.longitude ?? 0.0),
    //     LatLng(pickupPoint.latitude ?? 0.0, pickupPoint.longitude ?? 0.0));
    computeBounds([
      LatLng(driverLocation.latitude ?? 0.0, driverLocation.longitude ?? 0.0),
      LatLng(pickupPoint.latitude ?? 0.0, pickupPoint.longitude ?? 0.0)
    ]);
   /* await updateCameraLocation(
        LatLng(driverLocation.latitude ?? 0.0, driverLocation.longitude ?? 0.0),
        LatLng(pickupPoint.latitude ?? 0.0, pickupPoint.longitude ?? 0.0),
        googleMapController?.value);*/

    customMarkers?.refresh();
  }

  void changePolyLineColor({PointLatLng? startPoint, PointLatLng? endPoint}) {
    getDirections(
        polylineColor: AppColors.indicatorColor,
        startPoint: startPoint,
        endPoint: endPoint,
        wayPointInclude: false);
    polyline.refresh();
    customMarkers?.refresh();
    refresh();
  }

  void setCurrentMapStateOnActiveRide({required StartRideData trip}) {
    startRideData.value = trip;
    routeList?.clear();
    routeList.add(Address(
        description: startRideData.value?.trip?.sceLocation,
        address: startRideData.value?.trip?.sceLocation,
        longitude: double.tryParse(startRideData.value?.trip?.sceLat ?? "0.0"),
        latitude:
            double.tryParse(startRideData.value?.trip?.sceLong ?? "0.0")));
    routeList.add(Address(
        description: startRideData.value?.trip?.destLocation,
        address: startRideData.value?.trip?.destLocation,
        longitude: double.tryParse(startRideData.value?.trip?.destLat ?? "0.0"),
        latitude:
            double.tryParse(startRideData.value?.trip?.destLong ?? "0.0")));
    manageStateStatusOnUpdate(data: trip.toJson());
  }

  void manageStateStatusOnUpdate({required data}) {
    debugPrint("manageStateStatusOnUpdate => $data", wrapWidth: 2048);
    if (data["trip"]["startOtp"] != null) {
      pinController.text = data["trip"]["startOtp"].toString();
      Trip updatedTrip = Trip.fromJson(data['trip']);
      trip.value.trip?.update(trip: updatedTrip);
      stoppageList.value = trip.value.trip?.stoppages ?? [];
    }
    if (data["trip"]["status"] != null) {
      driverStatus.value = data["trip"]["status"].toString();
      Trip updatedTrip = Trip.fromJson(data['trip']);
      trip.value.trip?.update(trip: updatedTrip);
      stoppageList.value = trip.value.trip?.stoppages ?? [];
    }
    if (data["trip"]["status"] != null && data["trip"]["status"] == "started") {
      driverStatus.value = data["trip"]["status"].toString();
      Trip updatedTrip = Trip.fromJson(data['trip']);
      trip.value.trip?.update(trip: updatedTrip);
      stoppageList.value = trip.value.trip?.stoppages ?? [];
      manageMapState(RideStatus.RIDE_IN_PROGRESS);
    }
    if (data["trip"]["status"] != null &&
        data["trip"]["status"] == "cancelled") {
      driverStatus.value = data["trip"]["status"].toString();
      Trip updatedTrip = Trip.fromJson(data['trip']);
      trip.value.trip?.update(trip: updatedTrip);
      stoppageList.value = trip.value.trip?.stoppages ?? [];
      manageMapState(RideStatus.VEHICLE_TYPE_BOTTOM_SHEET_SHOWING);
    }
    if (data["trip"]["status"] != null &&
        data["trip"]["status"] == "completed") {
      driverStatus.value = data["trip"]["status"].toString();
      Trip updatedTrip = Trip.fromJson(data['trip']);
      trip.value.trip?.update(trip: updatedTrip);
      stoppageList.value = trip.value.trip?.stoppages ?? [];
      manageMapState(RideStatus.RIDE_COMPLETED);
    }
    if (data["trip"]["status"] != null &&
        data["trip"]["status"] == "confirmed") {
      driverStatus.value = data["trip"]["status"].toString();
      Trip updatedTrip = Trip.fromJson(data['trip']);
      trip.value.trip?.update(trip: updatedTrip);
      stoppageList.value = trip.value.trip?.stoppages ?? [];
      manageMapState(RideStatus.RIDE_CONFIRMATION_PIN_BOTTOM_SHEET_SHOWING);
    }
  }

  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController? mapController,
  ) async {
    if (mapController == null) return;

    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 70);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }

  void enableInsertStopage() {
    isStoppage.value = true;
  }

  void desableInsertStopage() {
    isStoppage.value = false;
  }

  void enableInsertSource() {
    isSourceEnable.value = true;
    enableSearch.value = true;
  }

  void desableInsertSource() {
    isSourceEnable.value = false;
  }
}

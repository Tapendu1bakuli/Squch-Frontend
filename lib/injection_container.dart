// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:squch/features/home_page_feature/presentation/controller/home_controller.dart';
import 'package:squch/features/map_page_feature/data/api_client/map_api_client.dart';
import 'package:squch/features/map_page_feature/data/api_client/map_api_client_impl.dart';
import 'package:squch/features/map_page_feature/domain/repositories/map_repository.dart';
import 'package:squch/features/map_page_feature/presentation/controller/map_controller.dart';
import 'package:squch/features/map_page_feature/presentation/controller/map_controller.dart';
import 'package:squch/features/user_auth_feature/data/api_client/auth_api_client.dart';
import 'package:squch/features/user_auth_feature/data/api_client/auth_api_client_impl.dart';
import 'package:squch/features/user_auth_feature/data/repositories/auth_repository_impl.dart';
import 'package:squch/features/user_auth_feature/domain/repositories/auth_repository.dart';
import 'package:squch/features/user_auth_feature/presentation/controller/auth_controller.dart';
import 'package:squch/features/user_auth_feature/presentation/controller/forgot_password_controller.dart';
import 'package:squch/features/user_auth_feature/presentation/controller/registration_controller.dart';
import 'core/network_checker/common_network_checker_controller.dart';
import 'core/shared_pref/shared_pref.dart';
import 'core/shared_pref/shared_pref_impl.dart';
import 'features/map_page_feature/data/repositories/map_repository_impl.dart';
import 'features/welcome_page_feature/data/api_client/welcome_api_client.dart';
import 'features/welcome_page_feature/data/api_client/welcome_api_client_impl.dart';
import 'features/welcome_page_feature/data/repositories/welcome_repository_impl.dart';
import 'features/welcome_page_feature/domain/repositories/welcome_repository.dart';
import 'features/welcome_page_feature/presenation/controller/introduction_controller.dart';

/*final sl = GetIt.instance;

Future<void> init() async {
 // SharedPreference
  sl.registerFactory<SharedPref>(() => SharedPrefImpl());
  sl.registerFactory<CommonNetWorkStatusCheckerController>(() => CommonNetWorkStatusCheckerController());
  sl.registerLazySingleton<WelcomeApiClient>(() => WelcomeApiClientImpl());
  sl.registerLazySingleton<WelcomeRepository>(() => WelcomeRepositoryImpl(apiClient: sl.call()));

  sl.registerLazySingleton<AuthApiClient>(() => AuthApiClientImpl());
  sl.registerLazySingleton<MapApiClient>(() => MapApiClientImpl());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(apiClient: sl.call()));
  sl.registerLazySingleton<MapRepository>(() => MapRepositoryImpl(apiClient: sl.call()));
  sl.registerFactory<IntroductionController>(() => IntroductionController(sharedPref: sl.call(), welcomeRepository: sl.call()));
  sl.registerFactory<HomeController>(() => HomeController(sharedPref: sl.call()));
  sl.registerFactory<MapController>(() => MapController(sharedPref: sl.call(),mapRepository: sl.call()));
  sl.registerFactory<RegistrationController>(() => RegistrationController(sharedPref: sl.call(),authRepository: sl.call()));
  sl.registerFactory<AuthController>(() => AuthController(sharedPref: sl.call(),authRepository: sl.call()));

  sl.registerFactory<ForgotPasswordController>(() => ForgotPasswordController(sharedPref: sl.call(),authRepository: sl.call()));

  // feature:- current location
  //getx
 *//* sl.registerFactory<UberHomeController>(
      () => UberHomeController(getUserCurrentLocationUsecase: sl.call()));

  //current location Usecase

  sl.registerLazySingleton<GetUserCurrentLocationUsecase>(() =>
      GetUserCurrentLocationUsecase(userCurrentLocationRepository: sl.call()));

  // current location repository
  sl.registerLazySingleton<UserCurrentLocationRepository>(() =>
      UserCurrentLocationRepositoryImpl(
          userCurrentLocationDataSource: sl.call()));*//*

  // current location datasource


  //External
  // final auth = FirebaseAuth.instance;
  // final fireStore = FirebaseFirestore.instance;
  // final firebaseStorage = FirebaseStorage.instance;

  // sl.registerLazySingleton(() => auth);
  // sl.registerLazySingleton(() => fireStore);
  // sl.registerLazySingleton(() => firebaseStorage);
}*/

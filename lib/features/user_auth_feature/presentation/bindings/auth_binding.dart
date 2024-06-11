import 'package:get/get.dart';
import 'package:squch/features/user_auth_feature/data/repositories/auth_repository_impl.dart';
import 'package:squch/features/user_auth_feature/domain/repositories/auth_repository.dart';
import 'package:squch/features/user_auth_feature/presentation/controller/forgot_password_controller.dart';
import '../../../../core/shared_pref/shared_pref.dart';
import '../../../../core/shared_pref/shared_pref_impl.dart';
import '../../data/api_client/auth_api_client.dart';
import '../../data/api_client/auth_api_client_impl.dart';
import '../controller/auth_controller.dart';
import '../controller/registration_controller.dart';



class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedPref>(() => SharedPrefImpl(),);
    Get.lazyPut<AuthApiClient>(() => AuthApiClientImpl(),);
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(apiClient: Get.find()),);
    Get.lazyPut<AuthController>(() => AuthController(authRepository:Get.find(),sharedPref: Get.find()),);
    Get.lazyPut<RegistrationController>(() => RegistrationController(authRepository:Get.find(),sharedPref: Get.find()),);
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController(authRepository:Get.find(),sharedPref: Get.find()),);
  }
}

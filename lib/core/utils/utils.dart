
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squch/core/service/page_route_service/routes.dart';
import 'package:squch/core/utils/fonts.dart';
import 'package:squch/features/user_auth_feature/presentation/login_page.dart';
import 'package:url_launcher/url_launcher.dart';



import '../shared_pref/shared_pref.dart';

import 'app_colors.dart';


/*
Future<String> openDatePicker(
    BuildContext context, String startDate, String enddate) async {
  String formattedDate = "";
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
      // (startDate.isEmpty) ?
           DateTime.now(),
          // : DateFormat("yyyy-MM-dd").parse(startDate),
      firstDate: */
/*(enddate.isEmpty)
          ?*//*
 DateTime(1900),
          // : DateFormat("yyyy-MM-dd").parse(enddate),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(DateTime.now().year + 100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.colorDeepPrimary, // <-- SEE HERE
              onPrimary: AppColors.colorAssent, // <-- SEE HERE
              onSurface: AppColors.colorDeepPrimary, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.colorPrimary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      });

  if (pickedDate != null) {
    print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
    formattedDate = DateFormat('MM/dd/yy').format(pickedDate);
  }
  return formattedDate;
}
*/

bool isGraterDate(String startDate, String endDate) {
  bool isGrater = false;
  try {
    DateTime dt1 = DateTime.parse(startDate);
    DateTime dt2 = DateTime.parse(endDate);

    if (dt1.compareTo(dt2) == 0) {
      debugPrint("Both date time are at same moment.");
      return false;
    }

    if (dt1.compareTo(dt2) < 0) {
      debugPrint("DT1 is before DT2");
      return false;
    }

    if (dt1.compareTo(dt2) > 0) {
      debugPrint("DT1 is after DT2");
      return true;
    }
  } catch (e) {}
  return isGrater;
}



/*String convertDate(String inputdate, String format) {
  String date ="";
  try {
    print(inputdate);
    DateTime dt1 = DateTime.parse(inputdate);
    String formattedDate = DateFormat(format).format(dt1);
    print(formattedDate);
    date =  formattedDate;
  } catch (e) {}
  return date;
}

Future downloadFile(String path,String name) async {
  final taskId = await FlutterDownloader.enqueue(
    url: path,
    savedDir: 'the path of directory where you want to save downloaded files',
    showNotification: true,
    // show download progress in status bar (for Android)
    openFileFromNotification: true, // click on notification to open downloaded file (for Android)
  );
}*/
void showLogoutDialog(){
  Get.defaultDialog(title: "Warning",content: Text("Do you want to logout?",style: CustomTextStyle(),),onCancel: (){
    Get.back();
  },onConfirm: ()async{
    Get.back();
    await logoutUser();
  },textConfirm: "Yes",textCancel: "No"
  );
}
Future logoutUser()async{
  SharedPref sharedPref = Get.find();
  await sharedPref.setLoggedin(false);
  await sharedPref.setLogindata("");
  // sharedPref.clearData();
   Get.offAllNamed(Routes.LOGIN);

}


void showFailureSnackbar( String? title,String msg){
  Get.snackbar(title??"Oops!",msg,snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.colorgrey,
      colorText: Colors.red,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20)
  );
}

void showSuccessSnackbar( String? title,String msg) {
  Get.snackbar(title ?? "Oops!", msg, snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.colorgrey,
      colorText: AppColors.buttonColor,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20)
  );
}

emailValidator(String? email){
  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern.toString());
  if(email == null || email.isEmpty){
    return 'Email is empty';
  } if (!(regex.hasMatch(email))) {
    return "Please enter a valid email";
  }
  return null;
}

mobileValidator(String? mobile){

  if(mobile == null || mobile.isEmpty){
    return 'Mobile no is empty';
  } if (mobile.length<10) {
    return "Please enter a valid mobile no";
  }
  return null;
}

openDialPad(String phoneNumber) async {
  Uri url = Uri(scheme: "tel", path: phoneNumber);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    print("Can't open dial pad.");
  }
}
// String input = DateFormat('yyyy-MM-dd HH:mm:ss').format(dt1);
//     String  formattedDate = DateFormat('EEEE, MMM d, yyyy').format(input);
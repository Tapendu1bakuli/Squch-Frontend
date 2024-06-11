import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squch/core/utils/app_colors.dart';
import 'package:squch/core/utils/fonts.dart';
import 'package:squch/core/widgets/gap.dart';
import 'package:sizing/sizing.dart';
import '../../../../core/service/page_route_service/routes.dart';
import '../../../../core/utils/utils.dart';
import '../controller/home_controller.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return
      Obx(()=>
      Container(
      child: controller.userData.value!.id!=null?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Profile"),
          ),
          Gap(40.ss),
          InkWell(
              onTap: (){
                showLogoutDialog();
              },
              child: Text("Logout",style: CustomTextStyle(color: AppColors.buttonColor),)),


        ],
      ):
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
                onTap: (){
                  Get.toNamed(Routes.LOGIN,arguments: {"FromPage":"Profile"});
                },
                child: Text("Login",style: CustomTextStyle(color: AppColors.buttonColor,fontSize: 20.fss,fontWeight: FontWeight.w600),)),
          ),


        ],
      ),
    )
      );
  }
}

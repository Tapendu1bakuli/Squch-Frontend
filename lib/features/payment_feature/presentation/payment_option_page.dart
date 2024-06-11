import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squch/core/common/common_button.dart';
import 'package:squch/core/utils/app_colors.dart';
import 'package:squch/core/utils/fonts.dart';
import 'package:squch/core/utils/image_utils.dart';
import 'package:squch/core/widgets/gap.dart';
import 'package:squch/core/widgets/horizontal_gap.dart';
import 'package:squch/core/widgets/title_text.dart';
import 'package:squch/features/payment_feature/presentation/add_card.dart';
import '../../../core/widgets/common_app_bar.dart';
import 'package:sizing/sizing.dart';

class PaymentOptionPage extends StatefulWidget {
  const PaymentOptionPage({super.key});

  @override
  State<PaymentOptionPage> createState() => _PaymentOptionPageState();
}

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/12),
            child: CommonAppbar(
                title: "Payment Option",isIconShow: true,onPressed: (){
              Get.back();
            }
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.ss),
            decoration: BoxDecoration(
              color: AppColors.colorWhite,
              boxShadow: [BoxShadow(
              color: AppColors.colorgrey,
            blurRadius: 15.ss
          )]
          ),
            height: 90.ss,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("\$100.56",style: CustomTextStyle(fontWeight: FontWeight.w800,fontSize: 16.fss),),
                    Text("View Detailed Bill",style: CustomTextStyle(fontWeight: FontWeight.w600,fontSize: 14.fss,color: AppColors.colorTabIndecator),),

                  ],
                ),
                HorizontalGap(10.ss),
                Flexible(child: CommonButton(label:"Proceed to pay",))
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.ss,vertical:  10.ss),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(context, "Cards"),
                  Gap(20.ss),

                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.colorgrey),
                            borderRadius: BorderRadius.all(Radius.circular(5.ss))
                          ),
                          child: Image.asset(ImageUtils.visa)),
                      HorizontalGap(10.ss),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TitleText(context, "Personal"),
                                      Gap(5.ss),
                                      Text("*********3030"),
                                      Gap(10.ss),

                                    ],
                                  ),
                                ),
                                RadioMenuButton(value: true, groupValue: "card", onChanged: (value){},child: Container(), ),
                              ],
                            ),
                            Divider(thickness: 0.5.ss,color: AppColors.titleColor.withOpacity(0.4),)
                          ],
                        ),
                      ),

                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(AddCardPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.colorgrey),
                                    borderRadius: BorderRadius.all(Radius.circular(5.ss))
                                ),child: Image.asset(ImageUtils.card)),
                            HorizontalGap(10.ss),
                            TitleText(context, "Add credit or debit card")
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_rounded,size: 14,)
                      ],
                    ),
                  ),
                  Gap(10.ss),
                  Divider(),

                  TitleText(context, "Wallet"),
                  Gap(10.ss),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.colorgrey),
                              borderRadius: BorderRadius.all(Radius.circular(5.ss))
                          ),
                          child: Image.asset(ImageUtils.wallet)),
                      HorizontalGap(10.ss),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TitleText(context, "Your wallet"),
                                      Gap(5.ss),
                                      Row(
                                        children: [
                                          Text("Available balance "),
                                          Text("\$0.00"),
                                        ],
                                      ),
                                      Gap(10.ss),

                                    ],
                                  ),
                                ),
                                RadioMenuButton(value: true, groupValue: "card", onChanged: (value){},child: Container(), ),
                              ],
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ),
        ));
  }
}

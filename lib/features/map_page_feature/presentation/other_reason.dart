import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squch/core/utils/fonts.dart';
import 'package:squch/core/utils/image_utils.dart';
import 'package:squch/core/widgets/common_app_bar.dart';
import 'package:get/get.dart';
import 'package:squch/core/widgets/gap.dart';
import 'package:squch/core/widgets/horizontal_gap.dart';
import 'package:squch/core/widgets/title_text.dart';
import 'package:sizing/sizing.dart';

class OterReason extends StatefulWidget {
  const OterReason({super.key});

  @override
  State<OterReason> createState() => _OterReasonState();
}

class _OterReasonState extends State<OterReason> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/12),
            child: CommonAppbar(
              title: "Others",isIconShow: true,onPressed: (){
              Get.back();
            }
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(40.ss),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.0),
                    child: TitleText(context, "Need Help?"),
                  ),
                  Gap(10.ss),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("lorem ipsum dummy content lorem ipsum dummy content ",style: CustomTextStyle(),),
                  ),
                  Gap(20.ss),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.0),
                    child: TitleText(context, "Confirmation Number"),
                  ),
                  Gap(10.ss),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("XZJL8925"),
                  ),
                  Gap(10.ss),
                  Divider(),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.ss),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(ImageUtils.call),
                            HorizontalGap(20.ss),
                            TitleText(context, "Call for support")
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_rounded,size: 15.ss,)
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.ss),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(ImageUtils.msgText),
                            HorizontalGap(20.ss),
                            TitleText(context, "Chat with support")
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_rounded,size: 15.ss,)
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        )
    );
  }
}

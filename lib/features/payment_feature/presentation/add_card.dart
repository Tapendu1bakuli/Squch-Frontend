import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/common/common_text_form_field.dart';
import '../../../core/common/common_button.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/gap.dart';
import '../../../core/widgets/title_text.dart';
import 'package:get/get.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});
  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/12),
            child: CommonAppbar(
                title: "Add Card",isIconShow: true,onPressed: (){
              Get.back();
            }
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.ss),
            decoration: BoxDecoration(

            ),
            height: 90.ss,
            child: Row(
              children: [
                Flexible(child: CommonButton(label:"Add & Secure card",))
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.ss,vertical:  10.ss),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(context, "Card Number"),
                  Gap(10.ss),
                  CommonTextFormField(margin: 0.ss,),
                  Gap(20.ss),
                  TitleText(context, "Card Holder"),
                  Gap(10.ss),
                  CommonTextFormField(margin: 0.ss,),
                  Gap(20.ss),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(context, "Expiration Date"),
                            Gap(10.ss),
                            CommonTextFormField(margin: 0.ss,)
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(context, "CVV"),
                            Gap(10.ss),
                            CommonTextFormField(margin: 0.ss,)
                          ],
                        ),
                      )
                      ]
                  ),
                  Gap(20.ss),
                  Row(
                    children: [
                      RadioMenuButton(value: true, groupValue: "card", onChanged: (value){},child:  Text("Save this card for next time",), ),

                    ],
                  )


                ],
              ),
            ),
          ),
        ));
  }
}

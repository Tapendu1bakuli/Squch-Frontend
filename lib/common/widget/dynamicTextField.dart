import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/utils/app_colors.dart';
import 'package:squch/core/widgets/gap.dart';

import '../../core/common/common_text_form_field.dart';
import '../../core/utils/fonts.dart';
import '../../core/utils/image_utils.dart';

Widget DynamicTextField({
  required int numberOfTextFields,
  required bool isNegetiveActive,
  required BuildContext context,
  required Function() onTapForSource,
  required Function() onTapForDest,
  required Function() onEditingComplete,
  required Function() onStoppageEditingComplete,
  required Function() onAddNewTextField,
  required Function() onRemoveTextField,
  required TextEditingController controllerForSource,
  required TextEditingController controllerForDest,
  bool? readOnly = false,
  required int maxTextFields,
  required List<TextEditingController> textEditingControllers,
  required Function(int) onTapForStoppage,
}) {
  TextEditingController sourceController = controllerForSource;
  TextEditingController destController = controllerForDest;
  if (readOnly ?? false) {
    sourceController = TextEditingController();
    destController = TextEditingController();
    sourceController.text = controllerForSource.text;
    destController.text = controllerForDest.text;
  }
  print("No of length $numberOfTextFields");
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 0.ss),
    padding: EdgeInsets.symmetric(horizontal: 12.ss),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.ss),
        border: Border.all(color: Color(0xFFC3C3C3))),
    child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                CommonTextFormField(
                  readOnly: readOnly ?? false,
                  margin: 0,
                  controller: sourceController,
                  onTap: onTapForSource,
                  decoration: InputDecoration(
                    fillColor: AppColors.colorgrey,
                    hintText: "Add Source",
                    hintStyle: CustomTextStyle(
                        color: Theme.of(context).brightness != Brightness.dark
                            ? Colors.black87
                            : Colors.white),
                    border: InputBorder.none,
                    prefixIcon: SvgPicture.asset(ImageUtils.sourceLocationIcon,
                        width: 20.ss, height: 20.ss, fit: BoxFit.scaleDown),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0),
                   // physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfTextFields,
                    itemBuilder: (BuildContext context, int index) {
                      final isLast = index == (numberOfTextFields - 1) <0 ? false:true;

                      return Column(
                        children: [
                          const Divider(
                            color: AppColors.dividerColorForTextFields,
                          ),
                          CommonTextFormField(
                            margin: 0,
                            controller: textEditingControllers[index],
                            decoration: InputDecoration(
                              hintText: "Next Address",
                              border: InputBorder.none,
                              prefixIcon: SvgPicture.asset(
                                  isLast
                                      ? ImageUtils.destinationLocationIcon
                                      : index.isOdd
                                          ? ImageUtils.shareLocationIconGreen
                                          : ImageUtils.sourceLocationIcon,
                                  width: 20.ss,
                                  height: 20.ss,
                                  fit: BoxFit.scaleDown),
                            ),
                            onTap: () {
                              onTapForStoppage(index);
                            },
                            onEditingComplete: onStoppageEditingComplete,
                          )
                        ],
                      );
                    }),
                const Divider(
                  color: AppColors.dividerColorForTextFields,
                ),
                CommonTextFormField(
                  readOnly: readOnly ?? false,
                  margin: 0,
                  controller: destController,
                  onTap: onTapForDest,
                  onEditingComplete: onEditingComplete,
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    fillColor: AppColors.colorlightgrey,
                    hintText: "Add Destination",
                    hintStyle: CustomTextStyle(
                        color: Theme.of(context).brightness != Brightness.dark
                            ? Colors.black87
                            : Colors.white),
                    border: InputBorder.none,
                    prefixIcon: SvgPicture.asset(
                        isNegetiveActive
                            ? ImageUtils.shareLocationIconGreen
                            : ImageUtils.destinationLocationIcon,
                        width: 20.ss,
                        height: 20.ss,
                        fit: BoxFit.scaleDown),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              readOnly ?? false
                  ? const Offstage()
                  : InkWell(
                  onTap: onAddNewTextField,
                      child: Container(
                        height: 32.ss,
                        width: 32.ss,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFF7F7F7),
                          shape: OvalBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFEDEDED)),
                          ),
                        ),
                        child: const Icon(Icons.add),
                      )),
              isNegetiveActive ? Gap(20.ss) : const Offstage(),
              isNegetiveActive
                  ? InkWell(
                      onTap:(){ onRemoveTextField();},
                      child: Container(
                        height: 32.ss,
                        width: 32.ss,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFF7F7F7),
                          shape: OvalBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFEDEDED)),
                          ),
                        ),
                        child: const Icon(Icons.remove),
                      ))
                  : const Offstage()
            ],
          )
        ],
      ),

  );
}

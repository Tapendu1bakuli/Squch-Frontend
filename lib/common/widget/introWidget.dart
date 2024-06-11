import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/fonts.dart';
import '../../core/widgets/gap.dart';

class IntroWidget extends StatelessWidget {
  IntroWidget({
    super.key,
    this.image,
    this.index,
    this.title,
    this.subtitle,
  });

  final String? image;
  final int? index;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(),
        Positioned(
          top: -(MediaQuery.sizeOf(context).height / 9.0),
          left: -62.ss,
          right: -62.ss,
          child: Container(
            height: MediaQuery.sizeOf(context).height / 1.5,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image!), fit: BoxFit.fill)),
          ),
        ),
        Positioned(
          top: 65.ss,
          left: 35.ss,
          right: 35.ss,
          child: index == 5
              ? const Offstage()
              : Container(
                  height: 5.ss,
                  child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(
                            width: 6.ss,
                          ),
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: ShapeDecoration(
                            color: this.index == index
                                ? AppColors.colorWhite
                                : AppColors.colorWhite.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          height: 5.ss,
                          width: 60.ss,
                        );
                      }),
                ),
        ),
        Positioned(
          bottom: MediaQuery.sizeOf(context).height / 8,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.all(20.ss),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: CustomTextStyle(
                      color: AppColors.colorBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: 30.fss),
                  overflow: TextOverflow.clip,
                ),
                Gap(10.ss),
                Text(
                  subtitle!,
                  style: CustomTextStyle(
                      color: AppColors.colorBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: 17.fss),
                  overflow: TextOverflow.clip,
                ),
                Gap(20.ss),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

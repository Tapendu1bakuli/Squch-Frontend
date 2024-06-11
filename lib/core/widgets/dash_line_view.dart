import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';


class DashLineView extends StatefulWidget {
  final double dashHeight;
  final double dashWith;
  final Color dashColor;
  int fillRate; // [0, 1] totalDashSpace/totalSpace
  final Axis direction;

  DashLineView(
      {this.dashHeight = 8,
        this.dashWith = 80,
        this.dashColor = AppColors.loaderProgressColor,
        this.fillRate = -1,
        this.direction = Axis.horizontal});

  @override
  State<DashLineView> createState() => _DashLineViewState();
}

class _DashLineViewState extends State<DashLineView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      //code to run on every 2 minutes 5 seconds

      try {
        setState(() {
          widget.fillRate++;
          if (widget.fillRate > 4) widget.fillRate = -1;
        });
      }catch(e){}


    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final dCount = 4;
        return Flex(
          children: List.generate(dCount, (_) {
            return SizedBox(
              width: widget.direction == Axis.horizontal
                  ? widget.dashWith
                  : widget.dashHeight,
              height: widget.direction == Axis.horizontal
                  ? widget.dashHeight
                  : widget.dashWith,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: widget.fillRate == -1
                        ? AppColors.colorgrey
                        : _ <= widget.fillRate
                        ? widget.dashColor
                        : AppColors.colorgrey),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: widget.direction,
        );
      },
    );
  }
}
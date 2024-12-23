import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ProgressIndicatorButton extends StatefulWidget {
  int step;
  ProgressIndicatorButton({
    required this.step,
    super.key,
  });

  @override
  _ProgressIndicatorButtonState createState() =>
      _ProgressIndicatorButtonState();
}

class _ProgressIndicatorButtonState extends State<ProgressIndicatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  List<String> images = [
    Images.orderPlacedIcn,
    Images.orderPickUp,
    Images.orderInprocess,
    Images.orderDispatched,
    Images.orderDeliveredIcn
  ];
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.step),
    );
    _animation = Tween<double>(begin: 0, end: widget.step.toDouble())
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ))
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularStepProgressIndicator(
              width: 0.2,
              totalSteps: 100,
              currentStep: (_animation.value * 20).round(),
              stepSize: 2,
              selectedColor: AppColors.actionBlue,
              unselectedColor: AppColors.backgroundWhite,
              padding: 0,
              child: const SizedBox(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: const BoxDecoration(),
              width: 30,
              height: 30,
              child: Image(
                  image: AssetImage(images[_animation.value.round() <= 0
                      ? 0
                      : _animation.value.round() - 1])),
            ),
          ),
        ],
      ),
    );
  }
}

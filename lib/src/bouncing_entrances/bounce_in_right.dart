// ignore_for_file: use_super_parameters

import 'package:animate_it/src/bouncing_entrances/bounce_in_left.dart';
import 'package:flutter/material.dart';

///{@template bounce_in_right}
/// A bounce in right effect
///{@endtemplate}
class BounceInRight extends StatelessWidget {
  ///{@macro bounce_in_right}
  BounceInRight({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.from = 75,
  }) : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError(
        'If you want to use manualTrigger:true, \n\n'
        'Then you must provide the controller property, that is a '
        'callback like: \n\n'
        ' ( controller: AnimationController) => yourController = controller '
        '\n\n',
      );
    }
  }

  /// [child]: mandatory, widget to animate
  final Widget child;

  /// [duration]: how much time the animation should take
  final Duration duration;

  /// [delay]: delay before the animation starts
  final Duration delay;

  /// [controller]: optional/mandatory, exposes the animation controller created by animate_it
  /// the controller can be use to repeat, reverse and anything you want,
  /// its just an animation controller
  final void Function(AnimationController)? controller;

  /// [manualTrigger]: whether the animation should animate by default
  final bool manualTrigger;

  /// [animate]: whether the animation should animate by default
  final bool animate;

  /// [from]: from where you want to start the animation
  final double from;

  @override
  Widget build(BuildContext context) => BounceInLeft(
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from * -1,
        child: child,
      );
}

// ignore_for_file: use_super_parameters, prefer_int_literals

import 'package:flutter/material.dart';

///{@template flash}
/// A flash effect
///{@endtemplate}
class Flash extends StatefulWidget {
  ///{@macro flash}
  Flash({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.infinite = false,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
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

  /// [infinite] loops the animation until the widget is destroyed
  final bool infinite;

  /// [controller]: optional/mandatory, exposes the animation controller created by Animate_it
  /// the controller can be use to repeat, reverse and anything you want,
  /// its just an animation controller
  final void Function(AnimationController)? controller;

  /// [manualTrigger]: whether the animation should animate by default
  final bool manualTrigger;

  /// [animate]: whether the animation should animate by default
  final bool animate;

  @override
  State<Flash> createState() => _FlashState();
}

/// State class, where the magic happens
class _FlashState extends State<Flash> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> opacityOut1;
  late Animation<double> opacityIn1;
  late Animation<double> opacityOut2;
  late Animation<double> opacityIn2;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    opacityOut1 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: controller!, curve: const Interval(0.0, 0.25)),
    );
    opacityIn1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller!, curve: const Interval(0.25, 0.5)),
    );
    opacityOut2 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: controller!, curve: const Interval(0.5, 0.75)),
    );
    opacityIn2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller!, curve: const Interval(0.75, 1.0)),
    );

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          (widget.infinite) ? controller!.repeat() : controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0.0) {
      controller?.forward();
    }

    return AnimatedBuilder(
      animation: controller!,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: (controller!.value < 0.25)
              ? opacityOut1.value
              : (controller!.value < 0.5)
                  ? opacityIn1.value
                  : (controller!.value < 0.75)
                      ? opacityOut2.value
                      : opacityIn2.value,
          child: widget.child,
        );
      },
    );
  }
}

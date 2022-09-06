// ignore_for_file: use_super_parameters, prefer_int_literals

import 'package:flutter/material.dart';

///{@template pulse}
/// A pulse effect
///{@endtemplate}
class Pulse extends StatefulWidget {
  ///{@macro pulse}
  Pulse({
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
  State<Pulse> createState() => _PulseState();
}

/// State class, where the magic happens
class _PulseState extends State<Pulse> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animationInc;
  late Animation<double> animationDec;
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

    animationInc = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    animationDec = Tween<double>(begin: 1.5, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
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
        return Transform.scale(
          scale: (controller!.value < 0.5)
              ? animationInc.value
              : animationDec.value,
          child: widget.child,
        );
      },
    );
  }
}

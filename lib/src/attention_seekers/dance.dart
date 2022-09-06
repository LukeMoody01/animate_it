// ignore_for_file: use_super_parameters, prefer_int_literals

import 'package:flutter/material.dart';

///{@template dance}
/// A dance effect
///{@endtemplate}
class Dance extends StatefulWidget {
  ///{@macro dance}
  Dance({
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
  State<Dance> createState() => _DanceState();
}

/// State class, where the magic happens
class _DanceState extends State<Dance> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> step1;
  late Animation<double> step2;
  late Animation<double> step3;

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

    step1 = Tween<double>(begin: 0.0, end: -0.2).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.0, 0.3333, curve: Curves.bounceOut),
      ),
    );

    step2 = Tween<double>(begin: -0.2, end: 0.2).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.3333, 0.6666, curve: Curves.bounceOut),
      ),
    );

    step3 = Tween<double>(begin: 0.2, end: 0.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.6666, 1.0, curve: Curves.bounceOut),
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
        final animation = (step1.value != -0.2)
            ? step1.value
            : (step2.value != 0.2)
                ? step2.value
                : step3.value;

        return Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.skew(0.0, animation),
          child: widget.child,
        );
      },
    );
  }
}

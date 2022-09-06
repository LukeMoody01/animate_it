// ignore_for_file: use_super_parameters, prefer_int_literals

import 'package:flutter/material.dart';

///{@template swing}
/// A swing effect
///{@endtemplate}
class Swing extends StatefulWidget {
  ///{@macro swing}
  Swing({
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
  State<Swing> createState() => _SwingState();
}

/// State class, where the magic happens
class _SwingState extends State<Swing> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animationRotation1;
  late Animation<double> animationRotation2;
  late Animation<double> animationRotation3;
  late Animation<double> animationRotation4;
  late Animation<double> animationRotation5;
  late Animation<double> animationRotation6;
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

    animationRotation1 = Tween<double>(begin: 0.0, end: -0.5).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.0, 0.1666, curve: Curves.easeOut),
      ),
    );

    animationRotation2 = Tween<double>(begin: -0.5, end: 0.5).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.1666, 0.3333, curve: Curves.easeInOut),
      ),
    );

    animationRotation3 = Tween<double>(begin: 0.5, end: -0.5).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.3333, 0.4999, curve: Curves.easeInOut),
      ),
    );

    animationRotation4 = Tween<double>(begin: -0.5, end: 0.4).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.4999, 0.6666, curve: Curves.easeInOut),
      ),
    );

    animationRotation5 = Tween<double>(begin: 0.4, end: -0.4).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.6666, 0.8333, curve: Curves.easeInOut),
      ),
    );

    animationRotation6 = Tween<double>(begin: -0.4, end: 0.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.8333, 1.0, curve: Curves.easeOut),
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
        final angle = (animationRotation1.value != -0.5)
            ? animationRotation1.value
            : (animationRotation2.value != 0.5)
                ? animationRotation2.value
                : (animationRotation3.value != -0.5)
                    ? animationRotation3.value
                    : (animationRotation4.value != 0.4)
                        ? animationRotation4.value
                        : (animationRotation5.value != -0.4)
                            ? animationRotation5.value
                            : animationRotation6.value;

        return Transform.rotate(
          angle: angle,
          child: widget.child,
        );
      },
    );
  }
}

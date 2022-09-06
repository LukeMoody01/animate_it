// ignore_for_file: use_super_parameters, prefer_int_literals

import 'package:flutter/material.dart';

///{@template bounce}
/// A bounce effect
///{@endtemplate}
class Bounce extends StatefulWidget {
  ///{@macro bounce}
  Bounce({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1300),
    this.delay = Duration.zero,
    this.infinite = false,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.from = 50.0,
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

  /// [infinite]: loops the animation until the widget is destroyed
  final bool infinite;

  /// [controller]: optional/mandatory, exposes the animation controller created by Animate_it
  /// the controller can be use to repeat, reverse and anything you want,
  /// its just an animation controller
  final void Function(AnimationController controller)? controller;

  /// [manualTrigger]: whether the animation should animate by default
  final bool manualTrigger;

  /// [animate]: whether the animation should animate by default
  final bool animate;

  /// [from]: from where you want to start the animation
  final double from;

  @override
  State<Bounce> createState() => _BounceState();
}

/// State class, where the magic happens
class _BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animationBounce;
  late Animation<double> animationUp;

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

    animationUp = Tween<double>(begin: 0.0, end: widget.from * -1).animate(
      CurvedAnimation(
        curve: const Interval(0.0, 0.35, curve: Curves.easeInOut),
        parent: controller!,
      ),
    );

    animationBounce =
        Tween<double>(begin: widget.from * -1.0, end: 0.0).animate(
      CurvedAnimation(
        curve: const Interval(0.35, 1.0, curve: Curves.bounceOut),
        parent: controller!,
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
        return Transform.translate(
          offset: Offset(
            0.0,
            (animationUp.value == (widget.from * -1))
                ? animationBounce.value
                : animationUp.value,
          ),
          child: widget.child,
        );
      },
    );
  }
}

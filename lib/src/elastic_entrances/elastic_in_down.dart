// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

///{@template elastic_in_down}
/// A elastic in down effect
///{@endtemplate}
class ElasticInDown extends StatefulWidget {
  ///{@macro elastic_in_down}
  ElasticInDown({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.from = 200,
    this.to = 100,
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

  /// [to]: from where you want to end the animation
  final double to;

  @override
  State<ElasticInDown> createState() => _ElasticInDownState();
}

/// StateClass, where the magic happens
class _ElasticInDownState extends State<ElasticInDown>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> bouncing;
  late Animation<double> falling;
  late Animation<double> opacity;
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

    opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller!, curve: const Interval(0, 0.45)),
    );

    falling =
        Tween<double>(begin: widget.from * -1, end: widget.to * -1).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0, 0.30),
      ),
    );

    bouncing = Tween<double>(begin: widget.to * -1, end: 0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.30, 1, curve: Curves.elasticOut),
      ),
    );

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
      animation: controller!,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(
            0,
            (falling.value == (widget.to * -1))
                ? bouncing.value
                : falling.value,
          ),
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

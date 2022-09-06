// ignore_for_file: use_super_parameters, prefer_int_literals

import 'package:flutter/material.dart';

///{@template zoom_in}
/// A pulse effect
///{@endtemplate}
class ZoomIn extends StatefulWidget {
  ///{@macro zoom_in}
  ZoomIn({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.from = 1.0,
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

  /// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
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
  State<ZoomIn> createState() => _ZoomInState();
}

/// State class, where the magic happens
class _ZoomInState extends State<ZoomIn> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> fade;
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
    fade = Tween(begin: 0.0, end: widget.from)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: controller!));

    opacity = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(parent: controller!, curve: const Interval(0, 0.65)),
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
      animation: fade,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scale: fade.value,
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

///{@template zoom_out}
/// A zoom out effect
///{@endtemplate}
class ZoomOut extends StatefulWidget {
  ///{@macro zoom_out}
  ZoomOut({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.from = 0.0,
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

  /// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
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
  State<ZoomOut> createState() => _ZoomOutState();
}

/// State class, where the magic happens
class _ZoomOutState extends State<ZoomOut> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> zoom;
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

    zoom = Tween(begin: 1.0, end: widget.from)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: controller!));

    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: controller!, curve: const Interval(0, 0.65)),
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
        return Transform.scale(
          scale: zoom.value,
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

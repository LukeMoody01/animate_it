// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

///{@template bounce_in_down}
/// A bounce in down effect
///{@endtemplate}
class BounceInDown extends StatefulWidget {
  ///{@macro bounce_in_down}
  BounceInDown({
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
  State<BounceInDown> createState() => _BounceInDownState();
}

/// Bounce class State, this is where the magic happens
class _BounceInDownState extends State<BounceInDown>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;
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
      CurvedAnimation(parent: controller!, curve: const Interval(0, 0.65)),
    );

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.bounceOut));

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
          offset: Offset(0, animation.value),
          child: Opacity(opacity: opacity.value, child: widget.child),
        );
      },
    );
  }
}

///{@template bounce_in_up}
/// A bounce in up effect
///{@endtemplate}
class BounceInUp extends StatelessWidget {
  ///{@macro bounce_in_up}
  BounceInUp({
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
  Widget build(BuildContext context) => BounceInDown(
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from * -1,
        child: child,
      );
}

///{@template bounce_in_left}
/// A bounce in left effect
///{@endtemplate}
class BounceInLeft extends StatefulWidget {
  ///{@macro bounce_in_left}
  BounceInLeft({
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
  State<BounceInLeft> createState() => _BounceInLeftState();
}

/// Bounce class State, this is where the magic happens
class _BounceInLeftState extends State<BounceInLeft>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;
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
      CurvedAnimation(parent: controller!, curve: const Interval(0, 0.65)),
    );

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.bounceOut));

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
          offset: Offset(animation.value, 0),
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

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

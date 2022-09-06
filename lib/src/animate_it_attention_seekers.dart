// ignore_for_file: use_super_parameters, prefer_int_literals

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

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

///{@template rubber_band}
/// A rubber band effect
///{@endtemplate}
class RubberBand extends StatefulWidget {
  ///{@macro rubber_band}
  const RubberBand({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
  }) : super(key: key);

  /// [child]: mandatory, widget to animate
  final Widget child;

  /// [duration]: how much time the animation should take
  final Duration duration;

  /// [delay]: delay before the animation starts
  final Duration delay;

  @override
  State<RubberBand> createState() => _RubberBandState();
}

/// State class, where the magic happens
class _RubberBandState extends State<RubberBand>
    with SingleTickerProviderStateMixin {
  bool disposed = false;
  late MovieTween matrix;
  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final durationMill = widget.duration.inMilliseconds;

    matrix = MovieTween();

    matrix
        .tween(
          'x',
          Tween(begin: 1.0, end: 1.25),
          duration: Duration(milliseconds: (durationMill * 0.3).round()),
        )
        .thenTween(
          'x',
          Tween(begin: 1.25, end: 0.75),
          duration: Duration(milliseconds: (durationMill * 0.1).round()),
        )
        .thenTween(
          'x',
          Tween(begin: 0.75, end: 1.15),
          duration: Duration(milliseconds: (durationMill * 0.1).round()),
        )
        .thenTween(
          'x',
          Tween(begin: 1.15, end: 0.95),
          duration: Duration(milliseconds: (durationMill * 0.15).round()),
        )
        .thenTween(
          'x',
          Tween(begin: 0.95, end: 1.05),
          duration: Duration(milliseconds: (durationMill * 0.1).round()),
        )
        .thenTween(
          'x',
          Tween(begin: 1.05, end: 1.0),
          duration: Duration(milliseconds: (durationMill * 0.25).round()),
        );

    matrix
        .tween(
          'y',
          Tween(begin: 1.0, end: 0.75),
          duration: Duration(milliseconds: (durationMill * 0.3).round()),
        )
        .thenTween(
          'y',
          Tween(begin: 0.75, end: 1.25),
          duration: Duration(milliseconds: (durationMill * 0.1).round()),
        )
        .thenTween(
          'y',
          Tween(begin: 1.25, end: 0.85),
          duration: Duration(milliseconds: (durationMill * 0.1).round()),
        )
        .thenTween(
          'y',
          Tween(begin: 0.85, end: 1.05),
          duration: Duration(milliseconds: (durationMill * 0.15).round()),
        )
        .thenTween(
          'y',
          Tween(begin: 1.05, end: 0.95),
          duration: Duration(milliseconds: (durationMill * 0.1).round()),
        )
        .thenTween(
          'y',
          Tween(begin: 0.95, end: 1.0),
          duration: Duration(milliseconds: (durationMill * 0.250).round()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder(
      tween: matrix,
      duration: widget.duration,
      delay: widget.delay,
      builder: (BuildContext context, Movie value, _) {
        return Transform(
          transform: Matrix4.identity()
            ..scale(value.get<double>('x'), value.get<double>('y')),
          alignment: Alignment.center,
          child: widget.child,
        );
      },
    );
  }
}

///{@template jello}
/// A jello effect
///{@endtemplate}
class Jello extends StatefulWidget {
  ///{@macro jello}
  const Jello({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
  }) : super(key: key);

  /// [child]: mandatory, widget to animate
  final Widget child;

  /// [duration]: how much time the animation should take
  final Duration duration;

  /// [delay]: delay before the animation starts
  final Duration delay;

  @override
  State<Jello> createState() => _JelloState();
}

/// State class, where the magic happens
class _JelloState extends State<Jello> with SingleTickerProviderStateMixin {
  bool disposed = false;
  late MovieTween matrix;
  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final durationMill = widget.duration.inMilliseconds;

    matrix = MovieTween();
    matrix
        .tween(
          'x',
          Tween(begin: 1.0, end: -12.5),
          duration: Duration(milliseconds: (durationMill * 0.22).round()),
        )
        .thenTween(
          'x',
          Tween(begin: -12.5, end: 6.25),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        )
        .thenTween(
          'x',
          Tween(begin: 6.25, end: -3.125),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        )
        .thenTween(
          'x',
          Tween(begin: -3.125, end: 1.5625),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        )
        .thenTween(
          'x',
          Tween(begin: 1.5625, end: -0.78125),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        )
        .thenTween(
          'x',
          Tween(begin: -0.78125, end: 0.390625),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        )
        .thenTween(
          'x',
          Tween(begin: 0.390625, end: -0.1953125),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        )
        .thenTween(
          'x',
          Tween(begin: -0.1953125, end: 0.0),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        );

    matrix
        .tween(
          'y',
          Tween(begin: 1.0, end: -12.5),
          duration: Duration(milliseconds: (durationMill * 0.22).round()),
        )
        .thenTween(
          'y',
          Tween(begin: -12.5, end: 6.25),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        )
        .thenTween(
          'y',
          Tween(begin: 6.25, end: -3.125),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        )
        .thenTween(
          'y',
          Tween(begin: -3.125, end: 1.5625),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        )
        .thenTween(
          'y',
          Tween(begin: 1.5625, end: -0.78125),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        )
        .thenTween(
          'y',
          Tween(begin: -0.78125, end: 0.390625),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        )
        .thenTween(
          'y',
          Tween(begin: 0.390625, end: -0.1953125),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        )
        .thenTween(
          'y',
          Tween(begin: -0.1953125, end: 0.0),
          duration: Duration(milliseconds: (durationMill * 0.11).round()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder(
      tween: matrix,
      duration: widget.duration,
      delay: widget.delay,
      builder: (BuildContext context, Movie value, _) {
        return Transform(
          transform: Matrix4.skew(
            value.get<double>('x') * math.pi / 180.0,
            value.get<double>('x') * math.pi / 180.0,
          ),
          alignment: Alignment.center,
          child: widget.child,
        );
      },
    );
  }
}

///{@template shake_x}
/// A shake effect on the x axis
///{@endtemplate}
class ShakeX extends StatefulWidget {
  ///{@macro shake_x}
  const ShakeX({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
  }) : super(key: key);

  /// [child]: mandatory, widget to animate
  final Widget child;

  /// [duration]: how much time the animation should take
  final Duration duration;

  /// [delay]: delay before the animation starts
  final Duration delay;

  @override
  State<ShakeX> createState() => _ShakeXState();
}

/// State class, where the magic happens
class _ShakeXState extends State<ShakeX> with SingleTickerProviderStateMixin {
  bool disposed = false;
  late MovieTween matrix;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final durationMill = widget.duration.inMilliseconds;

    matrix = MovieTween();

    matrix
        .tween(
          'x',
          Tween(begin: 0.0, end: -10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'x',
          Tween(begin: -10.0, end: 10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'x',
          Tween(begin: 10.0, end: -10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'x',
          Tween(begin: -10.0, end: 10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'x',
          Tween(begin: 10.0, end: -10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'x',
          Tween(begin: -10.0, end: 10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'x',
          Tween(begin: 10.0, end: -10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'x',
          Tween(begin: -10.0, end: 10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'x',
          Tween(begin: 10.0, end: -10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'x',
          Tween(begin: -10.0, end: 0.0),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder(
      tween: matrix,
      duration: widget.duration,
      delay: widget.delay,
      builder: (BuildContext context, Movie value, _) {
        return Transform.translate(
          offset: Offset(value.get<double>('x'), 0.0),
          child: widget.child,
        );
      },
    );
  }
}

///{@template shake_y}
/// A shake effect on the y axis
///{@endtemplate}
class ShakeY extends StatefulWidget {
  ///{@macro shake_y}
  const ShakeY({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
  }) : super(key: key);

  /// [child]: mandatory, widget to animate
  final Widget child;

  /// [duration]: how much time the animation should take
  final Duration duration;

  /// [delay]: delay before the animation starts
  final Duration delay;

  @override
  State<ShakeY> createState() => _ShakeYState();
}

/// State class, where the magic happens
class _ShakeYState extends State<ShakeY> with SingleTickerProviderStateMixin {
  bool disposed = false;
  late MovieTween matrix;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final durationMill = widget.duration.inMilliseconds;

    matrix = MovieTween();

    matrix
        .tween(
          'y',
          Tween(begin: 0.0, end: -10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'y',
          Tween(begin: -10.0, end: 10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'y',
          Tween(begin: 10.0, end: -10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'y',
          Tween(begin: -10.0, end: 10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'y',
          Tween(begin: 10.0, end: -10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'y',
          Tween(begin: -10.0, end: 10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'y',
          Tween(begin: 10.0, end: -10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'y',
          Tween(begin: -10.0, end: 10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'y',
          Tween(begin: 10.0, end: -10),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        )
        .thenTween(
          'y',
          Tween(begin: -10.0, end: 0.0),
          duration: Duration(milliseconds: (durationMill * 0.10).round()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder(
      tween: matrix,
      duration: widget.duration,
      delay: widget.delay,
      builder: (BuildContext context, Movie value, _) {
        return Transform.translate(
          offset: Offset(0.0, value.get<double>('y')),
          child: widget.child,
        );
      },
    );
  }
}

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

///{@template spin}
/// A spin effect
///{@endtemplate}
class Spin extends StatefulWidget {
  ///{@macro spin}
  Spin({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.infinite = false,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.spins = 1.0,
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

  /// [spins] number of spins that you want
  final double spins;

  @override
  State<Spin> createState() => _SpinState();
}

/// State class, where the magic happens
class _SpinState extends State<Spin> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> spin;

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

    spin = Tween<double>(begin: 0.0, end: widget.spins * 2)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeInOut));

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
        return Transform.rotate(
          angle: spin.value * 3.1415926535,
          child: widget.child,
        );
      },
    );
  }
}

///{@template spin_perfect}
/// A spin perfect effect
///{@endtemplate}
class SpinPerfect extends StatefulWidget {
  ///{@macro spin_perfect}
  SpinPerfect({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.infinite = false,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.spins = 1.0,
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

  /// [spins] number of spins that you want
  final double spins;

  @override
  State<SpinPerfect> createState() => _SpinPerfectState();
}

/// State class, where the magic happens
class _SpinPerfectState extends State<SpinPerfect>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> spin;

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

    spin = Tween<double>(begin: 0.0, end: widget.spins * 2)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.linear));

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
        return Transform.rotate(
          angle: spin.value * 3.141516,
          child: widget.child,
        );
      },
    );
  }
}

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

///{@template roulette}
/// A roulette effect
///{@endtemplate}
class Roulette extends StatefulWidget {
  ///{@macro roulette}
  Roulette({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 3500),
    this.delay = Duration.zero,
    this.infinite = false,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.spins = 2,
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

  /// [spins] number of spins that you want
  final double spins;

  @override
  State<Roulette> createState() => _RouletteState();
}

/// State class, where the magic happens
class _RouletteState extends State<Roulette>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> spin;

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

    spin = Tween<double>(begin: 0.0, end: widget.spins * 2).animate(
      CurvedAnimation(parent: controller!, curve: Curves.elasticOut),
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
        return Transform.rotate(
          angle: spin.value * 3.141516,
          child: widget.child,
        );
      },
    );
  }
}

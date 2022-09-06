// ignore_for_file: use_super_parameters, prefer_int_literals

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

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

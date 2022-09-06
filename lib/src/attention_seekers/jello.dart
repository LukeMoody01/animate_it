// ignore_for_file: use_super_parameters, prefer_int_literals

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

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
          Tween(begin: 0.0, end: -12.5),
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

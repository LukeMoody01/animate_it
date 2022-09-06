// ignore_for_file: use_super_parameters, prefer_int_literals

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

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

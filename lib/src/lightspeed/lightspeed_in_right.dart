// ignore_for_file: use_super_parameters, prefer_int_literals

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

///{@template light_speed_in_right}
/// A light speed in effect
///{@endtemplate}
class LightSpeedInRight extends StatefulWidget {
  ///{@macro light_speed_in_right}
  const LightSpeedInRight({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.from = 200,
  }) : super(key: key);

  /// [child]: mandatory, widget to animate
  final Widget child;

  /// [duration]: how much time the animation should take
  final Duration duration;

  /// [delay]: delay before the animation starts
  final Duration delay;

  /// [from]: from where you want to start the animation
  final double from;

  @override
  State<LightSpeedInRight> createState() => _LightSpeedInRightState();
}

class _LightSpeedInRightState extends State<LightSpeedInRight>
    with SingleTickerProviderStateMixin {
  late MovieTween _movie;

  @override
  void initState() {
    super.initState();
    final durationMill = widget.duration.inMilliseconds;
    _movie = MovieTween();
    _movie
        .tween(
          'skewX',
          Tween(begin: -30.0, end: 20.0),
          curve: Curves.easeOut,
          duration: Duration(milliseconds: (durationMill * 0.6).round()),
        )
        .thenTween(
          'skewX',
          Tween(begin: 20.0, end: -5.0),
          curve: Curves.easeOut,
          duration: Duration(milliseconds: (durationMill * 0.2).round()),
        )
        .thenTween(
          'skewX',
          Tween(begin: -5.0, end: 0.0),
          curve: Curves.easeOut,
          duration: Duration(milliseconds: (durationMill * 0.2).round()),
        );
    _movie
      ..tween(
        'opacity',
        Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeOut,
        duration: Duration(milliseconds: (durationMill * 0.6).round()),
      )
      ..tween(
        'translateX',
        Tween(begin: widget.from, end: 0.0),
        curve: Curves.easeOut,
        duration: Duration(milliseconds: (durationMill * 0.8).round()),
      );
  }

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder(
      tween: _movie,
      duration: widget.duration,
      delay: widget.delay,
      curve: Curves.easeOut,
      builder: (BuildContext context, Movie value, _) {
        return Transform(
          transform: Matrix4.skewX(value.get<double>('skewX') * math.pi / 180.0)
            ..translate(value.get<double>('translateX')),
          alignment: Alignment.center,
          child: Opacity(
            opacity: value.get<double>('opacity'),
            child: widget.child,
          ),
        );
      },
    );
  }
}

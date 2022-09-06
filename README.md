# animate_it

An animation package inspired by [animate_do](https://github.com/Klerith/animate_do_package) and [Animate.css](https://daneden.github.io/animate.css/).

Since the original animate_do does not seem to be maintained, I have decided to create this package that will add even more animations including complex animations using Matrix4.

# Available **Animations**

## FadeIn Animations

- FadeIn
- FadeInDown
- FadeInDownBig
- FadeInUp
- FadeInUpBig
- FadeInLeft
- FadeInLeftBig
- FadeInRight
- FadeInRightBig

## FadeOut Animations

- FadeOut
- FadeOutDown
- FadeOutDownBig
- FadeOutUp
- FadeOutUpBig
- FadeOutLeft
- FadeOutLeftBig
- FadeOutRight
- FadeOutRightBig

## BounceIn Animations

- BounceInDown
- BounceInUp
- BounceInLeft
- BounceInRight

## ElasticIn Animations

- ElasticIn
- ElasticInDown
- ElasticInUp
- ElasticInLeft
- ElasticInRight

## SlideIns Animations

- SlideInDown
- SlideInUp
- SlideInLeft
- SlideInRight

## FlipIn Animations

- FlipInX
- FlipInY

## Zooms

- ZoomIn
- ZoomOut

## SpecialIn Animations

- JelloIn

## Attention Seeker

- Bounce
- Flash
- RubberBand **NEW**
- ShakeX **NEW**
- ShakeY **NEW**
- Pulse
- Swing
- Spin
- SpinPerfect
- Dance
- Roulette

## Example

```
home: Scaffold(
    body: Center(

        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

            FadeInLeft(child: Text('Left') ),
            FadeInUp(child: Text('Up') ),
            FadeInDown(child: Text('Down') ),
            FadeInRight(child: Text('Right') ),

        ],
        ),

    ),
),

```

## TODO

There is a lot of things I want to do with this package

# animate_it

An animation package inspired by [animate_do](https://github.com/Klerith/animate_do_package) and [Animate.css](https://daneden.github.io/animate.css/).

Since the original animate_do is not being maintained, I have decided to create this package that will improve the current animations and add a LOT more animations including complex animations using Matrix4.

To see the road map, view the open [issues](https://github.com/LukeMoody01/animate_it/issues)

# Available **Animations**

## Attention Seeker

- Bounce
- Dance
- Flash
- Jello **NEW**
- Pulse
- Roulette
- RubberBand **NEW**
- ShakeX **NEW**
- ShakeY **NEW**
- Spin
- SpinPerfect
- Swing

## Bouncing Entrances

- BounceInDown
- BounceInLeft
- BounceInRight
- BounceInUp

## Elastic Entrances

- ElasticIn
- ElasticInDown
- ElasticInLeft
- ElasticInRight
- ElasticInUp

## Fading Entrances

- FadeIn
- FadeInDown
- FadeInDownBig
- FadeInLeft
- FadeInLeftBig
- FadeInRight
- FadeInRightBig
- FadeInUp
- FadeInUpBig

## Fading Exits

- FadeOut
- FadeOutDown
- FadeOutDownBig
- FadeOutLeft
- FadeOutLeftBig
- FadeOutRight
- FadeOutRightBig
- FadeOutUp
- FadeOutUpBig

## Flippers

- FlipInX
- FlipInY

## Lightspeed

- LightspeedInLeft
- LightspeedInRight

## Sliding Entrances

- SlideInDown
- SlideInLeft
- SlideInRight
- SlideInUp

## Specials

- JelloIn

## Zoom Entrances

- ZoomIn

## Zoom Exits

- ZoomOut

## More to come 💪

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

Please note, A lot of these animations need work to be a bit more snappy and smooth.
There is also a lot of things I want to do with this package and they will be put into issues in the GitHub repo.
If you have any suggestions, please feel free to raise a ticket and I will take a look into it.

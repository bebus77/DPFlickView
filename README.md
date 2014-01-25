# DPFlickView

A simple and easy to use subclass of UIView that lets you create a Tinder-like flick view.

## Usage

Import the header file where you want to use DPFlickView

```objc
#import <DPFLickView.h>
```

After initializing a new DPFlickView

```objc
DPFlickView *flickView = [[DPFlickView alloc] initWithFrame:CGRectMake(70, 150, 180, 180)];
flickView.backgroundColor = [UIColor blueColor];
[self.view addSubview flickView];
```

You can assign one action when the view is flicked to the right and to the left by passing a block.

```objc
flickView.leftAction = ^{ NSLog(@"LEFT ACTION");};
flickView.rightAction = ^{ NSLog(@"RIGHT ACTION");};
```

It's also possible to pass an `NSArray` to indicate which subviews should fade when flicking left and right.

```objc
flickView.leftFadingSubviews = @[mySubview, myOtherSubview];
flickView.rightFadingSubviews = @[statusLabel, avatarImage];
```

You can set a custom rotation angle in degrees by setting the `rotationAngle` property to an int, the default value is 10 degrees:

```objc
flickView.rotationAngle = 25;
```

The `alphaValue` property is `readonly` and allows you to combine the fading that's happening in the flick view together with events outside it.


## Installation

DPFlickView is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "DPFlickView"

## Author

David Harver Pollak, bebus77@gmail.com

## License

DPFlickView is available under the MIT license. See the LICENSE file for more info.


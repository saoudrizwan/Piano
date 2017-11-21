<p align="center">
    <img src="https://user-images.githubusercontent.com/7799382/30356431-dbba9920-97ed-11e7-8f2b-a5b5ba0e7682.png" alt="Piano" />
</p>

<p align="center">
    <img src="https://user-images.githubusercontent.com/7799382/30309920-bcdb85ec-9742-11e7-96fc-af8155f4712d.png" alt="Platform: iOS 10.0+" />
    <a href="https://developer.apple.com/swift" target="_blank"><img src="https://user-images.githubusercontent.com/7799382/30309908-ace5d886-9742-11e7-85ea-8d4e5f2af2ac.png" alt="Language: Swift 4" /></a>
    <a href="https://cocoapods.org/pods/Piano" target="_blank"><img src="https://user-images.githubusercontent.com/7799382/33073452-cd78293e-ce77-11e7-8b39-8a1565616814.png" alt="CocoaPods compatible" /></a>
    <a href="https://github.com/Carthage/Carthage" target="_blank"><img src="https://user-images.githubusercontent.com/7799382/30309900-9fc15d2e-9742-11e7-91fd-31bb1226db90.png" alt="Carthage compatible" /></a>
    <img src="https://user-images.githubusercontent.com/7799382/30309910-adef2b38-9742-11e7-8140-d05534dd92a5.png" alt="License: MIT" />
</p>

<p align="center">
    <a href="#installation">Installation</a>
  • <a href="#usage">Usage</a>
  • <a href="#documentation">Documentation</a>
  • <a href="#why-i-built-piano">Why I Built Piano</a>
  • <a href="#license">License</a>
  • <a href="#contribute">Contribute</a>
  • <a href="#questions">Questions?</a>
  • <a href="#credits">Credits</a>
</p>

Piano is a **convenient** and **easy-to-use** wrapper around the `AVFoundation` and `UIHapticFeedback` frameworks, leveraging the full capabilities of the **Taptic Engine**, while following strict Apple guidelines to **preserve battery life**. Ultimately, Piano allows you, the composer, to conduct masterful symphonies of sounds and vibrations, and create a more immersive, usable and meaningful user experience in your app or game.


## Compatibility

Piano requires **iOS 10+** and is compatible with **Swift 4** projects.

## Installation

* Installation for <a href="https://guides.cocoapods.org/using/using-cocoapods.html" target="_blank">CocoaPods</a>:

```ruby
platform :ios, '10.0'
target 'ProjectName' do
use_frameworks!

    pod 'Piano', '~> 1.5'

end
```
*(if you run into problems, `pod repo update` and try again)*

* Installation for <a href="https://github.com/Carthage/Carthage" target="_blank">Carthage</a>:

 ```ruby
 github "saoudrizwan/Piano"
 ```
 *(make sure Xcode 9 is [set as your system's default Xcode](https://stackoverflow.com/a/28901378/3502608) before using CocoaPods or Carthage with Swift 4 frameworks)*

* Or embed the Piano framework into your project

And `import Piano` in the files you'd like to use it.

## Usage

Using Piano is simple.
```swift
let symphony: [Piano.Note] = [
    .sound(.asset(name: "acapella")),
    .hapticFeedback(.impact(.light)),
    .waitUntilFinished,
    .hapticFeedback(.impact(.heavy)),
    .wait(0.2),
    .sound(.system(.chooChoo))
]

Piano.play(symphony)
```
... or better yet:
```swift
🎹.play([
    .sound(.asset(name: "acapella"))
    ])
```
Optionally add a completion block to be called when all the notes are finished playing:
```swift
🎹.play([
    .sound(.asset(name: "acapella"))
]) {
    // ...
}
```
Or cancel the currently playing symphony:
```swift
🎹.cancel()
```

In the background, each note has an internal completion block, so you can add a `.waitUntilFinished` note that tells Piano to not play the next note until the previous note is done playing. This is useful for creating patterns of custom haptic feedback, besides the ones Apple predefined. This is also great for creating complex combinations of sound effects and vibrations.

### Notes

#### `.sound(Audio)`
Plays an audio file.

|Audio | |
|------------ | ------------- |
|`.asset(name: String)` | Name of asset in any .xcassets catalogs. It's recommended to add your sound files to Asset Catalogs instead of as standalone files to your main bundle.|
|`.file(name: String, extension: String)` | Retrieves a file from the main bundle. For example a file named `Beep.wav` would be accessed with `.file(name: "Beep", extension: "wav")`.|
|`.url(URL)` | This only works for file URLs, not network URLs.|
|`.system(SystemSound)` | Predefined system sounds in every iPhone. [See all available options here](https://github.com/saoudrizwan/Piano/blob/master/Sources/SystemSound.swift). |

#### `.vibration(Vibration)`
Plays standard vibrations available on all models of the iPhone.

|Vibration | |
|------------ | -------------|
|`.default`  | Basic 1-second vibration |
|`.alert`  | Two short consecutive vibrations |

#### `.tapticEngine(TapticEngine)`
Plays Taptic Engine vibrations available on the iPhone 6S and above.

|TapticEngine | |
| ------------ | ------------- |
|`.peek` | One weak boom |
|`.pop` | One strong boom |
|`.cancelled` | Three sequential weak booms |
|`.tryAgain` | One weak boom then one strong boom |
|`.failed` | Three sequential strong booms |

#### `.hapticFeedback(HapticFeedback)`
Plays Taptic Engine Haptic Feedback available on the iPhone 7 and above.

|HapticFeedback | | |
|------------ | ------------- |------------- |
|`.notification(Notification)` | **Notification** | Communicate that a task or action has succeeded, failed, or produced a warning of some kind. |
| | `.success` | Indicates that a task or action has completed successfully. |
| | `.warning` | Indicates that a task or action has produced a warning. |
| | `.failure` | Indicates that a task or action has failed. |
|`.impact(Impact)`  | **Impact** | Indicates that an impact has occurred. For example, you might trigger impact feedback when a user interface object collides with something or snaps into place. |
| | `.light` | Provides a physical metaphor representing a collision between small, light user interface elements.|
| | `.medium` | Provides a physical metaphor representing a collision between moderately sized user interface elements.|
| | `.heavy` | Provides a physical metaphor representing a collision between large, heavy user interface elements.|
|`.selection` | | Indicates that the selection is actively changing. For example, the user feels light taps while scrolling a picker wheel.|

<sub>See: [Apple's Guidelines for using Haptic Feedback](https://developer.apple.com/ios/human-interface-guidelines/user-interaction/feedback/)</sub>

#### `.waitUntilFinished`
Tells Piano to wait until the previous note is done playing before playing the next note.

#### `.wait(TimeInterval)`
Tells Piano to wait a given duration before playing the next note.

### Device Capabilities

* The iPhone 6S and 6S Plus carry the first generation of Taptic Engine which has a few "haptic" vibration patterns, which you can play with Piano using the `.tapticEngine()` notes.

* The iPhone 7 and above carry the latest version of the Taptic Engine which supports the iOS 10 Haptic Feedback frameworks, allowing you to select from many more vibration types. You can play these vibrations using the `.hapticFeedback()` notes.

* All versions of the iPhone can play the `.vibration()` notes.

Piano also includes a useful extension for `UIDevice` to check if the user's device has a Taptic Engine and if it supports Haptic Feedback. This extension is especially useful for creating symphonies for all devices:
```swift
if UIDevice.current.hasHapticFeedback {
    // use .hapticFeedback(HapticFeedback) notes
} else if UIDevice.current.hasTapticEngine {
    // use .tapticEngine(TapticEngine) notes
} else {
    // use .vibration(Vibration) notes
}
```
**Note:** This extension does not work on simulators, it will always return false.

### Taptic Engine Guide

Apple's [guide over the Haptic Feedback framework](https://developer.apple.com/documentation/uikit/uifeedbackgenerator) is very clear about using the Taptic Engine appropriately in order to prevent draining the user's device's battery life. Piano was built with this in mind, and handles most cases as efficiently as possible. But you can help preserve battery life and reduce latency further by calling these helper methods based on your specific needs.

#### 1. Wake up the Taptic Engine
```swift
Piano.wakeTapticEngine()
```
This initializes and allocates the Haptic Feedback framework and essentially "wakes up" the Taptic Engine, as it is normally in an idle state. A good place to put this is at the begin state of a gesture or action, in anticipation of playing a `.hapticFeedback()` note.

#### 2. Prepare the Taptic Engine

```swift
Piano.prepareTapticEngine()
```
This tells the Taptic Engine to prepare itself before creating any feedback to reduce latency when triggering feedback.

From Apple's [documentation](https://developer.apple.com/documentation/uikit/uifeedbackgenerator):
> This is particularly important when trying to match feedback to sound or visual cues. To preserve power, the Taptic Engine stays in this prepared state for only a short period of time (on the order of seconds), or until you next trigger feedback. Think about when and where you can best prepare your generators. If you call prepare and then immediately trigger feedback, the system won’t have enough time to get the Taptic Engine into the prepared state, and you may not see a reduction in latency. On the other hand, if you call prepare too early, the Taptic Engine may become idle again before you trigger feedback.

tl;dr A good place to put this is right after calling `.wakeTapticEngine()`, usually at the beginning of a gesture or action, in anticipation of playing a `.hapticFeedback()` note.

#### 3. Put the Taptic Engine back to Sleep
```swift
Piano.putTapticEngineToSleep()
```
Once we know we're done using the Taptic Engine, we can deallocate the Haptic Feedback framework, returning the Taptic Engine to its idle state. A good place to put this is at the end of a finished, cancelled, or failed gesture or action.

#### But you don't have to.
Piano automatically wakes and prepares the Taptic Engine when you call `.play([ ... ])` if it includes a `.hapticFeedback()` note, and returns the Taptic Engine back to sleep when the notes are done playing.

### The Example App

The [example app](https://github.com/saoudrizwan/Piano/tree/master/Example) is a great place to get started. It's designed as a playground for you to compose and test out your own symphonies of sounds and vibrations.

<p align="center">
<img src="https://user-images.githubusercontent.com/7799382/30370416-613f985a-982c-11e7-8646-33f1efb55d90.png" alt="Piano" width="300" height="500" />
</p>

You can even drag and drop your own sound files into the project and tweak the code a bit to see how your own sounds can work alongside the Taptic Engine. To add your own sound file, simply drag it into `Sounds.xcassets`, name it accordingly, then edit the `cellData` property in `ViewController.swift` (Scroll down to `case 7` in `cellData`, or look for "Add your own sound assets here..." in the Jump Bar using `Ctrl + 6`).

## Documentation
Option + click on any of Piano's methods or notes for detailed documentation.
<img src="https://user-images.githubusercontent.com/7799382/30358465-97784ee0-97f9-11e7-9f12-75fa041cf556.png" alt="documentation">


## Why I Built Piano

With the new iPhone 8 and iPhone X, we are going to see many new Augmented Reality apps, and one of the keypoints in the [Human Interface Guidelines for AR](https://developer.apple.com/ios/human-interface-guidelines/technologies/augmented-reality/) is to not clutter the AR view, allowing as much content from the augmented reality to be displayed as possible. Besides AR, Apple has spent tremendous time and manpower giving the iPhone an interface beyond our vision with the Taptic Engine and Siri. Apple even had a [session during WWDC 2017](https://developer.apple.com/videos/play/wwdc2017/803/) talking about the importance of sound design and the impact it can have on a user experience. It's obvious that the future of technology is not visual interfaces, but augmenting our connection with the real world. By using our physical, auditory, and most importantly visual senses, we can see the world in a whole new light. That's why I built Piano and [ARLogger](https://github.com/saoudrizwan/ARLogger), frameworks I hope will help developers create immersive and uncluttered interfaces, while keeping the user aware of the technology's state and purpose. If you'd like my help on an AR project, or just want to chat about the future of technology, don't hesitate to reach out to me on Twitter [@sdrzn](http://twitter.com/sdrzn).

## License

Piano uses the MIT license. Please file an issue if you have any questions or if you'd like to share how you're using Piano.

## Contribute

Please feel free to create issues for feature requests or send pull requests of any additions you think would complement Piano and its philosophy.

## Questions?

Contact me by email <a href="mailto:hello@saoudmr.com">hello@saoudmr.com</a>, or by twitter <a href="https://twitter.com/sdrzn" target="_blank">@sdrzn</a>. Please create an <a href="https://github.com/saoudrizwan/Piano/issues">issue</a> if you come across a bug or would like a feature to be added.

## Credits

* Example app sound files from [Icons 8 UI Sounds](https://icons8.com/sounds)
* Music notes in README header image from [LSE Design on the Noun Project](https://thenounproject.com/LSEdesigns/collection/music-notes/)

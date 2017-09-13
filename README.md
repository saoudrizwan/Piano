<p align="center">
    <img src="https://user-images.githubusercontent.com/7799382/30356431-dbba9920-97ed-11e7-8f2b-a5b5ba0e7682.png" alt="Piano" />
</p>

<p align="center">
    <img src="https://user-images.githubusercontent.com/7799382/30309920-bcdb85ec-9742-11e7-96fc-af8155f4712d.png" alt="Platform: iOS 10.0+" />
    <a href="https://developer.apple.com/swift" target="_blank"><img src="https://user-images.githubusercontent.com/7799382/30309908-ace5d886-9742-11e7-85ea-8d4e5f2af2ac.png" alt="Language: Swift 4" /></a>
    <a href="https://cocoapods.org/pods/Piano" target="_blank"><img src="https://user-images.githubusercontent.com/7799382/30309877-7851e380-9742-11e7-8693-f2362eb3df50.png" alt="CocoaPods compatible" /></a>
    <a href="https://github.com/Carthage/Carthage" target="_blank"><img src="https://user-images.githubusercontent.com/7799382/30309900-9fc15d2e-9742-11e7-91fd-31bb1226db90.png" alt="Carthage compatible" /></a>
    <img src="https://user-images.githubusercontent.com/7799382/30309910-adef2b38-9742-11e7-8140-d05534dd92a5.png" alt="License: MIT" />
</p>

<p align="center">
    <a href="#installation">Installation</a>
  • <a href="#usage">Usage</a>
  • <a href="#license">License</a>
  • <a href="#contribute">Contribute</a>
  • <a href="#questions">Questions?</a>
  • <a href="#credits">Credits</a>
</p>

Piano is a **delightful** and **easy-to-use** wrapper around the `AVAudioServices` and `UIHapticFeedback` classes, leveraging the full capabilities of the **Taptic Engine**, while following strict Apple guidelines to **preserve battery life**. Ultimately, Piano allows you, the composer, to conduct masterful symphonies of sounds and vibrations, and create a more immersive, usable and meaningful user experience in your app or game.


## Compatibility

Piano requires **iOS 10+** and is compatible with **Swift 4** projects. Therefore you must use Xcode 9 when working with Piano.

## Installation

* Installation for <a href="https://guides.cocoapods.org/using/using-cocoapods.html" target="_blank">CocoaPods</a>:

```ruby
platform :ios, '10.0'
target 'ProjectName' do
use_frameworks!

    pod 'Piano', '~> 1.0.0'

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

Using Piano is simple. Here's an example:
```swift
Piano.play([
    .sound(.asset(name: "acapella")),
    .hapticFeedback(.impact(.light)),
    .waitUntilFinished,
    .hapticFeedback(.impact(.heavy)),
    .wait(0.2),
    .sound(.system(.chooChoo))
    ])
```

Piano allows you to play a series of [`Note`s](https://github.com/saoudrizwan/Piano/blob/master/Sources/Note.swift). In the background, each note has a completion block, so you can add a `.waitUntilFinished` note that doesn't play the next note until the currently playing note is done playing. This is useful for creating patterns of custom haptic feedback, besides the ones Apple predefined. This is also great for creating complex combinations of sound effects with haptic feedback.

### Notes
/// Audio file to play
case sound(Audio)

/// Standard vibrations available on all models of the iPhone
case vibration(Vibration)

/// First generation Taptic Engine vibrations
case tapticEngine(TapticEngine)

/// Second Generation Taptic Engine vibration options
case hapticFeedback(HapticFeedback)

/// Tells Piano to wait until the current note is done playing before playing the next note
case waitUntilFinished

/// Tells Piano to wait a given duration before playing the next note
case wait(TimeInterval)

.sound(Audio) | Audio file to play.
------------ | -------------
.asset(name: String) | Name of asset in any .xcassets catalogs. It's recommended to add your sound files to Asset Catalogs instead of as standalone files to your main bundle.
file(name: String, extension: String) | Retrieves a file from the main bundle. For example a file named `Beep.wav` would be accessed with `.file(name: "Beep", extension: "wav")`.
.url(URL) | **Note:** this only works for file URLs, not network URLs.
system(SystemSound) | Predefined system sounds in every iPhone. [See all available options here](https://github.com/saoudrizwan/Piano/blob/master/Sources/SystemSound.swift).


### Device Capabilities

The iPhone 6S and 6S Plus carry the first generation of Taptic Engine which have a few "haptic" vibration patterns, which you can play with Piano using the `.tapticEngine()` notes.

The iPhone 7 and above carry the latest version of the Taptic Engine which support the iOS 10 Haptic Feedback frameworks, allowing you to select from many more vibration types than previous versions. You can access these vibrations using the `.hapticFeedback()` note.

All versions of the iPhone can play the `.vibration()` note.

Included in Piano is a useful extension for UIDevice to check if the user's device has a Taptic Engine and if that version of the Taptic Engine supports Haptic Feedback. Here's an example of this extension:
```swift
if UIDevice.current.hasTapticHapticFeedback {
    Piano.play()
}
```

### Taptic Engine Guide

Apple's [guide over the Haptic Feedback framework](https://developer.apple.com/documentation/uikit/uifeedbackgenerator) is very clear about using the Taptic Engine appropriately in order to prevent draining the user's device's battery life. Piano was built with this in mind, and has several helper methods to ensure you follow these guidelines.

#### 1. Wake up the Taptic Engine.
```swift

```
This initializes and allocates the Haptic Feedback framework and essentially "wakes up" the Taptic Engine, as it is normally in an idle state.

### 2. Prepare the Taptic Engine

```swift

```
Even though we initialized the Haptic Feedback framework, we must still tell the Taptic Engine to prepare itself before creating any feedback.

Preparing the generator can reduce latency when triggering feedback. This is particularly important when trying to match feedback to sound or visual cues. Calling the generator’s prepare() method puts the Taptic Engine in a prepared state. To preserve power, the Taptic Engine stays in this state for only a short period of time (on the order of seconds), or until you next trigger feedback.
Think about when and where you can best prepare your generators. If you call prepare() and then immediately trigger feedback, the system won’t have enough time to get the Taptic Engine into the prepared state, and you may not see a reduction in latency. On the other hand, if you call prepare() too early, the Taptic Engine may become idle again before you trigger feedback.

tl;dr Call this method at the beginning of a gesture, in anticipation of playing a `.hapticFeedback()` note.

### 3. Put the Taptic Engine to Sleep
```swift

```
Once we know we're done using the Taptic Engine, we can optionally deallocate the Haptic Feedback framework, returning the Taptic Engine to its idle state.

### The Example App

The example app in the Example folder is a great place to get started. It's designed to be a playground for you to compose and test out your own symphonies of sounds and vibrations. You can even drag and drop your own sound files into the project and tweak the code a bit to see how your own sounds can work alongside the Taptic Engine.

## Why I Built Piano

With the new iPhone X, we are going to see many new Augmented Reality apps, and one of the keypoints in the iOS Human Guidelines for AR is to not clutter the AR view, allowing as much content from the world and augmented reality to be displayed as possible. Apple has spent tremendous time and manpower giving the iPhone an interface beyond our vision with the Taptic Engine and Siri. Apple even had a session during WWDC 2017 talking about the importance of sound design and the impact it can have on a user experience. It's obvious that the future of technology is not visual interfaces, but augmenting and advancing our connection with the world. By using our physical, auditory, and most importantly visual senses, we can see the world in a whole new light. That's why I built Piano and ARLogger, frameworks I hope will help developers create immersive and uncluttered interfaces, while keeping the user aware of the technology's state and purpose. If you'd like me to help work on an AR project, or just want to chat about the future of technology, don't hesitate to reach out to me on Twitter [@sdrzn](http://twitter.com/sdrzn).


###
Let's say we have a data model called `Message`...
```swift
struct Message: Codable {
let title: String
let body: String
}
```

## License

Disk uses the MIT license. Please file an issue if you have any questions or if you'd like to share how you're using Disk.

## Contribute

Please feel free to create issues for feature requests or send pull requests of any additions you think would complement Disk and its philosophy.

## Questions?

Contact me by email <a href="mailto:hello@saoudmr.com">hello@saoudmr.com</a>, or by twitter <a href="https://twitter.com/sdrzn" target="_blank">@sdrzn</a>. Please create an <a href="https://github.com/saoudrizwan/Disk/issues">issue</a> if you come across a bug or would like a feature to be added.

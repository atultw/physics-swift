//#-hidden-code
import PlaygroundSupport
import SwiftUI
import UIKit



//  `canvas.add(_: SKNode)` adds a node (like Ledge) to the scene,

//#-end-hidden-code

/*:
 # Learning Physics with SpriteKit
 Welcome! In this playground, we will leverage the awesome physics capabilities of Apple's SpriteKit library to learn basic concepts.
 ## How to Use
 This playground provides several abstractions to quickly create nodes
 `canvas.addLedge(width: Int, angle: Int, position: (Int, Int))` creates a ledge for our marble simulation
 
 You can configure all the `SKShapeNode` properties on `Ledge` as you would a regular node.
 
 ## Styles
 You can change the look and feel of our marble simulation at any time using the ``conf`` variable.
 
 ## Interacting
 To make this even more fun, you can drag and drop nodes once the scene is rendered (for example, if you want to tweak the positioning of a ledge)
 Click and hold then release to create a marble. The marble gets bigger the longer you press.
 */

//: Let's begin with the styling. Choose some colors you like!

//#-editable-code
// don't change the variable name.

/// The global configuration for the simulator.
let conf = Configuration (
    // the first three colors are for the scene background. You'll learn more about scenes in a moment.
    BackgroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
    BallColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),
    LedgeColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
)

//#-end-editable-code

//#-hidden-code

// set the scene text details and create canvas for customization

let uiconf = InterfaceConfiguration (
    MainText: "Press and Hold",
    SubText: "Then release to create a marble"
)

let canvas = InterfaceView(gameconfig: conf, uiconfig: uiconf)
//#-end-hidden-code

//: Now onto the building part. Add some ledges to your marble run!

//#-editable-code

// Hint: Copy paste these lines and fiddle with the values to get a desired result
canvas.addLedge(width: 200, angle: 10, position: (100, 200))
canvas.addLedge(width: 200, angle: -10, position: (-100, 50))
canvas.addLedge(width: 200, angle: 10, position: (100, -100))

// end editing

let wrapper = UIHostingController(rootView: canvas)
PlaygroundPage.current.liveView = wrapper

//#-end-editable-code

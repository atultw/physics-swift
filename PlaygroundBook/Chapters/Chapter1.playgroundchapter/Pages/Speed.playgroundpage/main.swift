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

let conf = Configuration (
    // the first three colors are for the scene background. You'll learn more about scenes in a moment.
    BackgroundColor: #colorLiteral(red: 0.0, green: 0.1818548739, blue: 0.4802125096, alpha: 1.0),
    BallColor: #colorLiteral(red: -0.3861495554447174, green: 0.7804208397865295, blue: -0.2296208143234253, alpha: 1.0),
    LedgeColor: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
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

//canvas.addLedge(width: 200, angle: 10, position: (100, 200))
//canvas.addLedge(width: 200, angle: -10, position: (-100, 50))
//canvas.addLedge(width: 200, angle: 10, position: (100, -100))

// end editing

MainViewShared = canvas
let wrapper = UIHostingController(rootView: MainViewShared)
PlaygroundPage.current.liveView = wrapper

//#-end-editable-code

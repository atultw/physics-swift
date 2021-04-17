//#-hidden-code
import PlaygroundSupport
import SwiftUI
import UIKit
import SpriteKit
//#-end-hidden-code

/*:
 # Learning Physics with SpriteKit
 
 Welcome! Here's a quick overview:
 
 ## Format
 This playground is a sort of lab. Use code to configure, evaluate results on the right side, and understand how physics and the `SKPhysicsBody` work. Summaries with key points and real SK code examples are presented after each experiment.
 
 ## Programming
 This playground provides several abstractions on top of SK.
 - `canvas.addLedge(width: Int, angle: Int, position: (Int, Int))` creates a ledge
 - `canvas.add(_: SKNode)` adds a custom node (more on last page)
 
 ## Configuring
 The `conf` variable is for styling and configuring physics. Its fields are:
 - `BackgroundColor`: UIColor
 - `BallColor`: UIColor
 - `LedgeColor`: UIColor
 - `DefaultBallRadius`: Int
 - `Gravity`: Bool
 - `Friction`: Float (0 to 1)
 - `Dynamic`: Bool

 ## Interacting
 Here's what you can do on the right side:
 - Drag Ledges
 - Click and hold to create marbles
 - Track duration of marble runs (under where a marble landed)
 - Use a consistent start point (white circle)
 */

//: Let's begin with the styling. Choose some colors you like!
let conf = Configuration (
    BackgroundColor: /*#-editable-code*/#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) /*#-end-editable-code*/,
    BallColor: /*#-editable-code*/#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1) /*#-end-editable-code*/,
    LedgeColor: /*#-editable-code*/#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) /*#-end-editable-code*/
)

//#-hidden-code
let uiconf = InterfaceConfiguration (
    MainText: "Press and Hold",
    SubText: "Then release to create a marble"
)
let canvas = InterfaceView(gameconfig: conf, uiconfig: uiconf)
//#-end-hidden-code

//: Now onto the building part. Add some ledges to your marble run!
// Hint: Duplicate these lines to make more ledges. Remember you can move them on the right!
//#-editable-code
canvas.addLedge(width: 200, angle: 10, position: (150, 200))
canvas.addLedge(width: 200, angle: -10, position: (-100, 50))
canvas.addLedge(width: 200, angle: 10, position: (100, -100))
//#-end-editable-code

//#-hidden-code
let wrapper = UIHostingController(rootView: canvas)
PlaygroundPage.current.liveView = wrapper
//#-end-hidden-code

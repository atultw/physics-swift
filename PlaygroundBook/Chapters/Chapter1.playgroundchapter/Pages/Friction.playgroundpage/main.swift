//#-hidden-code
import PlaygroundSupport
import SwiftUI
import UIKit
import SpriteKit


//#-end-hidden-code

/*:
 # Friction
 ### Friction is the resistance that one surface or object encounters when moving over another.
 
 In the configuration below, edit the friction value to anything between 0 and 1. Observe how this affects the time it takes for a marble to reach the bottom.
 #### What's the relationship between friction and speed?
 */

let conf = Configuration (
    Friction: /*#-editable-code*/0.0 /*#-end-editable-code*/, // Hint: Try 0 and 1
    DefaultBallRadius: /*#-editable-code*/20 /*#-end-editable-code*/
)

//#-hidden-code
// set the scene text details and create canvas for customization
let uiconf = InterfaceConfiguration (
    MainText: "Press and Hold",
    SubText: "Then release to create a marble"
)
let canvas = InterfaceView(gameconfig: conf, uiconfig: uiconf)
//#-end-hidden-code

//: For this section, you can copy paste your code from the previous page.
//#-editable-code
canvas.addLedge(width: 200, angle: 10, position: (150, 200))
canvas.addLedge(width: 200, angle: -10, position: (-100, 50))
canvas.addLedge(width: 200, angle: 10, position: (100, -100))
//#-end-editable-code

//#-hidden-code
let wrapper = UIHostingController(rootView: canvas)
PlaygroundPage.current.liveView = wrapper
//#-end-hidden-code


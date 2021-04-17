//#-hidden-code
import PlaygroundSupport
import SwiftUI
import UIKit
import SpriteKit


//#-end-hidden-code

/*:
 # Friction
 ### Friction is resistance to movement.
 
 In the configuration below, edit the friction value to anything between 0 and 1. Observe the marble run durations.
 #### What's the relationship between friction and speed?
 */

let conf = Configuration (
    Friction: /*#-editable-code*/0.0 /*#-end-editable-code*/, // Hint: Try 0 and 1
    DefaultBallRadius: /*#-editable-code*/20 /*#-end-editable-code*/
)

//#-hidden-code
let uiconf = InterfaceConfiguration (
    MainText: "Press and Hold",
    SubText: "Then release to create a marble"
)
let canvas = InterfaceView(gameconfig: conf, uiconfig: uiconf)
//#-end-hidden-code

//: You can paste your code from the previous experiment.
//#-editable-code
canvas.addLedge(width: 200, angle: 10, position: (150, 200))
canvas.addLedge(width: 200, angle: -10, position: (-100, 50))
canvas.addLedge(width: 200, angle: 10, position: (100, -100))
//#-end-editable-code

//#-hidden-code
let wrapper = UIHostingController(rootView: canvas)
PlaygroundPage.current.liveView = wrapper
//#-end-hidden-code

//: After running, use the arrows above to continue

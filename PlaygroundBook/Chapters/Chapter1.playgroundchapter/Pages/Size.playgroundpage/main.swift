//#-hidden-code
import PlaygroundSupport
import SwiftUI
import UIKit
import SpriteKit
//#-end-hidden-code

/*:
 # Size (Volume)
 ### In physics, volume is the amount of space an object takes up. SpriteKit refers to this as size when dealing with SKShapeNodes.
 
 #### Create marbles of different sizes. How does the movement differ?
 */

let conf = Configuration (
    DefaultBallRadius: /*#-editable-code*/20 /*#-end-editable-code*/
)

//#-hidden-code
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

//: After running, use the arrows above to continue

//#-hidden-code
let wrapper = UIHostingController(rootView: canvas)
PlaygroundPage.current.liveView = wrapper
//#-end-hidden-code


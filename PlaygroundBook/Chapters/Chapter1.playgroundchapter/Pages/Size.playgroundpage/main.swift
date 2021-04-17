//#-hidden-code
import PlaygroundSupport
import SwiftUI
import UIKit
import SpriteKit


//#-end-hidden-code

/*:
 # Size (Volume)
 ### In physics, volume is the amount of space an object takes up. SpriteKit refers to this as size when dealing with SKShapeNodes.
 
 For this, just copy paste the ledges from before and run. Create marbles of different sizes. How does the movement differ?
 */

//#-editable-code
// don't change the variable name.

let conf = Configuration (
    // You don't have to set anything here. You can change colors if you'd like!
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


//#-hidden-code
import PlaygroundSupport
import SwiftUI
import UIKit
import SpriteKit
//#-end-hidden-code

/*:
 # Learning Physics with SpriteKit
  
 ## Format
 This playground is built on **4** experiments. Use code to configure and evaluate results in LiveView. Users learn basic physics concepts and their application in `SpriteKit`.
 
 ## Programming
 There several abstractions including:
 - `canvas.addLedge(width: Int, angle: Int, position: (Int, Int))` creates a ledge
 - `canvas.add(_: SKNode)` adds a custom node (more on last page)

 ## Interacting
 Here's what you can do on the right side:
 - Drag Ledges
 - Click and hold to create marbles
 - Track duration of marble runs
 - Use a consistent start point (white circle)
 */

//#-hidden-code
let conf = Configuration (
    BackgroundColor: #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1),
    BallColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
    LedgeColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
)
let uiconf = InterfaceConfiguration (
    MainText: "Press and Hold",
    SubText: "Then release to create a marble"
)
let canvas = InterfaceView(gameconfig: conf, uiconfig: uiconf)
//#-end-hidden-code

//: Let's start making some ledges. **Press "Run My Code"** for the defaults or add more.
//#-editable-code
// each line adds a ledge
canvas.addLedge(width: 200, angle: 10, position: (150, 200))
canvas.addLedge(width: 200, angle: -10, position: (-100, 50))
canvas.addLedge(width: 200, angle: 10, position: (100, -100))
//#-end-editable-code

//: Copy the code to clipboard. After running, use the arrows above to continue

//#-hidden-code
let wrapper = UIHostingController(rootView: canvas)
PlaygroundPage.current.liveView = wrapper
//#-end-hidden-code


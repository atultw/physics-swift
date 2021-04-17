//#-hidden-code
import PlaygroundSupport
import SwiftUI
import UIKit
import SpriteKit
//#-end-hidden-code

/*:
 # Normal and Applied Force
 ### In physics, normal force is what keeps objects on a surface even as gravity pulls them in. Applied force is force exerted on an object from another object.
 #### What forces are being exerted on the ball? Can we move it?
 */

let conf = Configuration (
    // Change this to false the second time.
    Dynamic: /*#-editable-code*/true /*#-end-editable-code*/
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

//#-hidden-code
let wrapper = UIHostingController(rootView: canvas)
PlaygroundPage.current.liveView = wrapper
//#-end-hidden-code


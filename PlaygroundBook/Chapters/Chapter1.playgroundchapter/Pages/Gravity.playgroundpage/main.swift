//#-code-completion(everything, hide)
//#-code-completion(literal, show, boolean, color, integer)
//#-code-completion(currentmodule, show)
//#-code-completion(identifier, show, canvas.addLedge())
//#-code-completion(identifier, show, addLedge())

//#-hidden-code
import PlaygroundSupport
import SwiftUI
import UIKit
import SpriteKit
//#-end-hidden-code

/*:
 # Gravity
 ### In physics, gravity is the force that keeps the universe together. Let's see how we can use it in spritekit
 #### Try to move the marble. What's the difference?
 */

let conf = Configuration (
    Gravity: /*#-editable-code*/true /*#-end-editable-code*/ // try true and false
)

//#-hidden-code
// set the scene text details and create canvas for customization
let uiconf = InterfaceConfiguration (
    MainText: "Gravity",
    SubText: "Hint: drop more marbles"
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

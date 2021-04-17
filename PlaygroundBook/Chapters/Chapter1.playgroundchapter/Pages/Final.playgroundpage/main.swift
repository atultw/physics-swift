//#-code-completion(everything, hide)
//#-code-completion(SpriteKit, show)
//#-code-completion(bookauxiliarymodule, show)
//#-code-completion(literal, show, array, boolean, color, dictionary, image, integer, nil, string, tuple)
//#-code-completion(currentmodule, show)

//#-hidden-code
import PlaygroundSupport
import SwiftUI
import UIKit
import SpriteKit
//#-end-hidden-code

/*:
 # Woohoo! All Done!
 ### Let's review these concepts with a simple but very customizable project.
 
 #### On this page, create a marble run using any configuration elements you want.
 You can also make your own `SKNode`s and add them to the scene using `canvas.add(node: SKNode)`.
 */

//#-editable-code
let conf = Configuration (
    BackgroundColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
    BallColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
    LedgeColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
    Friction: 0.2,
    DefaultBallRadius: 20,
    Gravity: true,
    Dynamic: true
)
//#-end-editable-code

//#-hidden-code
// set the scene text details and create canvas for customization
let uiconf = InterfaceConfiguration (
    MainText: "Your Turn!",
    SubText: "Create your very own marble run"
)
let canvas = InterfaceView(gameconfig: conf, uiconfig: uiconf)
//#-end-hidden-code

//: Add some nodes!
//#-editable-code
canvas.addLedge(width: 200, angle: 10, position: (150, 200))
canvas.addLedge(width: 200, angle: -10, position: (-100, 50))
canvas.addLedge(width: 200, angle: 10, position: (100, -100))

// Example of creating a rectangle:
let aNode = SKShapeNode(rectOf: CGSize(width: 50, height: 10)) // Initialize rectangle
aNode.position = CGPoint(x: 100, y: 100) // Set position
canvas.add(aNode) // Add to scene

// Adding physics body to aNode
aNode.physicsBody = SKPhysicsBody(rectangleOf: aNode.frame.size)
// Look back at the custscenes to see how you can customize an SKPhysicsNode!
aNode.physicsBody?.affectedByGravity = true
aNode.physicsBody?.restitution = CGFloat(0) // another neat property; for bounciness

//#-end-editable-code

//#-hidden-code
let wrapper = UIHostingController(rootView: canvas)
PlaygroundPage.current.liveView = wrapper
//#-end-hidden-code


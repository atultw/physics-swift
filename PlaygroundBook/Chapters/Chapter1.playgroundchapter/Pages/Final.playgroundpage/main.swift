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
 
 #### Configuring
 The `conf` variable is for styling and configuring physics. Its fields are:
 - `BackgroundColor`: UIColor
 - `BallColor`: UIColor
 - `LedgeColor`: UIColor
 - `DefaultBallRadius`: Int
 - `Gravity`: Bool
 - `Friction`: Float (0 to 1)
 - `Dynamic`: Bool
 */

//#-editable-code
let conf = Configuration (
    BackgroundColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
    BallColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
    LedgeColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),
    Friction: 0.2,
    // for the default ball:
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
let aNode = SKShapeNode(rectOf: CGSize(width: 10, height: 80))
aNode.position = CGPoint(x: 100, y: 100)
aNode.fillColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
// Look back at the custscenes to see how you can customize an SKPhysicsNode
aNode.physicsBody = SKPhysicsBody(rectangleOf: aNode.frame.size)
aNode.physicsBody?.affectedByGravity = false
aNode.physicsBody?.restitution = CGFloat(0) // bounciness
canvas.add(aNode)

let sun = SKShapeNode(circleOfRadius: 60)
sun.fillColor = #colorLiteral(red: 0.9626445174, green: 0.9242319465, blue: 0.0, alpha: 1.0)
sun.strokeColor = #colorLiteral(red: 1.0, green: 0.52406919, blue: 0.2793792188, alpha: 1.0)
sun.glowWidth = 2
sun.position = CGPoint(x: -150, y: 250)
canvas.add(sun)
//#-end-editable-code

//#-hidden-code
let wrapper = UIHostingController(rootView: canvas)
PlaygroundPage.current.liveView = wrapper
//#-end-hidden-code

//: After running, use the arrows above to continue

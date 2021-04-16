
import SpriteKit
import SwiftUI

public class Ledge: SKShapeNode {
    public convenience init(width: CGFloat, angle: Int, position: (Int, Int), color: UIColor) {
        
        let entitySize = CGSize(width: width, height: 10.0)
        self.init(rectOf: entitySize, cornerRadius: 2)
        
        // Styles
        self.fillColor = color
        
        // Swift has handy angle tools!
        self.zRotation = CGFloat(Angle(degrees: Double(angle)).radians)
        
        self.position = CGPoint(x: position.0, y: position.1)
        
        // handle physics
        self.physicsBody = SKPhysicsBody(rectangleOf: entitySize)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
    }
    
}

/// Masks used for collision detection
struct Masks {
    static let Floor: UInt32 = 0
    static let Ball: UInt32 = 1
}

/// Wrapper for `SKShapeNode` circle and `SKLabelNode` text to represent a marble.
public class Ball: SKNode {
    public var labelNode: SKLabelNode
    public var circleNode: SKShapeNode
    public var timeCreated: Date
    public var timeReachedBottom: Date?
    
    init(radius: Int, pos: CGPoint, ballColor: UIColor) {
        
        self.timeCreated = Date()
        self.labelNode = SKLabelNode(text: String(""))
        self.circleNode = SKShapeNode(circleOfRadius: CGFloat(radius))
        self.circleNode.name = "ballChild"
        
        self.circleNode.fillColor = ballColor
        self.labelNode.fontSize = 18
        self.labelNode.name = "ballChild"
        self.labelNode.fontName = "San Francisco Bold"
        super.init()
        physicsBody?.mass = CGFloat(radius)
        physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(radius))
        //                          circ.physicsBody?.mass = CGFloat(circ.physicsBody!.mass*2000)
        //        physicsBody?.velocity = CGVector(dx:0, dy:100)
        position = pos
        
        addChild(self.circleNode)
        // label that will display time taken to fall
        addChild(self.labelNode)
        
        self.physicsBody?.categoryBitMask = Masks.Ball
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// Appearance configuration (global)
public struct Configuration {
    
    public var BackgroundColor: UIColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    public var BallColor: UIColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    public var LedgeColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    
    public init(BackgroundColor: UIColor, BallColor: UIColor, LedgeColor: UIColor) {
        self.BackgroundColor = BackgroundColor
        self.BallColor = BallColor
        self.LedgeColor = LedgeColor
    }
    
    public init() {
    }
}

/// Configuration that is page-specific so the SwiftUI `Text` can show the correct thing.
public struct InterfaceConfiguration {
    public var MainText: String = "Preview"
    public var SubText: String = "Description"
    
    public init(MainText: String, SubText: String) {
        self.MainText = MainText
        self.SubText = SubText
    }
    
    public init() {
    }
}

let FlashInOut: SKAction = SKAction.sequence([.fadeIn(withDuration: 2.0),
                                              .fadeOut(withDuration: 2.0)])

let BounceIn: SKAction = SKAction.sequence([.scale(by: 1.1, duration: 0.5),
                                            .scale(by: 0.5, duration: 1.0)])

/// scene with the items on screen
public class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var configCopy: Configuration = Configuration.init()
    var draggingElement: [UITouch:SKNode] = [:] // Used to handle dragging and dropping
    var timeLabel: SKLabelNode?
    
    public convenience init(conf: Configuration, size: CGSize) {
        self.init(size: size)
        configCopy = conf
    }
    
    var clickTracker = [UITouch : (TimeInterval, TimeInterval)]()
    // key: Consistent across touchesBegan and touchesEnded
    // value: (touch down , touch up)  <== subtract to get duration of touch
    
    
    public override func didMove(to view: SKView) {
        // ball time indicator
        self.timeLabel = SKLabelNode(text: "")
        self.timeLabel?.fontSize = 32
        self.timeLabel?.fontName = "San Francisco Bold"
        self.timeLabel?.position = CGPoint(x: 100,y: (self.size.height)/2-100)
        self.addChild(self.timeLabel!)
        
        self.backgroundColor = self.configCopy.BackgroundColor
        
        self.view?.showsNodeCount = true
        // IMPORTANT
        self.physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        // the floor
        let floor = SKShapeNode(rectOf: CGSize(width: self.size.width, height: 10))
        floor.position = CGPoint(x: 0,y: -self.size.width/2)
        floor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: 10))
        floor.physicsBody?.isDynamic=false
        floor.physicsBody?.affectedByGravity=false
        floor.physicsBody?.contactTestBitMask = Masks.Ball
        self.addChild(floor)
        
        
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node is Ball {
            let ballNode = (contact.bodyA.node as! Ball)
            // if this is the first time it's fallen (we don't want to update on bounce)
            if (ballNode.timeReachedBottom == nil) {
                ballNode.timeReachedBottom = Date()
                let labelText = String(format:"%.2f", ballNode.timeReachedBottom!.timeIntervalSince(ballNode.timeCreated))
                ballNode.labelNode.text = labelText
                self.timeLabel?.text = labelText
                self.timeLabel?.position = CGPoint(x: ballNode.position.x, y: -self.size.height/2+100)
            }
        }
        
        if contact.bodyB.node is Ball {
            let ballNode = (contact.bodyB.node as! Ball)
            // if this is the first time it's fallen (we don't want to update on bounce)
            if (ballNode.timeReachedBottom == nil) {
                ballNode.timeReachedBottom = Date()
                let labelText = String(format:"%.2f", ballNode.timeReachedBottom!.timeIntervalSince(ballNode.timeCreated))
                ballNode.labelNode.text = labelText
                self.timeLabel?.text = labelText
                self.timeLabel?.position = CGPoint(x: ballNode.position.x, y: -self.size.height/2+60)
            }
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // draggability
        
        // we use this to see later if the click was on a node or somewhere else.
        var pressedOnElement: Bool = false
        
        // reset the touch list
        self.draggingElement = [:]
        for touch in touches {
            
            let location = touch.location(in: self)
            
            
            // if a node is pressed AND it's not a child of ball
            if (atPoint(location) != self && atPoint(location).name != "ballChild") {
                self.draggingElement[touch] = atPoint(location)
                pressedOnElement = true
                
                // toggle gravity during movement
                atPoint(location).physicsBody?.affectedByGravity.toggle()
            }
            
        }
        
        // if it's on a node we don't need to create a ball - terminate here
        if (pressedOnElement) {
            return
        }
        
        // if it ISN'T on a node, we should create a ball
        for touch: UITouch in touches {
            clickTracker.updateValue((touch.timestamp, touch.timestamp), forKey: touch)
        }
        
        
        
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // we use this to see later if the click was on a node or somewhere else.
        var pressedOnElement: Bool = false
        
        // draggability
        for touch in touches {
            
            if (draggingElement[touch] != nil) {
                // if this was in the dragged nodes list
                pressedOnElement = true
            }
            
            draggingElement[touch]?.position = touch.location(in: self)
        }
        
        // we don't need to create a ball if this was a drag movement.
        if (pressedOnElement) {
            return
        }
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // we use this to see later if the click was on a node or somewhere else.
        var pressedOnElement: Bool = false
        
        // draggability
        for touch in touches {
            
            if (draggingElement[touch] != nil) {
                // if this was in the dragged nodes list
                pressedOnElement = true
                
                // toggle gravity back to original
                //  another handy feature of swift - boolean.toggle
                draggingElement[touch]?.physicsBody?.affectedByGravity.toggle()
            }
            
            // notice how we don't move any nodes. That should not be done in this event.
        }
        
        // we don't need to create a ball if this was a drag movement.
        if (pressedOnElement) {
            return
        }
        
        for touch: UITouch in touches {
            clickTracker.updateValue((clickTracker[touch]!.0, touch.timestamp), forKey: touch)
            let radius = clickTracker[touch]!.1-clickTracker[touch]!.0
            print(radius)
            
            let circ = Ball(radius: Int(radius*200), pos: touch.location(in: self), ballColor: self.configCopy.BallColor)
            self.addChild(circ)
        }
    }
    
}

// For presentation

/// The view that includes spritekit scene and swiftUI elements
public struct InterfaceView: View {
    
    var gameconfig: Configuration
    var uiconfig: InterfaceConfiguration
    public var gscene: GameScene!
    
    public init(gameconfig: Configuration, uiconfig: InterfaceConfiguration) {
        self.gameconfig = gameconfig
        self.uiconfig = uiconfig
        self.gscene = GameScene(conf:self.gameconfig, size: CGSize(width: 600, height: 800))
        self.gscene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.gscene.scaleMode = .fill
    }
    
    /// Add something to the canvas
    public func addLedge(width: CGFloat, angle: Int, position: (Int, Int)) {
        self.gscene.addChild(Ledge(width: width, angle: angle, position: position, color: self.gameconfig.LedgeColor))
    }
    
    public var body: some View {
        VStack {
            Text(uiconfig.MainText)
                .font(.title)
            
            Text(uiconfig.SubText)
                .font(.subheadline)
            
            SpriteView(scene: gscene)
                .frame(width: 600, height: 800)
                .edgesIgnoringSafeArea(.all)
        }
        
    }
    
}


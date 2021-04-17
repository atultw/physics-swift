// By Atulya Weise
// This file includes the backend of the game with API and some structs, classes.
import SpriteKit
import SwiftUI


let FlashInOut: SKAction = SKAction.sequence([.fadeIn(withDuration: 2.0),
                                              .fadeOut(withDuration: 2.0)])

let BounceIn: SKAction = SKAction.sequence([.scale(by: 1.1, duration: 0.5),
                                            .scale(by: 0.5, duration: 1.0)])


/// Masks used for collision detection
struct Masks {
    static let Floor: UInt32 = 0
    static let Ball: UInt32 = 1
}

/// Appearance and physics configuration
public struct Configuration {
    
    public var BackgroundColor: UIColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    public var BallColor: UIColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    public var LedgeColor: UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    public var Friction: CGFloat = 0.2
    public var DefaultBallRadius: Int = 20
    public var Gravity: Bool = true
    public var Dynamic: Bool = true
    
    public init(BackgroundColor: UIColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
                BallColor: UIColor =  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
                LedgeColor: UIColor =  #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),
                Friction: CGFloat = 0.2,
                DefaultBallRadius: Int = 20,
                Gravity: Bool = true,
                Dynamic: Bool = true) {
        self.BackgroundColor = BackgroundColor
        self.BallColor = BallColor
        self.LedgeColor = LedgeColor
        self.Friction = Friction
        self.DefaultBallRadius = DefaultBallRadius
        self.Gravity = Gravity
        self.Dynamic = Dynamic
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

public class Ledge: SKShapeNode {
    public convenience init(width: CGFloat, angle: Int, position: (Int, Int), color: UIColor, fric: Float) {
        
        let entitySize = CGSize(width: width, height: 20)
        self.init(rectOf: entitySize, cornerRadius: 2)
        
        // Styles
        self.fillColor = color
        
        // Swift has handy angle tools!
        self.zRotation = CGFloat(Angle(degrees: Double(angle)).radians)
        self.position = CGPoint(x: position.0, y: position.1)
        self.name = "ledge"
        
        // handle physics
        self.physicsBody = SKPhysicsBody(rectangleOf: entitySize)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.friction = CGFloat(fric)
    }
    
}

/// Wrapper for `SKShapeNode` circle and `SKLabelNode` text to represent a marble.
public class Ball: SKNode {
    public var labelNode: SKLabelNode
    public var circleNode: SKShapeNode
    public var timeCreated: Date
    public var timeReachedBottom: Date?
    
    init(radius: Int,
         pos: CGPoint,
         ballColor: UIColor,
         fric: CGFloat,
         gravity: Bool,
         dynamic: Bool) {
        
        self.timeCreated = Date()
        self.labelNode = SKLabelNode(text: String(""))
        self.circleNode = SKShapeNode(circleOfRadius: CGFloat(radius))
        self.circleNode.name = "ballChild"
        
        self.circleNode.fillColor = ballColor
        self.labelNode.fontSize = 18
        self.labelNode.name = "ballChild"
        self.labelNode.fontName = "San Francisco Bold"
        super.init()
        physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(radius))
        physicsBody?.friction = fric
        physicsBody?.affectedByGravity = gravity
        physicsBody?.isDynamic = dynamic
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

/// The view that includes SpriteKit scene and SwiftUI elements
public struct InterfaceView: View {
    
    var gameconfig: Configuration
    var uiconfig: InterfaceConfiguration
    public var gameSkScene: GameScene!
    
    public init(gameconfig: Configuration, uiconfig: InterfaceConfiguration) {
        self.gameconfig = gameconfig
        self.uiconfig = uiconfig
        self.gameSkScene = GameScene(conf:self.gameconfig, size: CGSize(width: 600, height: 800))
        self.gameSkScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.gameSkScene.scaleMode = .fill
    }
    
    /// Add a ledge to the scene
    public func addLedge(width: CGFloat, angle: Int, position: (Int, Int)) {
        self.gameSkScene.addChild(
            Ledge(width: width,
                  angle: angle,
                  position: position,
                  color: self.gameconfig.LedgeColor,
                  fric: Float(self.gameconfig.Friction)))
    }
    
    // Add any `SKNode` to the scene
    public func add(_ n: SKNode) {
        self.gameSkScene.addChild(n)
    }
    
    public var body: some View {
        VStack {
            Text(uiconfig.MainText)
                .font(.title)
            
            Text(uiconfig.SubText)
                .font(.subheadline)
            
            SpriteView(scene: gameSkScene)
                .frame(width: 600, height: 800)
                .edgesIgnoringSafeArea(.all)
        }
        
    }
    
}

/// scene with the items on screen
public class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var config: Configuration = Configuration.init()
    var draggingNodeTracker: [UITouch:SKNode] = [:] // Used to handle dragging and dropping
    var timeLabel: SKLabelNode?
    
    var ballCreationTracker = [UITouch : (TimeInterval, TimeInterval)]()
    // key: Consistent across touchesBegan and touchesEnded
    // value: (touch down , touch up)  <== subtract to get duration of touch
    
    public convenience init(conf: Configuration, size: CGSize) {
        self.init(size: size)
        config = conf
        let startPt = CGPoint(x: 100,y: (self.size.height)/2-100)
        
        let launchPtCirc = SKShapeNode(circleOfRadius: 20)
        launchPtCirc.name = "launcher"
        launchPtCirc.position = startPt
        self.addChild(launchPtCirc)
        
        // the first circle
        let defaultCirc = Ball(radius: config.DefaultBallRadius,
                               pos: startPt,
                               ballColor: config.BallColor,
                               fric: config.Friction,
                               gravity: config.Gravity,
                               dynamic: config.Dynamic)
        self.addChild(defaultCirc)
    }
    
    
    
    
    public override func didMove(to view: SKView) {
        // ball time indicator
        self.timeLabel = SKLabelNode(text: "")
        self.timeLabel?.fontSize = 32
        self.timeLabel?.fontName = "San Francisco Bold"
        self.timeLabel?.position = CGPoint(x: 100,y: (self.size.height)/2-100)
        self.addChild(self.timeLabel!)
        
        //launch point helper
        
        
        self.backgroundColor = self.config.BackgroundColor
        
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
                let labelText = String(format:"%.2f", ballNode.timeReachedBottom!.timeIntervalSince(ballNode.timeCreated)) + "s"
                ballNode.labelNode.text = labelText
                self.timeLabel?.text = labelText
                self.timeLabel?.position = CGPoint(x: ballNode.position.x,
                                                   y: -self.size.height/2+100)
            }
        }
        
        if contact.bodyB.node is Ball {
            let ballNode = (contact.bodyB.node as! Ball)
            // if this is the first time it's fallen (we don't want to update on bounce)
            if (ballNode.timeReachedBottom == nil) {
                ballNode.timeReachedBottom = Date()
                let labelText = String(format:"%.2f", ballNode.timeReachedBottom!.timeIntervalSince(ballNode.timeCreated)) + "s"
                ballNode.labelNode.text = labelText
                self.timeLabel?.text = labelText
                self.timeLabel?.position = CGPoint(x: ballNode.position.x,
                                                   y: -self.size.height/2+60)
            }
        }
    }
    
    /// Start tracking touches for draggability and marble creation
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // reset the dragging list
        self.draggingNodeTracker = [:]
        for touch in touches {
            let theNode = atPoint(touch.location(in: self))
            // if open space is pressed
            if (theNode == self)
                || (theNode.name == "launcher") {
                // if it isn't on a node, we should create an entry in ballCreationTracker
                ballCreationTracker.updateValue((touch.timestamp, touch.timestamp), forKey: touch)
                continue
            } else if (theNode.name == "ballChild")
                        || (theNode.name == "launcher") {
                // we don't want to move the launcher or ball children
                continue
            } else if (theNode.name == "ledge")
            // || (theNode.name == "ballWrapper")
            {
                // if this is a ball or a ledge
                self.draggingNodeTracker[touch] = theNode
                
                // toggle gravity during movement
                theNode.physicsBody?.affectedByGravity.toggle()
            }
        }
    }
    
    /// Dragging
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if (draggingNodeTracker[touch] != nil) {
                // if this was in the dragged nodes list
                draggingNodeTracker[touch]?.position = touch.location(in: self)
                continue
            } else {
                // we don't need to do anything if this wasn't a drag movement.
                continue
            }
        }
    }
    
    /// Marble Creation
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            if (draggingNodeTracker[touch] != nil) {
                // toggle gravity back to original
                // another handy feature of swift - boolean.toggle
                draggingNodeTracker[touch]?.physicsBody?.affectedByGravity.toggle()
                // complete the dragging and remove from list
                draggingNodeTracker[touch] = nil
                
                // notice how we don't move any nodes. That was already done in `touchesMoved`
            } else if (ballCreationTracker[touch] != nil) {
                // if we are dealing with ball creation
                ballCreationTracker.updateValue((ballCreationTracker[touch]!.0, touch.timestamp), forKey: touch)
                let radius = ballCreationTracker[touch]!.1-ballCreationTracker[touch]!.0
                
                // safety check (we don't want giant circles or negative radii because of a glitch)
                if (radius < 0.05) || (radius > 0.8) {
                    continue
                }
                
                let circ = Ball(radius: Int(radius*200),
                                pos: touch.location(in: self),
                                ballColor: self.config.BallColor,
                                fric: self.config.Friction,
                                // NOTE: We only want to honor gravity and isDynamic choices on the default marble to show the effects of Applied force.
                                gravity: true,
                                dynamic: true)
                self.addChild(circ)
            }
            
        }
        
    }
    
}



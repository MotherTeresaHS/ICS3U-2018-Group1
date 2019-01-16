
// Created on: Dec-2018
// Created by: Mark Ison
// Created for: ICS3U
// This program is the template for the ICS3U final project

// this will be commented out when code moved to Xcode
import PlaygroundSupport


import SpriteKit

class GameScene: SKScene {
    // local variables to this scene
    let gameSceneBackground = SKSpriteNode(imageNamed: "splashSceneImage.png")
    let moveToNextSceneDelay = SKAction.wait(forDuration: 3.0)
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        
        /* Setup your scene here */
        self.backgroundColor = SKColor(red: 0.0, green:0.0, blue:0.0, alpha: 1.0)
        
        gameSceneBackground.name = "splash Scene Background"
        gameSceneBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        gameSceneBackground.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.addChild(gameSceneBackground)
        
        gameSceneBackground.run(moveToNextSceneDelay) {
            //run code here after 3 secs
            
            self.gameSceneBackground.removeAllActions()
            let mainMenuScene = MainMenuScene(size: self.size)
            self.view?.presentScene(mainMenuScene)
        }
    }
    
    override func  update(_ currentTime: TimeInterval) {
        //
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //when the screen is touched, it moves to the main menu
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
    }
}

class MainMenuScene: SKScene, SKPhysicsContactDelegate {
    // local variables to this scene
    let MainMenuSceneBackground = SKSpriteNode(imageNamed: "PNG image-A54BF836A966-1.jpg")
    
    let startButton = SKSpriteNode(imageNamed: "IMG_2880.PNG")
    
    
    
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        MainMenuSceneBackground.name = "Setting Scene Background"
        MainMenuSceneBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        MainMenuSceneBackground.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.addChild(MainMenuSceneBackground)
        
        startButton.position = CGPoint(x: frame.midX, y: frame.midY)
        startButton.name = "start button"
        self.addChild(startButton)
        startButton.setScale(0.65)
        
    }
    
    override func  update(_ currentTime: TimeInterval) {
        //
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // when the start button is touched, it moves to the main game
        let touch = touches as! Set<UITouch>
        let positionInScene = touch.first!.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let startButton = touchedNode.name {
            if startButton == "start button" {
                let mainGameScene = MainGameScene(size: self.size)
                self.view!.presentScene(mainGameScene)
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
        
    }
}

class MainGameScene: SKScene, SKPhysicsContactDelegate {
    // local variables to this scene
    let MainGameSceneBackground = SKSpriteNode(imageNamed: "PNG image-A54BF836A966-1.jpg")
    
    let monster = SKSpriteNode(imageNamed: "IMG_2892.PNG")
    
    let rightButton = SKSpriteNode(imageNamed:"IMG_2896.PNG")
    let leftButton = SKSpriteNode(imageNamed: "IMG_2897.PNG")
    
    var rightButtonClicked = false
    var leftButtonClicked = false
    
    var candies = [SKSpriteNode]()
    var candiesAttackRate: Double = 1
    
    func createCandies() {
        //
        
        let aSingleCandy = SKSpriteNode(imageNamed: "IMG_2909.PNG")
        aSingleCandy.name = "Candy"
        aSingleCandy.setScale(0.80)
        aSingleCandy.zPosition = 7.0
        aSingleCandy.physicsBody?.isDynamic = true
        aSingleCandy.physicsBody = SKPhysicsBody(texture: aSingleCandy.texture!, size: aSingleCandy.size)
        aSingleCandy.physicsBody?.affectedByGravity = false
        aSingleCandy.physicsBody?.usesPreciseCollisionDetection = true
        aSingleCandy.physicsBody?.collisionBitMask = 0x0
        
        let candiesStartPositionX = Int(arc4random_uniform(UInt32(frame.size.width - 0 + 1)))
        
        let candiesEndPositionX = Int(arc4random_uniform(UInt32(frame.size.width - 0 + 1)))
        aSingleCandy.position = CGPoint(x: candiesStartPositionX, y: Int(frame.size.height) + 100)
        
        let candyMove = SKAction.move(to: CGPoint(x: candiesEndPositionX, y:  -100), duration: 4)
        aSingleCandy.run(candyMove)
        self.addChild(aSingleCandy)
        candies.append(aSingleCandy)
    }
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        
        
        MainGameSceneBackground.name = "Main Game Scene Background"
        MainGameSceneBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        MainGameSceneBackground.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.addChild(MainGameSceneBackground)
        
        monster.name = "monster"
        monster.position = CGPoint(x: screenSize.width / 2, y: 100)
        self.addChild(monster)
        monster.setScale(0.65)
        
        leftButton.name = "left button"
        leftButton.zPosition = 4.0
        leftButton.position = CGPoint(x: 100, y: 100)
        leftButton.alpha = 0.8
        self.addChild(leftButton)
        leftButton.setScale(0.75)
        
        rightButton.name = "right button"
        rightButton.zPosition = 5.0
        rightButton.position = CGPoint(x: 600, y: 100)
        rightButton.alpha = 0.8
        self.addChild(rightButton)
        rightButton.setScale(0.75)
        
        
        
    }
    
    override func  update(_ currentTime: TimeInterval) {
        //
        
        if rightButtonClicked == true && monster.position.x <= (frame.size.width){
            var moveMonsterRight = SKAction.moveBy(x: 10, y: 0, duration : 0.1)
            monster.run(moveMonsterRight)
        }
            
        else if leftButtonClicked == true && monster.position.x >= 0 {
            var moveMonsterLeft = SKAction.moveBy(x: -10, y: 0, duration: 0.1)
            monster.run(moveMonsterLeft)     
            
        }
        
        // Randomly Create Candies
        let createAlienChance = Int(arc4random_uniform(120) + 1)
        if createAlienChance <= Int(candiesAttackRate){
            createCandies()
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var touch = touches as! Set<UITouch>
        var location = touch.first!.location(in: self)
        var touchedNode = self.atPoint(location)
        
        if let touchedNodeName = touchedNode.name {
            if touchedNodeName == "left button" {
                leftButtonClicked = true
            }
            else if touchedNodeName == "right button" {
                rightButtonClicked = true
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        var touch = touches as! Set<UITouch>
        var location = touch.first!.location(in: self)
        var touchedNode = self.atPoint(location)
        
        if let touchedNodeName = touchedNode.name {
            if touchedNodeName == "left button" {
                leftButtonClicked = false
            }
            else if touchedNodeName == "right button" {
                rightButtonClicked = false
            }
    }
}
}




// this will be commented out when code moved to Xcode

// set the frame to be the size for your iPad

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

let scene = GameScene(size: frame.size)
scene.scaleMode = SKSceneScaleMode.resizeFill

let skView = SKView(frame: frame)
skView.showsFPS = true
skView.showsNodeCount = true
skView.presentScene(scene)

PlaygroundPage.current.liveView = skView

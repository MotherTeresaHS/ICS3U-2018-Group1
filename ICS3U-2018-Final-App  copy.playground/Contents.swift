
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
    let mainMenuSceneBackground = SKSpriteNode(imageNamed: "PNG image-A54BF836A966-1.jpg")
    
    let startButton = SKSpriteNode(imageNamed: "IMG_2880.PNG")
    
    
    
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        mainMenuSceneBackground.name = "Setting Scene Background"
        mainMenuSceneBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        mainMenuSceneBackground.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.addChild(mainMenuSceneBackground)
        
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
    let mainGameSceneBackground = SKSpriteNode(imageNamed: "PNG image-A54BF836A966-1.jpg")
    
    let monster = SKSpriteNode(imageNamed: "IMG_2892.PNG")
    
    let rightButton = SKSpriteNode(imageNamed:"IMG_2896.PNG")
    let leftButton = SKSpriteNode(imageNamed: "IMG_2897.PNG")
    let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    // for adding a score
    var score : Int = 0
    var isMonsterStillAlive = true
    
    var rightButtonClicked = false
    var leftButtonClicked = false
    
    var candies = [SKSpriteNode]()
    var candiesAttackRate: Double = 1
    
    // for Collision Detection
    
    let collisionCandyCategory: UInt32 = 1
    let collisionMonsterCategory: UInt32 = 2
    
    func createCandies() {
        
        //
        
        let aSingleCandy = SKSpriteNode(imageNamed: "IMG_2909.PNG")
        aSingleCandy.name = "Candy"
        aSingleCandy.physicsBody?.isDynamic = true
        aSingleCandy.physicsBody = SKPhysicsBody(texture: aSingleCandy.texture!, size: aSingleCandy.size)
        aSingleCandy.physicsBody?.affectedByGravity = false
        aSingleCandy.physicsBody?.usesPreciseCollisionDetection = true
        aSingleCandy.physicsBody?.categoryBitMask = collisionCandyCategory
        aSingleCandy.physicsBody?.contactTestBitMask = collisionMonsterCategory
        aSingleCandy.physicsBody?.collisionBitMask = 0x0
        aSingleCandy.setScale(0.80)
        
        
        let candiesStartPositionX = Int(arc4random_uniform(UInt32(frame.size.width - 0 + 1)))
        
        let candiesEndPositionX = Int(arc4random_uniform(UInt32(frame.size.width - 0 + 1)))
        aSingleCandy.position = CGPoint(x: candiesStartPositionX, y: Int(frame.size.height) + 100)
        
        let candyMove = SKAction.move(to: CGPoint(x: candiesEndPositionX, y:  -10), duration: 3)
        aSingleCandy.run(candyMove)
        self.addChild(aSingleCandy)
        candies.append(aSingleCandy)
    }
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        
        
        mainGameSceneBackground.name = "Main Game Scene Background"
        mainGameSceneBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        mainGameSceneBackground.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.addChild(mainGameSceneBackground)
        
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.fontColor = #colorLiteral(red: 0.46666666865348816, green: 0.7647058963775635, blue: 0.2666666805744171, alpha: 1.0)
        scoreLabel.fontSize = 50
        scoreLabel.position = CGPoint(x: 25, y: frame.size.height - 50)
        self.addChild(scoreLabel)
        
        monster.name = "monster"
        monster.physicsBody?.isDynamic = true
        monster.physicsBody = SKPhysicsBody(texture: monster.texture!, size: monster.size)
        monster.physicsBody?.affectedByGravity = false
        monster.physicsBody?.usesPreciseCollisionDetection = true
        monster.physicsBody?.categoryBitMask = collisionMonsterCategory
        monster.physicsBody?.contactTestBitMask = collisionCandyCategory
        monster.physicsBody?.collisionBitMask = 0x0
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
        
        // Handle Collisions
        self.physicsWorld.contactDelegate = self
        
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
            
            for aSingleCandy in candies {
                if aSingleCandy.position.y <  -10{
                    aSingleCandy.position.x = -500
                    
                    aSingleCandy.removeFromParent()
                    candies.removeFirst()
                    
                    isMonsterStillAlive = false
                    
                    let moveToNextSceneDelay = SKAction.wait(forDuration: 0.1)
                    
                    run(moveToNextSceneDelay) {
                        
                        let gameOverScene = GameOverScene(size: self.size)
                        self.view?.presentScene(gameOverScene)
                    }
                }
            
        }
        
        }
        
        // Randomly Create Candies
        let createCandyChance = Int(arc4random_uniform(100) + 1)
        if createCandyChance <= Int(candiesAttackRate){
            createCandies()
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // Check Each Frame if Candy is touching monster
        
        let secondNode = contact.bodyB.node as! SKSpriteNode
        
        if ((contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (collisionCandyCategory | collisionMonsterCategory)){
            
            contact.bodyB.node?.position.y = frame.size.height + 1000
            
            contact.bodyB.node?.removeFromParent()
            candiesAttackRate += 0.005
            
            if isMonsterStillAlive == true {
                score = score + 5
                scoreLabel.text = "Score: " + String(score)
                
            }
            
        }
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
    class GameOverScene: SKScene, SKPhysicsContactDelegate {
        
        let gameOverSceneBackground = SKSpriteNode(imageNamed: "PNG image-A54BF836A966-1.jpg")
        
        let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        
        let menuButton = SKSpriteNode(imageNamed:"IMG_2907.PNG")
        let restartButton = SKSpriteNode(imageNamed: "IMG_2913.PNG")
        
        override func didMove(to view: SKView) {
            // this is run when the scene loads
            
            gameOverSceneBackground.name = "Main Game Scene Background"
            gameOverSceneBackground.position = CGPoint(x: frame.midX, y: frame.midY)
            gameOverSceneBackground.size = CGSize(width: frame.size.width, height: frame.size.height)
            self.addChild(gameOverSceneBackground)
            
            gameOverLabel.text = "Game Over"
            gameOverLabel.zPosition = 1.0
            gameOverLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            gameOverLabel.fontColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            gameOverLabel.fontSize = 70
            gameOverLabel.position = CGPoint(x: (frame.size.width / 4.5), y: frame.midY + 30)
            self.addChild(gameOverLabel)
            
            menuButton.position = CGPoint(x: (frame.midX - 50), y: frame.midY - 50)
            menuButton.name = "menu button"
            menuButton.zPosition = 2.0
            self.addChild(menuButton)
            menuButton.setScale(0.40)
            
            restartButton.position = CGPoint(x: (frame.midX + 100), y: frame.midY - 50)
            restartButton.name = "restart button"
            self.addChild(restartButton)
            restartButton.setScale(0.40)
            
        }
        
        override func  update(_ currentTime: TimeInterval) {
            //
            
        }
        
        func didBegin(_ contact: SKPhysicsContact) {
            //
            
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            //
            let touch = touches as! Set<UITouch>
            let positionInScene = touch.first!.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let menuButton = touchedNode.name {
                if menuButton == "menu button" {
                    let mainMenuScene = MainMenuScene(size: self.size)
                    self.view!.presentScene(mainMenuScene)
                }
            }
            
            if let restartButton = touchedNode.name{
                if restartButton == "restart button"{
                    let mainGameScene = MainGameScene(size:self.size)
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

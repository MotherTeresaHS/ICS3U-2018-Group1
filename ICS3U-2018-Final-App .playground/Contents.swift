
// Created on: Dec-2018
// Created by: Mark Ison
// Created for: ICS3U
// This program is the template for the ICS3U final project

// this will be commented out when code moved to Xcode
import PlaygroundSupport


import SpriteKit

class SplashScene: SKScene {
    // local variables to this scene
    let splashSceneBackground = SKSpriteNode(imageNamed: "splashSceneImage.png")
    let moveToNextSceneDelay = SKAction.wait(forDuration: 3.0)
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        
        /* Setup your scene here */
        self.backgroundColor = SKColor(red: 0.0, green:0.0, blue:0.0, alpha: 1.0)
        
        splashSceneBackground.name = "splash Scene Background"
        splashSceneBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        splashSceneBackground.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.addChild(splashSceneBackground)
        
        splashSceneBackground.run(moveToNextSceneDelay) {
            //run code here after 3 secs
            
            self.splashSceneBackground.removeAllActions()
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
    let settingButton = SKSpriteNode(imageNamed: "IMG_2882.PNG")
    
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
        
        settingButton.position = CGPoint(x:(frame.size.width/1.065) , y:(frame.size.height/1.11))
        settingButton.name = "setting button"
        self.addChild(settingButton)
        settingButton.setScale(0.38)
        
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
        
        if let settingButton = touchedNode.name {
            if settingButton == "setting button"{
                let settingScene = SettingScene(size: self.size)
                self.view!.presentScene(settingScene)
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
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        MainGameSceneBackground.name = "Main Game Scene Background"
        MainGameSceneBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        MainGameSceneBackground.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.addChild(MainGameSceneBackground)
        
    }
    
    override func  update(_ currentTime: TimeInterval) {
        //
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
}

class SettingScene: SKScene, SKPhysicsContactDelegate {
    // local variables to this scene
    let settingSceneBackground = SKSpriteNode(imageNamed: "PNG image-A54BF836A966-1.jpg")
    let returnButton = SKSpriteNode(imageNamed: "IMG_2891.PNG")
    
    override func didMove(to view: SKView) {
        // this is run when the scene loads
        settingSceneBackground.name = "Setting Scene Background"
        settingSceneBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        settingSceneBackground.size = CGSize(width: frame.size.width, height: frame.size.height)
        self.addChild(settingSceneBackground)
        
        returnButton.position = CGPoint(x:(frame.size.width/2.80) , y:(frame.size.height/1.11))
        returnButton.name = "setting button"
        self.addChild(returnButton)
        returnButton.setScale(0.38)
        
    }
    
    override func  update(_ currentTime: TimeInterval) {
        //
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches as! Set<UITouch>
        let positionInScene = touch.first!.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let returnButton = touchedNode.name {
            if returnButton == "return button"{
                let mainMenuScene = MainMenuScene(size: self.size)
                self.view!.presentScene(MainMenuScene)
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




// this will be commented out when code moved to Xcode

// set the frame to be the size for your iPad

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

let scene = SplashScene(size: frame.size)
scene.scaleMode = SKSceneScaleMode.resizeFill

let skView = SKView(frame: frame)
skView.showsFPS = true
skView.showsNodeCount = true
skView.presentScene(scene)

PlaygroundPage.current.liveView = skView

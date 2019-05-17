//
//  GameScene.swift
//  mockTest
//
//  Created by Kristopher Vala on 2019-04-09.
//  Copyright © 2019 Kristopher Vala. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreData
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    let coinSound = SKAction.playSoundFileNamed("pew", waitForCompletion: false)

    
    var paddle: SKSpriteNode?
    var bucket: SKSpriteNode?
    var ree: SKSpriteNode?
    var last: SKSpriteNode?
    var barrier: SKSpriteNode?
    var lifebar: SKSpriteNode?
    var background: SKSpriteNode?

    var ballTimer: Timer?
    var ballTimer2: Timer?
    var ballTimer3: Timer?
    
   
    
    var scoreLab: SKLabelNode?
    var lifeLab: SKLabelNode?
    var finalscoreLab: SKLabelNode?
    var exitLab: SKLabelNode?

    
    var viewController: GameViewController!

    
    var lives = 5
    var count = 5
   
    
    var score = 0
    var finalscore = 0
    var nextLevel = 0

    let reeCategory: UInt32 = 0x1 << 1 //=1
    let barrierCategory: UInt32 = 0x1 << 5 //=1

    let invaderCategory: UInt32 = 0x1 << 2 //=2
    

    let dummyCategory: UInt32 = 0x1 << 6 // 64
  
    var touchStart: CGPoint?
    var startTime : TimeInterval?
    
    let minSpeed:CGFloat = 10000
    let maxSpeed:CGFloat = 50000
    let minDistance:CGFloat = 10
    let minDuration:TimeInterval = 0.1
    
    
    override func didMove(to view: SKView) {

        lifebar = childNode(withName: "lifebar") as? SKSpriteNode
        lifebar?.texture = SKTexture(imageNamed: "life5")

        
        
        scoreLab = self.childNode(withName: "scoreLab") as! SKLabelNode
        
        lifeLab = self.childNode(withName: "Life") as! SKLabelNode
        finalscoreLab = self.childNode(withName: "finalscoreLab") as! SKLabelNode
        finalscoreLab?.isHidden = true
        
        exitLab = self.childNode(withName: "exit") as! SKLabelNode
        exitLab?.isHidden = true
        
        lifeLab?.text = ("Lives: \(lives)")
        
        physicsWorld.contactDelegate = self  //The driver of the physics engine in a scene; it exposes the ability for you to configure and query the physics system
        
        ree = childNode(withName: "bucket2") as? SKSpriteNode
        barrier = childNode(withName: "barrier") as? SKSpriteNode
        background = childNode(withName: "back") as? SKSpriteNode
        background?.texture = SKTexture(imageNamed: "gameback")

        
        ree?.physicsBody?.categoryBitMask = reeCategory
        ree?.physicsBody?.contactTestBitMask = invaderCategory
        
        barrier?.physicsBody?.categoryBitMask = barrierCategory
        barrier?.physicsBody?.contactTestBitMask = invaderCategory
        
        
        
        var reeHit : [SKTexture] = []
        for number in 1...2 {
            reeHit.append(SKTexture(imageNamed: "ship-\(number).png"))
        }
        ree?.run(SKAction.repeatForever(SKAction.animate(with: reeHit, timePerFrame: 0.2)))
        
        ballTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (timer) in
            self.getRandom()
        })
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
       
        
        touchStart = touches.first?.location(in: self)
        startTime = touches.first?.timestamp
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchStart = self.touchStart else {
            return
        }
        guard let startTime = self.startTime else {
            return
        }
        guard let location = touches.first?.location(in: self) else {
            return
        }
        guard let time = touches.first?.timestamp else {
            return
        }
        var dx = location.x - touchStart.x
        var dy = location.y - touchStart.y
        // Distance of the gesture
        let distance = sqrt(dx*dx+dy*dy)
        
        if distance >= minDistance {
            // Duration of the gesture
            let deltaTime = time - startTime
            if deltaTime > minDuration {
                // Speed of the gesture
                let speed = distance / CGFloat(deltaTime)
                if speed >= minSpeed && speed <= maxSpeed {
                    // Normalize by distance to obtain unit vector
                    if(minDistance > 0){
                        dx /= distance
                        dy /= distance
                        
                    } else{
                        dx /= distance
                        dy /= distance
                    }
                    
                }
            }
            ree?.physicsBody?.applyForce(CGVector(dx: dx*100, dy: dy*100))
        }
        else
        {
            Shoot()

        }
    }
    
    
    func getRandom(){
        nextLevel = nextLevel + 1
        if( nextLevel == 3 ){
            ballTimer?.invalidate()
            
            ballTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
                self.getRandom()
            })
        }
        if( nextLevel == 7 ){
            ballTimer?.invalidate()
            
            ballTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                self.getRandom()
            })
        }
        
        
        
        let randomNumber = Int(arc4random_uniform(3) + 1)
        
        if randomNumber == 1 {
            createBall()
        } else if randomNumber == 2 {
            createBall2()
        }
        else{
            createBall3()
        }
        
        
    }
    
    
    func Shoot() {
        
        let ballCenter = ree?.position

        let ball = SKSpriteNode(imageNamed: "laser")
        ball.size = CGSize(width: 50, height: 50)
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.categoryBitMask = dummyCategory
        ball.physicsBody?.collisionBitMask = dummyCategory
        ball.physicsBody?.contactTestBitMask = invaderCategory
        
        addChild(ball)
        
        let maxY = size.height / 2 - ball.size.height / 2
        let minY = -size.height / 4 + ball.size.height / 2
        let maxX = size.width / 2  - ball.size.width / 2
        let minX = -size.width / 4 + ball.size.width / 2
        let range = maxY - minY
        let rangeX = maxX - minX
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        let coinX = maxX - CGFloat(arc4random_uniform(UInt32(rangeX)))
        
        ball.position = CGPoint(x: (ballCenter?.x)!, y: ((ballCenter?.y)! + 50))
        //let moveLeft = SKAction.moveBy(x: -size.width - coin.size.width, y: 0, duration: 4)
        let moveDown = SKAction.moveBy(x: coinX / 2, y: +1200, duration: 8)
        let mySeq = SKAction.sequence([moveDown, SKAction.removeFromParent()])
        last = ball
        ball.run(mySeq)
        run(coinSound)
    }
    
    func createBall() {
        let ball = SKSpriteNode(imageNamed: "invader-1")
        ball.size = CGSize(width: 100, height: 100)
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.categoryBitMask = invaderCategory
        ball.physicsBody?.collisionBitMask = dummyCategory
        ball.physicsBody?.contactTestBitMask = reeCategory
        addChild(ball)
        
        let maxY = size.height / 2 - ball.size.height / 2
        let minY = -size.height / 4 + ball.size.height / 2
        let maxX = size.width / 2  - ball.size.width / 2
        let minX = -size.width / 4 + ball.size.width / 2
        let range = maxY - minY
        let rangeX = maxX - minX
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        let coinX = maxX - CGFloat(arc4random_uniform(UInt32(rangeX)))
        
        ball.position = CGPoint(x: coinX / 4, y: size.height / 2)
        //let moveLeft = SKAction.moveBy(x: -size.width - coin.size.width, y: 0, duration: 4)
        let moveDown = SKAction.moveBy(x: coinX / 2, y: -1200, duration: 6)
        let mySeq = SKAction.sequence([moveDown, SKAction.removeFromParent()])
        last = ball
        ball.run(mySeq)
    }
    
    func createBall2() {
        let ball = SKSpriteNode(imageNamed: "invader-2")
        ball.size = CGSize(width: 100, height: 100)
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.categoryBitMask = invaderCategory
        ball.physicsBody?.collisionBitMask = dummyCategory
        ball.physicsBody?.contactTestBitMask = reeCategory
        addChild(ball)
        
        let maxY = size.height / 2 - ball.size.height / 2
        let minY = -size.height / 4 + ball.size.height / 2
        let maxX = size.width / 2  - ball.size.width / 2
        let minX = -size.width / 4 + ball.size.width / 2
        let range = maxY - minY
        let rangeX = maxX - minX
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        let coinX = maxX - CGFloat(arc4random_uniform(UInt32(rangeX)))
        
        ball.position = CGPoint(x: coinX / 2, y: size.height / 2)
        //let moveLeft = SKAction.moveBy(x: -size.width - coin.size.width, y: 0, duration: 4)
        let moveDown = SKAction.moveBy(x: 0, y: -1200, duration: 6)
        let mySeq = SKAction.sequence([moveDown, SKAction.removeFromParent()])
        last = ball
        ball.run(mySeq)
    }
    
    func createBall3() {
        let ball = SKSpriteNode(imageNamed: "invader-3")
        ball.size = CGSize(width: 100, height: 100)
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.categoryBitMask = invaderCategory
        ball.physicsBody?.collisionBitMask = dummyCategory
        ball.physicsBody?.contactTestBitMask = reeCategory
        addChild(ball)
        
        let maxY = size.height / 2 - ball.size.height / 2
        let minY = -size.height / 4 + ball.size.height / 2
        let maxX = size.width / 2  - ball.size.width / 2
        let minX = -size.width / 4 + ball.size.width / 2
        let range = maxY - minY
        let rangeX = maxX - minX
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        let coinX = maxX - CGFloat(arc4random_uniform(UInt32(rangeX)))
        
        ball.position = CGPoint(x: coinX / 2, y: size.height / 2)
        //let moveLeft = SKAction.moveBy(x: -size.width - coin.size.width, y: 0, duration: 4)
        let moveDown = SKAction.moveBy(x: 0, y: -1200, duration: 6)
        let mySeq = SKAction.sequence([moveDown, SKAction.removeFromParent()])
        last = ball
        ball.run(mySeq)
    }
    
    func gameOver(){
        finalscore = score
        
        scene?.isPaused = true
        finalscoreLab?.isHidden = false
        exitLab?.isHidden = false

        finalscoreLab?.text = ("Final Score: \(finalscore)")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newuser = NSEntityDescription.insertNewObject(forEntityName: "Players", into: context)
        var namestore = UserDefaults.standard.value(forKey: "playerName")
        newuser.setValue(namestore, forKey:"name")
        newuser.setValue(finalscore, forKey:"score")
        
        do{
            print ("Saved your score for: \(namestore)")
            try context.save()
            
        } catch{
            print ("Couldn't save!")
        }
        
        update()
    
    }
    
   
    
    func update() {
        self.removeAllActions()
        self.removeAllChildren()
        self.removeFromParent()
        self.view?.presentScene(nil)
        
        self.viewController.dismiss()
       
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if(lives > 0){
            
            
            
            if contact.bodyA.categoryBitMask == dummyCategory {
                contact.bodyB.node?.removeFromParent()
                contact.bodyA.node?.removeFromParent()

                score += 1
                scoreLab?.text = "Score: \(score)"

                return()
            }
            if contact.bodyB.categoryBitMask == invaderCategory {
                contact.bodyB.node?.removeFromParent()
             //   contact.bodyA.node?.removeFromParent()
                lives -= 1
                lifeLab?.text = ("Lives: \(lives)")
                if(lives == 4){
                    lifebar?.texture = SKTexture(imageNamed: "life4")
                }
                if(lives == 3){
                    lifebar?.texture = SKTexture(imageNamed: "life3")
                }
                if(lives == 2){
                    lifebar?.texture = SKTexture(imageNamed: "life2")
                }
                if(lives == 1){
                    lifebar?.texture = SKTexture(imageNamed: "life1")
                }
                if(lives == 0){
                    lifebar?.texture = SKTexture(imageNamed: "life0")
                }
                
                return()
            }
                
            else if contact.bodyA.categoryBitMask == barrierCategory {
                contact.bodyB.node?.removeFromParent()
                lives -= 1
                lifeLab?.text = ("Lives: \(lives)")
                if(lives == 4){
                    lifebar?.texture = SKTexture(imageNamed: "life4")
                }
                if(lives == 3){
                    lifebar?.texture = SKTexture(imageNamed: "life3")
                }
                if(lives == 2){
                    lifebar?.texture = SKTexture(imageNamed: "life2")
                }
                if(lives == 1){
                    lifebar?.texture = SKTexture(imageNamed: "life1")
                }
                if(lives == 0){
                    lifebar?.texture = SKTexture(imageNamed: "life0")
                }
               
                return()
            }
            if contact.bodyB.categoryBitMask == barrierCategory{

                contact.bodyB.node?.removeFromParent()
                
                lives -= 1
                lifeLab?.text = ("Lives: \(lives)")
                if(lives == 4){
                    lifebar?.texture = SKTexture(imageNamed: "life4")
                }
                if(lives == 3){
                    lifebar?.texture = SKTexture(imageNamed: "life3")
                }
                if(lives == 2){
                    lifebar?.texture = SKTexture(imageNamed: "life2")
                }
                if(lives == 1){
                    lifebar?.texture = SKTexture(imageNamed: "life1")
                }
                if(lives == 0){
                    lifebar?.texture = SKTexture(imageNamed: "life0")
                }
                return()
            }
        
        }
        else{
            finalscore = score
            UserDefaults.standard.set(finalscore, forKey: "finalscoree")

            ballTimer?.invalidate()
            gameOver()
        }
        
        
        
    }
    
 
    
   
    
    
    
    
    
    
    
    
    
}



//
//  GameScene.swift
//  Game
//
//  Created by Patrick on 01/07/17.
//  Copyright © 2017 Patrick. All rights reserved.
//

import SpriteKit
import GameplayKit


func + (left: CGPoint, right: CGPoint) -> CGPoint{
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint{
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint{
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint{
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat{
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint{
    func length() -> CGFloat{
        return sqrt(x * x + y * y)
    }
    
    func normalize() -> CGPoint{
        return self / length()
    }
}

struct Fisica{
    static let None    : UInt32 = 0
    static let All     : UInt32 = UInt32.max
    static let Monstro : UInt32 = 0b1
    static let Tiro        : UInt32 = 0b10
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let jogador = SKSpriteNode(imageNamed: "player")
    var monstrosDestruidos = 0
    var monstrosMortos = 0
    var score : SKLabelNode!
    var life : SKLabelNode!
    
    var qtdVidas : Int = 3
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        run(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let tiro = SKSpriteNode(imageNamed: "projectile")
        tiro.position = jogador.position
        
        //Adicionando física ao tiro
        tiro.physicsBody = SKPhysicsBody(circleOfRadius: tiro.size.width / 2)
        tiro.physicsBody?.isDynamic = true
        tiro.physicsBody?.categoryBitMask = Fisica.Tiro
        tiro.physicsBody?.contactTestBitMask = Fisica.Monstro
        tiro.physicsBody?.collisionBitMask = Fisica.None
        tiro.physicsBody?.usesPreciseCollisionDetection = true
        
        /*
        let touch = touches.first!
        let touchLocation = touch.location(in: self)
        
        let tiro = SKSpriteNode(imageNamed: "projectile")
        tiro.position = jogador.position
        */
        let offset = touchLocation - tiro.position
        
        if offset.x < 0{
            return
        }
        
        addChild(tiro)
        
        let direcao = offset.normalize()
        let qtdTiro = direcao * 1000
        let destino = qtdTiro + tiro.position
        
        let acaoMovimento = SKAction.move(to: destino, duration: 3.0)
        let acaoNaoMovimento = SKAction.removeFromParent()
        tiro.run(SKAction.sequence([acaoMovimento, acaoNaoMovimento]))
        
    }
    
    override func didMove(to view: SKView) {
        
        score = SKLabelNode(fontNamed: "Chalkduster")
        score.fontSize = 20
        score.fontColor = SKColor.blue
        score.position = CGPoint(x: size.width/2, y: /*size.height/2*/ 0)
        addChild(score)
        score.text = "Score: 0"
        
        life = SKLabelNode(fontNamed: "Chalkduster")
        life.fontSize = 20
        life.fontColor = SKColor.red
        life.position = CGPoint(x: /*self.frame.size.width/2*/40, y: /*self.frame.size.height/2*/ 0)
        addChild(life)
        life.text = "Life: 3"
        
        backgroundColor = SKColor.white
        jogador.position = CGPoint(
            x:size.width * 0.1,
            y: size.height * 0.5)
        addChild(jogador)
        
        //Adicionando a física
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
    
        
        run(
            SKAction.repeatForever(
                SKAction.sequence(
                    [
                        SKAction.run{self.addMonstro()},
                        SKAction.wait(forDuration: 1.0)
                    ]
                )
            )
        )
        
        let backgroundMusica = SKAudioNode(
            fileNamed: "background-music-aac.caf")
        backgroundMusica.autoplayLooped = true
        addChild(backgroundMusica)
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var objetoA : SKPhysicsBody
        var objetoB : SKPhysicsBody
        
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            objetoA = contact.bodyA
            objetoB = contact.bodyB
        }else{
            objetoA = contact.bodyB
            objetoB = contact.bodyA
        }
        
        if( (objetoA.categoryBitMask & Fisica.Monstro != 0) && (objetoB.categoryBitMask & Fisica.Tiro != 0)){
            tiroAtingeMonstro(tiro: objetoA.node as! SKSpriteNode, monstro: objetoB.node as! SKSpriteNode)
        }
        
    }
    
    func addMonstro(){
        
        let monstro = SKSpriteNode (imageNamed: "monster")
        
        //Adicionando a física ao Monstro
        monstro.physicsBody = SKPhysicsBody(rectangleOf: monstro.size)
        monstro.physicsBody?.isDynamic = true
        monstro.physicsBody?.categoryBitMask = Fisica.Monstro
        monstro.physicsBody?.contactTestBitMask = Fisica.Tiro
        monstro.physicsBody?.collisionBitMask = Fisica.None
        
        let positionY = random(
            min: monstro.size.height / 2,
            max: size.height - monstro.size.height / 2
        )
        
        monstro.position = CGPoint(
            x: size.width + monstro.size.width / 2,
            y: positionY
        )
        
        addChild(monstro)
        
        let tempoVida = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let acaoMovimento = SKAction.move(
            to: CGPoint(
                x: -monstro.size.height/2,
                y: positionY),
            duration: TimeInterval(tempoVida)
        )
        
        let acaoNaoMovimento = SKAction.removeFromParent()
        
        
        
        let acaoGameOver = SKAction.run(){
            if(self.qtdVidas < 2){
                self.qtdVidas -= 1
                self.life.text = "Life: " + String(self.qtdVidas)
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameOverScene = GameOverScene(size: self.size, won: false)
                self.view?.presentScene(gameOverScene, transition: reveal)
            }else{
                self.qtdVidas -= 1
                self.life.text = "Life: " + String(self.qtdVidas)
            }
        }
        monstro.run(SKAction.sequence([acaoMovimento, acaoGameOver, acaoNaoMovimento]))
        
    }
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat{
        return (random() * (max - min) + min)
    }
    
    func tiroAtingeMonstro(tiro: SKSpriteNode, monstro: SKSpriteNode){
        tiro.removeFromParent()
        monstro.removeFromParent()
        monstrosDestruidos += 1
        
        score.text = "Score: " + String(monstrosDestruidos)
        
        if(monstrosDestruidos > 50){
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: true)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }

    }
    
}


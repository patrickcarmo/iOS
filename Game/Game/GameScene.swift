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

class GameScene: SKScene {
    
    let jogador = SKSpriteNode(imageNamed: "player")
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.location(in: self)
        
        let tiro = SKSpriteNode(imageNamed: "projectile")
        tiro.position = jogador.position
        
        let offset = touchLocation - tiro.position
        
        if offset.x < 0{
            return
        }
        
        addChild(tiro)
        
        let direcao = offset.normalize()
        let qtdTiro = direcao * 1000
        let destino = qtdTiro + tiro.position
        
        let acaoMovimento = SKAction.move(to: destino, duration: 2.5)
        let acaoNaoMovimento = SKAction.removeFromParent()
        tiro.run(SKAction.sequence([acaoMovimento, acaoNaoMovimento]))
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        jogador.position = CGPoint(
            x:size.width * 0.1,
            y: size.height * 0.5)
        addChild(jogador)
        
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
        
    }
    
    func addMonstro(){
        let monstro = SKSpriteNode (imageNamed: "monster")
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
        monstro.run(SKAction.sequence([acaoMovimento, acaoNaoMovimento]))
    }
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat{
        return (random() * (max - min) + min)
    }
    
}

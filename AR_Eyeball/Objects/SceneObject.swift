//
//  SceneObject.swift
//  AR_Eyeball
//
//  Created by Michael Whinfrey on 4/17/19.
//  Copyright © 2019 Michael Whinfrey. All rights reserved.
//

import Foundation
import SceneKit

class SceneObject: SCNNode {
    init(from file: String) {
        super.init()
        let nodesInFile = SCNNode.allNodes(from: file)
        nodesInFile.forEach { (node) in
            self.addChildNode(node)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class Sphere: SceneObject {
    init() {
        super.init(from: "art.scnassets/AR_Eyeball_v1.dae")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var animating: Bool = false
    
    func animate() {
        if animating { return }
        
        animating = true
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 5.0)
        let hoverUp = SCNAction.moveBy(x: 0, y: 0.2, z: 0, duration: 2.5)
        let hoverDown = SCNAction.moveBy(x: 0, y: -0.2, z: 0, duration: 2.5)
        let hoverSequence = SCNAction.sequence([hoverUp, hoverDown])
        let rotateAndHover = SCNAction.group([rotateOne, hoverSequence])
        let repeatForever = SCNAction.repeatForever(rotateAndHover)
        
        runAction(repeatForever)
    }
    
    func patrol(targetPos: SCNVector3) {
        
            removeAllActions()
            animating = false
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.20
            look(at: targetPos)
            SCNTransaction.commit()
        }
}

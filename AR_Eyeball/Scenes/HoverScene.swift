//
//  HoverScene.swift
//  AR_Eyeball
//
//  Created by Michael Whinfrey on 4/16/19.
//  Copyright © 2019 Michael Whinfrey. All rights reserved.
//

import Foundation
import SceneKit
import ARKit
import UIKit

struct HoverScene {
    var scene: SCNScene?
    
    init() {
        scene = self.initializeScene()
    }
    
    func initializeScene() -> SCNScene? {
        let scene = SCNScene()
        
        setDefaults(scene: scene)
        
        return scene
    }
    
    func setDefaults(scene: SCNScene) {
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = SCNLight.LightType.ambient
        ambientLightNode.light?.color = UIColor(white: 0.6, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        let directionalNode = SCNNode()
        directionalNode.eulerAngles = SCNVector3Make(GLKMathDegreesToRadians(-130), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(35))
        directionalNode.light = directionalLight
        scene.rootNode.addChildNode(directionalNode)
    }
    
    func addSphere(position: SCNVector3) {
        guard let scene = self.scene else { return }
        
        let sphere = Sphere()
        sphere.position = position
        scene.rootNode.addChildNode(sphere)
    }
    
    func addAnimation(node: SCNNode) {
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 5.0)
        node.runAction(rotateOne)
    }
    
    func makeUpdateCameraPos(towards: SCNVector3) {
        guard let scene = self.scene else { return }
        
        scene.rootNode.enumerateChildNodes({ (node, _) in
            if let sphere = node.topmost(until: scene.rootNode) as? Sphere {
                sphere.patrol(targetPos: towards)
            }
        })
    }
}

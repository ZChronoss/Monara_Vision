//
//  JungleView.swift
//  Monara_Vision
//
//  Created by Renaldi Antonio on 06/05/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct JungleView: View {
    
    func placeTree(_ content: RealityViewContent, tree: String) async {
        for _ in 1 ... 5 {
            //                min bounds: minimum size of the target plane
            let anchor = await AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2<Float>(0.6, 0.6)))
            let treeModel = try? await Entity(named: tree, in: realityKitContentBundle).clone(recursive: true)
            
            let x: Float
            let z: Float
            switch tree{
            case "Maple Tree":
                x = Float.random(in: -5 ... 5)
                z = Float.random(in: -5 ... 5)
            case "Pohon Jauh":
                x = Float.random(in: -10 ... 10)
                z = Float.random(in: -10 ... 10)
            case "Semak Scene":
                x = Float.random(in: -10 ... 10)
                z = Float.random(in: -10 ... 10)
            default:
                return
            }
            
            await anchor.setPosition([x, 0, z], relativeTo: anchor)
            await anchor.addChild(treeModel!)
            await anchor.generateCollisionShapes(recursive: true)
            
            content.add(anchor)
        }
    }
    
    func placeTiger(_ content: RealityViewContent) async -> Entity {
        let anchor = await AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2<Float>(0.6, 0.6)))
        let tigerModel = try! await Entity(named: "Tiger Scene", in: realityKitContentBundle)
        
        let x = Float.random(in: -5 ... 5)
        let z = Float.random(in: -5 ... 5)
        
        await anchor.setPosition([x, 0, z], relativeTo: anchor)
        await anchor.addChild(tigerModel)
        await anchor.generateCollisionShapes(recursive: true)
        
        if let entityAnimation = await tigerModel.availableAnimations.first{
//            play animation
            await tigerModel.playAnimation(entityAnimation.repeat(), transitionDuration: 5, startsPaused: false)
        }
        
        return anchor
    }
    
    func loadAmbient(_ content: RealityViewContent) async {
        let ambientController = try? await Entity(named: "AmbientController", in: realityKitContentBundle)
        let ambientAudio = await ambientController?.findEntity(named: "AmbientAudio")
        let audioFileName = "/Root/Forest_Ambient_wav"
        
        guard let resource = try? await AudioFileResource(named: audioFileName, from: "AmbientController.usda", in: realityKitContentBundle) else {return}
        
        await ambientAudio?.playAudio(resource)
        
        content.add(ambientController!)
    }
    
//    func moveEntity(direction: String, tigerEntity: Entity) -> AnimationPlaybackController{
//        var movement: AnimationPlaybackController!
//        var moveToLocation: Transform
//        
//        let randomAudio = Int.random(in: 0 ... 2)
//        
//        if randomAudio == 0 {
//            tigerEntity?.playAudio(tigerAudio!)
//        }else if randomAudio == 1{
//            tigerEntity?.playAudio(tigerAudio2!)
//        }else{
//            tigerEntity?.playAudio(combinedFootstepAudio!)
//            
//        }
//        
//        
//        switch direction{
//        case "forward":
////            ini maju kedepan. translation itu buat kasih tau kalo maju kedepan nambahin vector z nya 20
//            moveToLocation.translation = (tigerEntity.transform.translation) + simd_float3(x: 0, y: 0, z: 100)
//            movement = tigerEntity.move(to: moveToLocation, relativeTo: tigerEntity, duration: 5)
//            
//            print("gerak depan")
//            
////            nambahin animasi jalan kalo bisa wkwk
//        
//        case "back":
//            let rotateAngle = simd_quatf(angle: GLKMathDegreesToRadians(180), axis: SIMD3(x: 0, y: 1, z: 0))
////            tigerEntity?.setOrientation(rotateAngle, relativeTo: tigerEntity)
//            
//            var rotationTransform = tigerEntity?.transform
//            rotationTransform?.rotation = rotateAngle
//            movement = tigerEntity?.move(to: rotationTransform!, relativeTo: tigerEntity?.parent, duration: 5)
//            
////            moveToLocation.translation = (tigerEntity?.transform.translation)! + simd_float3(x: 0, y: 0, z: 100)
////            movement = tigerEntity?.move(to: moveToLocation, relativeTo: tigerEntity, duration: 5)
//            
//            print("gerak belakang")
//            
//        case "left":
//            let rotateAngle = simd_quatf(angle: GLKMathDegreesToRadians(90), axis: SIMD3(x: 0, y: 1, z: 0))
////            tigerEntity?.setOrientation(rotateAngle, relativeTo: tigerEntity)
//            
//            var rotationTransform = tigerEntity?.transform
//            rotationTransform?.rotation = rotateAngle
//            movement = tigerEntity?.move(to: rotationTransform!, relativeTo: tigerEntity?.parent, duration: 5)
//            
////            moveToLocation.translation = (tigerEntity?.transform.translation)! + simd_float3(x: 0, y: 0, z: 100)
////            movement = tigerEntity?.move(to: moveToLocation, relativeTo: tigerEntity, duration: 5)
//            
//            print("gerak kiri")
//            
//        case "right":
//            let rotateAngle = simd_quatf(angle: GLKMathDegreesToRadians(-90), axis: SIMD3(x: 0, y: 1, z: 0))
////            tigerEntity?.setOrientation(rotateAngle, relativeTo: tigerEntity)
//            
//            var rotationTransform = tigerEntity?.transform
//            rotationTransform?.rotation = rotateAngle
//            movement = tigerEntity?.move(to: rotationTransform!, relativeTo: tigerEntity?.parent, duration: 5)
//            
////            moveToLocation.translation = (tigerEntity?.transform.translation)! + simd_float3(x: 0, y: 0, z: 100)
////            movement = tigerEntity?.move(to: moveToLocation, relativeTo: tigerEntity, duration: 5)
//            
//            print("gerak kanan")
//        default:
//            print("Ga gerak mas")
//        }
//        
//        return movement
//    }
    static var tiger = Entity()
    var body: some View {
        
        RealityView { content in
            
            await placeTree(content, tree: "Maple Tree")
            await placeTree(content, tree: "Pohon Jauh")
            await placeTree(content, tree: "Semak Scene")
//            load tiger
//            let anchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2<Float>(0.6, 0.6)))
            if let tiger = try? await Entity(named: "Tiger Scene", in: realityKitContentBundle){
                JungleView.tiger = tiger
                content.add(tiger)
            }
            
            let x = Float.random(in: -5 ... 5)
            let z = Float.random(in: -5 ... 5)
            
            JungleView.tiger.setPosition([x, 0, z], relativeTo: JungleView.tiger)
//            anchor.addChild(tigerModel)
            
            let collisionShape = ShapeResource.generateSphere(radius: 0.5)
            let collisionComp = CollisionComponent(shapes: [collisionShape])
            
            JungleView.tiger.components.set(collisionComp)
            JungleView.tiger.components.set(InputTargetComponent(allowedInputTypes: .all))
//            anchor.generateCollisionShapes(recursive: true)
            
            if let entityAnimation = JungleView.tiger.availableAnimations.first{
    //            play animation
                JungleView.tiger.playAnimation(entityAnimation.repeat(), transitionDuration: 5, startsPaused: false)
            }
//            content.add(JungleView.tiger)
            await loadAmbient(content)
//            content.add(mapleTree)
        } update: { content in
            
        }
        .gesture(
            SpatialTapGesture()
                .targetedToEntity(JungleView.tiger)
//                .targetedToAnyEntity()
                .onEnded({ target in
                    print(target)
                })
        )
        .gesture(
            DragGesture()
//                .targetedToEntity(JungleView.tiger)
                .targetedToAnyEntity()
                .onChanged({ value in
                    JungleView.tiger.position = value.convert(value.location3D, from: .local, to: JungleView.tiger.parent!)
                })
        )
    }
}

#Preview {
    JungleView()
}

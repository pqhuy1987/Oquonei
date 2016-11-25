
//  Created by Devine Lu Linvega on 2015-11-09.
//  Copyright © 2015 XXIIVV. All rights reserved.

import SpriteKit
import Foundation

class Tile : SKSpriteNode
{
	var sprite:Types!
	var id:Int!
	var orientation:Orientation!
	var origin:CGPoint!
	
	init(sprite:Types,id:Int! = nil, position:CGPoint = CGPoint(x: 0,y: 0), size: CGSize)
	{
		var image:UIImage!
		var texture:SKTexture!
		
		if id != nil {
			let imageName = (orientation != nil) ? "\(sprite).\(id).\(orientation).png" : "\(sprite).\(id).png"
			if UIImage(named: imageName) != nil {
				image = UIImage(named: imageName)!
				texture = SKTexture(image: image!)
			}
		}
		else{
			texture = nil
		}
		
		super.init(texture: texture, color: SKColor.clear, size: size)
		
		self.sprite = sprite
		self.id = id
		self.position = position
		self.size = size
		
		origin = position
	}
	
	func updateSprite(_ id:Int)
	{
		self.id = id
		
		let imageName = "\(self.sprite!).\(self.id!).png"
		
		var image:UIImage!
		var texture:SKTexture!
		
		if UIImage(named: imageName) != nil {
			image = UIImage(named: imageName)!
			texture = SKTexture(image: image!)
		}
		else if id > 0 {
			print("!ERROR1 - Tile.unknown: \(imageName)")
		}
		self.texture = texture
	}
	
	func updateSpriteWithName(_ imageName:String)
	{
		var image:UIImage!
		var texture:SKTexture!
		
		if UIImage(named: imageName) != nil {
			image = UIImage(named: imageName)!
			texture = SKTexture(image: image!)
		}
		else if id > 0 {
			print("!ERROR2 - Tile.unknown: \(imageName)")
		}
		
		self.texture = texture
	}
	
	override func onRoomEnter()
	{
		let offset = randomBetweenNumbers(0, secondNum: 10)
		self.alpha = 0
		self.position = CGPoint(x: position.x, y: position.y - offset)
		
		let action_move = SKAction.move(to: origin, duration: 0.25)
		let action_fade = SKAction.fadeAlpha(to: 1, duration:0.5)
		let action_group = SKAction.group([action_move,action_fade])
		
		action_move.timingMode = .easeInEaseOut
		
		self.run(action_group)
	}
	
	override func onRoomTeleportOut()
	{
		let offset = randomBetweenNumbers(0, secondNum: templates.floor.height * 0.5)
		
		let targetPosition = CGPoint(x: position.x, y: position.y - offset)
		let action_move = SKAction.move(to: targetPosition, duration: 3)
		action_move.timingMode = .easeIn
		
		self.run(action_move, completion: { })
	}
	
	override func onRoomTeleportIn()
	{
		let action_move = SKAction.move(to: origin, duration: 2)
		action_move.timingMode = .easeOut
		
		self.run(action_move, completion: { })
	}

	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}

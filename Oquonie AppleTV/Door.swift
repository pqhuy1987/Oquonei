
//  Created by Devine Lu Linvega on 2015-11-09.
//  Copyright © 2015 XXIIVV. All rights reserved.

import SpriteKit
import Foundation

class Door : Event
{
	var destination:Int!
	var to_x:Int!
	var to_y:Int!
	var requirement:Personas!
	
	init(x:Int,y:Int,requirement:Personas! = nil,room:Int,to_x:Int,to_y:Int)
	{
		super.init(x: x, y: y)
		
		self.x = x
		self.y = y
		self.destination = room
		self.to_x = to_x
		self.to_y = to_y
		self.requirement = requirement
	}
	
	override func collide()
	{
		if self.requirement != nil { collide_gate() }
		else{ collide_normal() }
		player.isMoving = false
	}
	
	func collide_normal()
	{
		print("> WARP - \(destination)")
		player.warp(self.destination,to_x:self.to_x,to_y:self.to_y)
	}
	
	override func bind(_ node:Tile)
	{
		target = node
		if self.requirement != nil {
			if requirement == player.persona {
				target.updateSpriteWithName("wall.gate.\(requirement!).open.png")
			}
			else{
				target.updateSpriteWithName("wall.gate.\(requirement!).close.png")
			}
		}
	}
	
	override func onPlayerTransformed()
	{
		if self.requirement != nil {
			if requirement == player.persona {
				target.updateSpriteWithName("wall.gate.\(requirement!).open.png")
			}
			else{
				target.updateSpriteWithName("wall.gate.\(requirement!).close.png")
			}
		}
	}
	
	func collide_gate()
	{
		if player.persona != self.requirement {
			dialog.showModal(dialogs.doorRequiresPersona("\(requirement!)"),eventName: "owl")
		}
		else{
			player.warp(self.destination,to_x:self.to_x,to_y:self.to_y)
		}
	}

	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}

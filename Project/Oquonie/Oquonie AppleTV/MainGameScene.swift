
//  Created by Devine Lu Linvega on 2015-11-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import SpriteKit

class MainGameScene: SKScene
{
	var viewController: MainViewController!
	var time:Timer!

    override func didMove(to view: SKView)
	{
		
    }
	
	func start()
	{
		let scale:CGFloat = ( view!.frame.height > view!.frame.width) ? self.view!.frame.width/760 : self.view!.frame.width/1600
		
		templates.floor = CGSize(width: 200 * scale, height: 141 * scale)
		templates.step = CGSize(width: 200 * scale, height: 141 * scale)
		templates.wall = CGSize(width: 200 * scale, height: 281 * scale)
		templates.player = CGSize(width: 200 * scale, height: 281 * scale)
		templates.spell = CGSize(width: 120 * scale, height: 120 * scale)
		templates.dialog = CGSize(width: 640 * scale, height: 390 * scale)
		
		//
			
		time = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(SKNode._fixedUpdate), userInfo: nil, repeats: true)
		templates.screen = self.frame
		templates.stage = CGPoint(x: self.frame.midX, y: self.frame.midY - (0.5 * templates.wall.height))
		
		_addStage()
		_addPlayer()
		_addSpellbook()
		_addDialog()
		_addParalax()
		_addOverlay()
		_addFx()
		_AddAudio()
		
		stage.enter(loadGame())
	}
	
	func _AddAudio()
	{
		self.addChild(audio)
	}
	
	func _addPlayer()
	{
		player = Player()
		player.persona = .necomedre
		player.position = CGPoint(x: 0, y: 0)
		player.zPosition = stage.eventDepthAtPosition(0, y: 0)
		stage.events_root.addChild(player)
		
		player.appear()
	}
	
	func _addStage()
	{
		stage.position = templates.stage
		stage.gameScene = self
		addChild(stage)
	}
	
	func _addSpellbook()
	{
		spellbook.position = CGPoint(x: self.frame.midX, y: self.frame.height - templates.spell.height)
		spellbook.zPosition = 1000
		addChild(spellbook)
	}
	
	func _addDialog()
	{
		dialog.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
		dialog.zPosition = 9000
		self.addChild(dialog)
	}
	
	func _addParalax()
	{
		let parallaxSize:CGFloat = ( view!.frame.height > view!.frame.width) ? self.frame.size.width : self.frame.size.height
		
		parallaxBack = SKSpriteNode(texture: textureWithName("parallax.1.png"), color: SKColor.red, size: CGSize(width: parallaxSize, height: parallaxSize))
		parallaxBack.zPosition = -900
		parallaxBack.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
		self.addChild(parallaxBack)
		parallaxBack.alpha = 0
		
		parallaxFront = SKSpriteNode(texture: textureWithName("parallax.2.png"), color: SKColor.red, size: CGSize(width: parallaxSize, height: parallaxSize))
		parallaxFront.zPosition = 9000
		parallaxFront.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
		self.addChild(parallaxFront)
		parallaxFront.alpha = 0
		
		background = SKSpriteNode(color: SKColor(white: 0.9, alpha: 1), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
		background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
		background.zPosition = -1000
		self.addChild(background)
	}
	
	func _addOverlay()
	{
		overlay = SKSpriteNode(color: SKColor.white, size: self.size)
		overlay.position = CGPoint(x: self.frame.midX,y: self.frame.midY)
		overlay.zPosition = 1500
		overlay_image = SKSpriteNode(texture: nil, color: SKColor.blue, size: CGSize(width: overlay.size.width, height: self.size.width))
		overlay_image.position = CGPoint(x: 0,y: 0)
		overlay_image.zPosition = 1600
		overlay.addChild(overlay_image)
		overlay.alpha = 0
		self.addChild(overlay)
	}
	
	func _addFx()
	{
		fx = SKSpriteNode(color: SKColor.red, size: frame.size)
		fx.position = CGPoint(x: self.frame.midX,y: self.frame.midY)
		fx.zPosition = 1200
		fx.alpha = 0
		self.addChild(fx)
	}

    override func update(_ currentTime: TimeInterval)
	{
		super.update(currentTime)
		stage._fixedUpdate()
	}
	
	override func _fixedUpdate()
	{
		
	}
}

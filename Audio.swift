
//  Created by Devine Lu Linvega on 2015-11-30.
//  Copyright © 2015 XXIIVV. All rights reserved

import SpriteKit
import AVFoundation
import Foundation

class Audio : SKNode
{
	var effects = SKNode()
	var ambient = AVAudioPlayer()
	
	override init()
	{
		super.init()
		
		self.addChild(effects)
	}
	
	func play(_ route:soundType,name:String!)
	{
		print("> PLAY - \(route).\(name)")
		effects.run(SKAction.playSoundFileNamed("\(route).\(name!).wav", waitForCompletion: false))
	}
	
	var current:Soundtrack!
	
	func play_ambient(_ sound:Soundtrack)
	{
		print(" AUDIO - Ambient: \(sound)")
		var soundName = "\(sound)"
		
		if current == sound { return }
		
		if "\(sound)" == "lobby" {
			if player.hasPillar(pillar_nemedique) { soundName = "lobby.2"}
			else if player.isCompleted == true { soundName = "lobby.3"}
			else { soundName = "lobby.1"}
		}
		
		let coinSound = URL(fileURLWithPath: Bundle.main.path(forResource: "ambient.\(soundName)", ofType: "mp3")!)
		do{
			ambient = try AVAudioPlayer(contentsOf:coinSound)
			ambient.prepareToPlay()
			ambient.play()
			ambient.numberOfLoops = -1
		}catch {
			print("Error getting the audio file")
		}
		current = sound
		ambient.volume = (player.isListening == true) ? 1 : 0
	}
	
	func mute()
	{
		player.isListening = false
		ambient.volume = 0
	}
	
	func unMute()
	{
		player.isListening = true
		ambient.volume = 1
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

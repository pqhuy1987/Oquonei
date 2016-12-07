
//  Created by Devine Lu Linvega on 2015-11-09.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class Room
{
	var floors:Array<Int> = []
	var walls:Array<Int> = []
	var steps:Array<Int> = []
	var audio:Soundtrack = Soundtrack.office
	var theme:Theme = Theme.white
	var events:Array<Event> = []
	
	init()
	{
		
	}
	
	func addEvent(_ event:Event)
	{
		events.append(event)
	}
}

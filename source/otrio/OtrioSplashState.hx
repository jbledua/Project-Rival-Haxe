package otrio;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class OtrioSplashState extends FlxState
{
	override public function create()
	{
		// create a text object
		var _text:FlxText = new FlxText(0, 0, 300, "Otrio");
		_text.autoSize = true;
		_text.setFormat(null, 64, 0xFFFFFFFF, "center");
		_text.screenCenter();

		// add the text to the state
		add(_text);

		// Press Space to start
		var _start = new FlxText(0, 0, 300, "Press Space to start");
		_start.setFormat(null, 20, 0xFFFFFFFF, "center");
		_start.y = FlxG.height - _start.height - 50;
		_start.screenCenter(FlxAxes.X);

		// Pulse Color
		FlxTween.color(_start, 1, FlxColor.WHITE, FlxColor.RED, {type: PINGPONG});

		// add the text to the state
		add(_start);

		super.create();
	} // End Create Function

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Press Space to start
		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.switchState(new OtrioPlayState());
		}// End if
		
	} // End Update Function
}

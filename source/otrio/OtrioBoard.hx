package otrio;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSignal;
import haxe.Log;

class OtrioBoard extends FlxSprite
{
	private var spawnComplete:FlxSignal;

	// Constructor
	public function new(?_spawnComplete:FlxSignal = null)
	{
		super(0, 0);

		// Set the spawn complete callback
		spawnComplete = _spawnComplete;

		makeGraphic(300, 300, FlxColor.WHITE);

		kill();
	} // End of constructor

	// Spawn the board
	public function spawn():Void
	{
		Log.trace("Spawning board...");

		// Revive the board
		revive();

		// Play the spaning animation board
		FlxTween.linearMotion(this, 0, 0, FlxG.width / 2 - this.width / 2, FlxG.height / 2 - this.height / 2, 1, true, {
			type: FlxTweenType.ONESHOT,
			onUpdate: null,
			onComplete: onSpawnComplete
		});
	} // End of spawn function

	public function onSpawnComplete(_tween:FlxTween):Void
	{
		// If there is a callback, call it
		if (onSpawnComplete != null)
		{
			Log.trace("Board Spawned");
			spawnComplete.dispatch();
		}
	} // End of onSpawnComplete function
} // End of OtrioBoard class

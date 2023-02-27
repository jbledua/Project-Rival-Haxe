package otrio;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSignal;
import haxe.Log;

class OtrioPlayer extends FlxSprite
{
	private var spawnComplete:FlxSignal;
	private var playerNumber:Int = 0;

	public function new(_playerNumber:Int = 0, ?_spawnComplete:FlxSignal = null)
	{
		super(0, 0);

		playerNumber = _playerNumber;

		// Set the spawn complete callback
		spawnComplete = _spawnComplete;

		makeGraphic(50, 50, FlxColor.RED);

		kill();
	}

	// // Spawn the board
	public function spawn():Void // override public function revive()
	{
		// Revive the board
		// revive();

		Log.trace("Spawning Player " + playerNumber);

		revive();

		// Play the spaning animation board
		var _tween:FlxTween = FlxTween.linearMotion(this, 0, 0, FlxG.width / 2 - this.width / 2, FlxG.height / 2 - this.height / 2, 1, true, {
			type: FlxTweenType.ONESHOT,
			onUpdate: null,
			onComplete: onSpawnComplete
		});
	}

	// override public function revive()
	// {
	// 	// Play the spanwing player animation
	// 	FlxTween.linearMotion(this, 0, 0, FlxG.width / 2 - this.width / 2, FlxG.height / 2 - this.height / 2, 1, true, {
	// 		type: FlxTweenType.ONESHOT,
	// 		onComplete: onSpawnComplete
	// 	});
	// 	super.revive();
	// }

	public function onSpawnComplete(_tween:FlxTween)
	{
		if (spawnComplete != null)
		{
			Log.trace("Player " + playerNumber + " spawned");
			spawnComplete.dispatch();
		}
	}
}

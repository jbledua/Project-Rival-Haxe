package otrio;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSignal;
import haxe.Log;
import js.html.AbortController;

class OtrioPlayer extends FlxSprite
{
	public static inline var VERTICAL:Int = 0;
	public static inline var HORIZONTAL:Int = 1;

	private var type:Int = OtrioPlayer.VERTICAL;

	private var spawnComplete:FlxSignal;
	private var playerNumber:Int = 0;

	private var start:FlxPoint;
	private var end:FlxPoint;

	private var colorLight:FlxColor = FlxColor.fromHSB(0, 0, 1, 1);
	private var colorPrimary:FlxColor = FlxColor.fromHSB(0, 0, 0.75, 1);
	private var colorDark:FlxColor = FlxColor.fromHSB(0, 0, 0.5, 1);
	private var colorBackground:FlxColor = FlxColor.fromHSB(0, 0, 0.25, 1);

	public function new(_playerNumber:Int = 0, _type:Int = OtrioPlayer.VERTICAL, _start:FlxPoint = null)
	{
		// Set the player number
		playerNumber = _playerNumber;

		// Set the player type
		type = _type;

		// Create temp variables for the width and height
		var _width:Int = 10;
		var _height:Int = 10;

		switch _type
		{
			case OtrioPlayer.VERTICAL:
				_width = 100;
				_height = 300;
			case OtrioPlayer.HORIZONTAL:
				_width = 300;
				_height = 100;
			default:
				_width = 100;
				_height = 300;
		}

		// Set the width and height
		this.width = _width;
		this.height = _height;

		// Set the start  points
		if (_start == null)
			_start = new FlxPoint(0, 0);

		// Set Start Point
		setStart(_start);

		super(this.start.x, this.start.y);

		makeGraphic(_width, _height, this.colorBackground);

		kill();
	}

	// Set and get start point
	public function setStart(_start:FlxPoint):Void
		this.start = new FlxPoint(_start.x - Std.int(width / 2), _start.y - Std.int(height / 2));

	// start = new FlxPoint(_start.x - Std.int(width / 2), _start.y - Std.int(height / 2));

	public function getStart():FlxPoint
		return start;

	// Set and get the end point
	public function setEnd(_end:FlxPoint):Void
		end = new FlxPoint(_end.x - Std.int(width / 2), _end.y - Std.int(height / 2));

	// end = new FlxPoint(_end.x - this.width / 2, _end.y - this.height / 2);

	public function getEnd():FlxPoint
		return end;

	// Set and get the complete signal
	public function setSpawnComplete(_spawnComplete:FlxSignal):Void
		spawnComplete = _spawnComplete;

	public function getSpawnComplete():FlxSignal
		return spawnComplete;

	// // Spawn the board
	public function spawn(?_duration:Float = 0.5):Void // override public function revive()
	{
		Log.trace("Spawning Player " + playerNumber);

		revive();

		// FlxTween.tween(this.scale, {x: 4, y: 4}, 2, {type: FlxTween.ONESHOT});

		// // Play the spaning animation board
		FlxTween.linearMotion(this, start.x, start.y, end.x, end.y, _duration, true, {
			type: FlxTweenType.ONESHOT,
			onUpdate: null,
			onComplete: onSpawnComplete
		});
	}

	public function onSpawnComplete(_tween:FlxTween)
	{
		Log.trace("Player " + playerNumber + " spawned");

		if (spawnComplete != null)
		{
			spawnComplete.dispatch();
		}
	}
}

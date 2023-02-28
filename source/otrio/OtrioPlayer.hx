package otrio;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSignal;
import haxe.Log;

class OtrioPlayer extends FlxSprite
{
	// Static Constants
	public static inline var VERTICAL:Int = 0;
	public static inline var HORIZONTAL:Int = 1;

	// Global Variables (from PlayState)
	private var board:OtrioBoard;
	private var players:FlxTypedGroup<OtrioPlayer>;
	private var slots:FlxTypedGroup<OtrioSlot>;
	private var pieces:FlxTypedGroup<OtrioPiece>;

	// Player Local Variables
	private var type:Int = OtrioPlayer.VERTICAL;
	private var playerNumber:Int = 0;

	private var playerSlots:FlxTypedGroup<OtrioSlot>;

	private var colorLight:FlxColor = FlxColor.fromHSB(0, 0, 1, 1);
	private var colorPrimary:FlxColor = FlxColor.fromHSB(0, 0, 0.75, 1);
	private var colorDark:FlxColor = FlxColor.fromHSB(0, 0, 0.5, 1);
	private var colorBackground:FlxColor = FlxColor.fromHSB(0, 0, 0.25, 1);

	// Spawning Variables
	private var start:FlxPoint;
	private var end:FlxPoint;

	// Signals
	private var spawnComplete:FlxSignal;

	//--------------------------------------------------------------------------
	// Getters and Setters
	//--------------------------------------------------------------------------
	// Used to pass global Peices from playstate
	public function setPieces(_pieces:FlxTypedGroup<OtrioPiece>)
		this.pieces = _pieces;

	// Used to pass global Slots from playstate
	public function setSlots(_slots:FlxTypedGroup<OtrioSlot>)
		this.slots = _slots;

	// Set and get start point
	public function setStart(_start:FlxPoint):Void
		this.start = new FlxPoint(_start.x - Std.int(width / 2), _start.y - Std.int(height / 2));

	// start = new FlxPoint(_start.x - Std.int(width / 2), _start.y - Std.int(height / 2));

	public function getStart():FlxPoint
		return start;

	// Set and get the end point
	public function setEnd(_end:FlxPoint):Void
		end = new FlxPoint(_end.x - Std.int(width / 2), _end.y - Std.int(height / 2));

	public function getEnd():FlxPoint
		return end;

	public function setColors(_colorLight:FlxColor, _colorPrimary:FlxColor, _colorDark:FlxColor, _colorBackground:FlxColor)
	{
		this.colorLight = _colorLight;
		this.colorPrimary = _colorPrimary;
		this.colorDark = _colorDark;
		this.colorBackground = _colorBackground;

		FlxTween.color(this, 0.5, FlxColor.WHITE, colorBackground, {
			type: FlxTweenType.ONESHOT,
		});
	}

	// Set and get the complete signal
	public function setSpawnComplete(_spawnComplete:FlxSignal):Void
		spawnComplete = _spawnComplete;

	public function getSpawnComplete():FlxSignal
		return spawnComplete;

	public function getCenter()
	{
		// Returns the center point of the player
		return new FlxPoint(this.x + Std.int(this.width / 2), this.y + Std.int(this.height / 2));
	}

	//--------------------------------------------------------------------------
	// Constructor and Init
	//--------------------------------------------------------------------------

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

		// Log that the board is spawning
		Log.trace("Creating player " + this.playerNumber + "...");
	}

	// Create Slots
	public function createSlots():Void
	{
		// Log that the board is spawning
		Log.trace("Creating player " + this.playerNumber + " slots...");

		// This function could be impoved using for loops but it works for now

		this.playerSlots = new FlxTypedGroup<OtrioSlot>(3); // Instantiate Slots

		// // Create the slots
		for (i in 0...playerSlots.maxSize)
		{
			// Create the slot
			var _slot:OtrioSlot = new OtrioSlot();

			_slot.setPieces(this.pieces);

			// Add the slot to the slots group
			this.playerSlots.add(_slot);
		}
	}

	//--------------------------------------------------------------------------
	// Spawn Functions
	//--------------------------------------------------------------------------
	// Spawn the board
	public function spawn(?_duration:Float = 0.5):Void // override public function revive()
	{
		Log.trace("Player " + playerNumber + " spawning...");

		revive();

		// Play the spaning animation board
		FlxTween.linearMotion(this, start.x, start.y, end.x, end.y, _duration, true, {
			type: FlxTweenType.ONESHOT,
			onUpdate: null,
			onComplete: onSpawnComplete
		});
	}

	// Spawn Slots
	public function spawnSlots():Void
	{ // Log that the board is spawning
		Log.trace("Spawning player " + this.playerNumber + " slots...");

		// Move Slots into Place
		// Check if Vertical or Horizontal Player
		switch this.type
		{
			case OtrioPlayer.VERTICAL: // Vertical Player
				// // Top Slot
				this.playerSlots.members[0].screenCenter();
				this.playerSlots.members[0].y -= this.height / 3;
				this.playerSlots.members[0].x = this.getCenter().x - this.playerSlots.members[0].width / 2;
				this.playerSlots.members[0].spawn();

				// // Middle Slot

				this.playerSlots.members[1].screenCenter();
				this.playerSlots.members[1].x = this.getCenter().x - this.playerSlots.members[1].width / 2;
				this.playerSlots.members[1].spawn();

				// Bottom Slot
				this.playerSlots.members[2].screenCenter();
				this.playerSlots.members[2].y += this.height / 3;
				this.playerSlots.members[2].x = this.getCenter().x - this.playerSlots.members[2].width / 2;
				this.playerSlots.members[2].spawn();

			case OtrioPlayer.HORIZONTAL: // Horizontal Player
				// // Left Slot
				this.playerSlots.members[0].screenCenter();
				this.playerSlots.members[0].x -= this.width / 3;
				this.playerSlots.members[0].y = this.getCenter().y - this.playerSlots.members[0].height / 2;
				this.playerSlots.members[0].spawn();

				// Right Slot
				this.playerSlots.members[1].screenCenter();
				this.playerSlots.members[1].y = this.getCenter().y - this.playerSlots.members[1].height / 2;
				this.playerSlots.members[1].spawn();
				// this.setColors

				// Right Slot
				this.playerSlots.members[2].screenCenter();
				this.playerSlots.members[2].x += this.width / 3;
				this.playerSlots.members[2].y = this.getCenter().y - this.playerSlots.members[2].height / 2;
				this.playerSlots.members[2].spawn();
		} // End Switch

		if (this.slots != null)
		{
			// Instantiate Slots
			this.slots.add(this.playerSlots.members[0]);
			this.slots.add(this.playerSlots.members[1]);
			this.slots.add(this.playerSlots.members[2]);
		}
		else
		{
			Log.trace("Slots is null");
		}
	}

	//--------------------------------------------------------------------------
	// Event Handlers
	//--------------------------------------------------------------------------

	public function onSpawnComplete(_tween:FlxTween)
	{
		// Log.trace("Player " + playerNumber + " spawned");

		if (spawnComplete != null)
		{
			spawnComplete.dispatch();
		}
	}
}

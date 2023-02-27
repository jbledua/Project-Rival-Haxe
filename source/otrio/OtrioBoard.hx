package otrio;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSignal;
import haxe.Log;

class OtrioBoard extends FlxSprite
{
	// Global Variables
	private var board:OtrioBoard;
	private var players:FlxTypedGroup<OtrioPlayer>;
	private var slots:FlxTypedGroup<OtrioSlot>;
	private var pieces:FlxTypedGroup<OtrioPiece>;

	// Local Variables
	private var boardSlots:FlxTypedGroup<OtrioSlot>;

	// Animation Variables
	private var start:FlxPoint;
	private var end:FlxPoint;

	private var spawnComplete:FlxSignal;

	// Constructor
	public function new(?_start:FlxPoint = null, ?_spawnComplete:FlxSignal = null)
	{
		// Create temp variables for the width and height
		var _width:Int = 300;
		var _height:Int = 300;

		// Set the width and height
		this.width = _width;
		this.height = _height;

		// Set the spawn complete callback
		spawnComplete = _spawnComplete;

		// Set the start  points
		if (_start == null)
			_start = new FlxPoint(0, 0);

		// Set Start Point
		setStart(_start);

		super(start.x, start.y);

		makeGraphic(_width, _height, FlxColor.WHITE);

		kill();
	} // End of constructor

	// Spawn the board
	public function spawn(?_duration:Float = 0.5):Void
	{
		// Log that the board is spawning
		Log.trace("Spawning board...");

		// Revive the board
		revive();

		this.scale.x = 0;
		this.scale.y = 0;

		FlxTween.tween(this, {
			x: end.x,
			y: end.y,
			"scale.x": 1,
			"scale.y": 1
		}, _duration, {onComplete: onSpawnComplete});
	} // End of spawn function

	// Set and get start point
	public function setStart(_start:FlxPoint):Void
		start = new FlxPoint(_start.x - Std.int(this.width / 2), _start.y - Std.int(this.height / 2));

	// start = new FlxPoint(_start.x - Std.int(width / 2), _start.y - Std.int(height / 2));

	public function getStart():FlxPoint
		return start;

	// Set and get the end point
	public function setEnd(_end:FlxPoint):Void
		end = new FlxPoint(_end.x - Std.int(width / 2), _end.y - Std.int(height / 2));

	// end = new FlxPoint(_end.x - this.width / 2, _end.y - this.height / 2);

	public function getEnd():FlxPoint
		return end;

	public function onSpawnComplete(_tween:FlxTween):Void
	{
		// Log that the board has spawned
		Log.trace("Board Spawned");

		// // If there is a callback, call it
		if (spawnComplete != null)
		{
			spawnComplete.dispatch();
		}
	} // End of onSpawnComplete function

	public function createSlots()
	{
		// This function could be impoved using for loops but it works for now

		this.boardSlots = new FlxTypedGroup<OtrioSlot>(9); // Instantiate Slots

		this.boardSlots.add(new OtrioSlot());
		this.boardSlots.add(new OtrioSlot());
		this.boardSlots.add(new OtrioSlot());
		this.boardSlots.add(new OtrioSlot());
		this.boardSlots.add(new OtrioSlot());
		this.boardSlots.add(new OtrioSlot());
		this.boardSlots.add(new OtrioSlot());
		this.boardSlots.add(new OtrioSlot());
		this.boardSlots.add(new OtrioSlot());

		// // Set Pieces
		// // Top Row
		// this.boardSlots.members[0].setPieces(this.pieces);
		// this.boardSlots.members[1].setPieces(this.pieces);
		// this.boardSlots.members[2].setPieces(this.pieces);

		// // Middle Row
		// this.boardSlots.members[3].setPieces(this.pieces);
		// this.boardSlots.members[4].setPieces(this.pieces);
		// this.boardSlots.members[5].setPieces(this.pieces);

		// // Bottom Row
		// this.boardSlots.members[6].setPieces(this.pieces);
		// this.boardSlots.members[7].setPieces(this.pieces);
		// this.boardSlots.members[8].setPieces(this.pieces);

		// // Create Slots
		// // Top Row
		// this.boardSlots.members[0].create();
		// this.boardSlots.members[1].create();
		// this.boardSlots.members[2].create();

		// // Middle Row
		// this.boardSlots.members[3].create();
		// this.boardSlots.members[4].create();
		// this.boardSlots.members[5].create();

		// // Bottom Row
		// this.boardSlots.members[6].create();
		// this.boardSlots.members[7].create();
		// this.boardSlots.members[8].create();

		// Move Slots into Place
		// Top Row
		this.boardSlots.members[0].screenCenter();
		this.boardSlots.members[0].x -= this.width / 3;
		this.boardSlots.members[0].y -= this.height / 3;
		this.boardSlots.members[1].screenCenter();
		this.boardSlots.members[1].y -= this.height / 3;
		this.boardSlots.members[2].screenCenter();
		this.boardSlots.members[2].x += this.width / 3;
		this.boardSlots.members[2].y -= this.height / 3;

		// Middle Row
		this.boardSlots.members[3].screenCenter();
		this.boardSlots.members[3].x -= this.width / 3;
		this.boardSlots.members[4].screenCenter();
		this.boardSlots.members[5].screenCenter();
		this.boardSlots.members[5].x += this.width / 3;

		// Bottom Row
		this.boardSlots.members[6].screenCenter();
		this.boardSlots.members[6].x -= this.width / 3;
		this.boardSlots.members[6].y += this.height / 3;
		this.boardSlots.members[7].screenCenter();
		this.boardSlots.members[7].y += this.height / 3;
		this.boardSlots.members[8].screenCenter();
		this.boardSlots.members[8].x += this.width / 3;
		this.boardSlots.members[8].y += this.height / 3;

		if (this.slots != null)
		{
			// Instantiate Slots
			this.slots.add(this.boardSlots.members[0]);
			this.slots.add(this.boardSlots.members[1]);
			this.slots.add(this.boardSlots.members[2]);
			this.slots.add(this.boardSlots.members[3]);
			this.slots.add(this.boardSlots.members[4]);
			this.slots.add(this.boardSlots.members[5]);
			this.slots.add(this.boardSlots.members[6]);
			this.slots.add(this.boardSlots.members[7]);
			this.slots.add(this.boardSlots.members[8]);
		}
		else
		{
			Log.trace("Slots is null");
		}
	} // End createSlots

	public function setPieces(_pieces:FlxTypedGroup<OtrioPiece>)
	{
		this.pieces = _pieces;
	}

	public function setSlots(_slots:FlxTypedGroup<OtrioSlot>)
	{
		this.slots = _slots;
	}
} // End of OtrioBoard class

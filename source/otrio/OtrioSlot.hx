package otrio;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import haxe.Log;

class OtrioSlot extends FlxSprite
{
	// Global Variables (from PlayState)
	private var board:OtrioBoard;
	private var players:FlxTypedGroup<OtrioPlayer>;
	private var slots:FlxTypedGroup<OtrioSlot>;
	private var pieces:FlxTypedGroup<OtrioPiece>;

	// Local Pieces
	private var parent:OtrioPlayer;
	private var slotPieces:FlxTypedGroup<OtrioPiece>; // Local Group of Pieces that are created by the slot

	private var colorLight:FlxColor = FlxColor.fromHSB(0, 0, 1, 1);
	private var colorPrimary:FlxColor = FlxColor.fromHSB(0, 0, 0.75, 1);
	private var colorDark:FlxColor = FlxColor.fromHSB(0, 0, 0.5, 1);
	private var colorBackground:FlxColor = FlxColor.fromHSB(0, 0, 0.25, 1);

	//-------------------------------------------------------------------------
	// Getters and Setters
	//-------------------------------------------------------------------------

	public function setPieces(_pieces:FlxTypedGroup<OtrioPiece>)
		this.pieces = _pieces;

	// Used to pass global Slots from playstate
	public function setSlots(_slots:FlxTypedGroup<OtrioSlot>)
		this.slots = _slots;

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

	//-------------------------------------------------------------------------
	// Constructor and Initialization
	//-------------------------------------------------------------------------

	public function new()
	{
		super(0, 0);

		// The default dimensions
		var _width = 50;
		var _height = 50;

		// Replace with Board Graphic
		// makeGraphic(_width, _height, FlxColor.TRANSPARENT);

		// FOR TESTING: Make a cyan square
		makeGraphic(_width, _height, FlxColor.CYAN);

		kill();
	} // end constructor

	// Spawn
	public function spawn(?_parent:OtrioPlayer)
	{
		revive();

		Log.trace("Slot Spawned at " + x + ", " + y);

		// Set the parent
		// this.parent = _parent;

		// Set the color
		// this.color = parent.color;

		// Create the local group of pieces
		// slotPieces = new FlxTypedGroup<OtrioPiece>();

		// Add the slot to the board
		// board.add(this);
	}
}

package otrio;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxSignal;
import flixel.util.FlxTimer;
import haxe.Log;
import js.html.EventListener;

class OtrioPlayState extends FlxState
{
	private var board:OtrioBoard;
	private var players:FlxTypedGroup<OtrioPlayer>;
	private var slots:FlxTypedGroup<OtrioSlot>;
	private var pieces:FlxTypedGroup<OtrioPiece>;

	private var spawnNextPlayer:FlxSignal;
	private var spawnSlots:FlxSignal;
	private var spawnNextPiece:FlxSignal;
	private var gameReady:FlxSignal;

	// private var boardSpawned:FlxSignal;
	// private var allPlayersSpawned:FlxSignal;

	override public function create():Void
	{
		// Init game objects
		createGame();

		// Start game
		newGame();
	} // End of create function

	// Create Game objects
	public function createGame():Void
	{
		// Create signals
		spawnNextPlayer = new FlxSignal();
		spawnNextPlayer.add(onSpawnNextPlayer);

		spawnSlots = new FlxSignal();
		spawnSlots.add(onSpawnSlots);

		gameReady = new FlxSignal();
		gameReady.add(onGameReady);

		this.pieces = new FlxTypedGroup<OtrioPiece>(36); // Max of 36 Pieces (12 Per Player in 4v4 - 14 Per Player in 2v2)
		this.slots = new FlxTypedGroup<OtrioSlot>(21); // Max of 21 Slots (3 per Player and 9 in the Board)

		// Create the board
		createBoard();

		// Create the players
		createPlayers();
	} // End of startGame function.

	public function createBoard():Void
	{
		var _screenCenter:FlxPoint = new FlxPoint(FlxG.width / 2, FlxG.height / 2);

		// Create the board
		board = new OtrioBoard(_screenCenter, spawnNextPlayer);

		board.setEnd(_screenCenter);
		board.setPieces(this.pieces); // To be used for checking overlap
		board.setSlots(this.slots); // To be used for checking overlap

		board.createSlots();
	} // End of createBoard function.

	public function createPlayers(_playerCount:Int = 2):Void
	{
		players = new FlxTypedGroup<OtrioPlayer>(_playerCount);

		var _startPositions:Array<FlxPoint> = [
			new FlxPoint(FlxG.width / 2, FlxG.height / 2),
			new FlxPoint(FlxG.width / 2, FlxG.height / 2),
			new FlxPoint(FlxG.width / 2, FlxG.height / 2),
			new FlxPoint(FlxG.width / 2, FlxG.height / 2)
		];

		var _endPositions:Array<FlxPoint> = [
			new FlxPoint(FlxG.width / 2 - 150 - 50, FlxG.height / 2),
			new FlxPoint(FlxG.width / 2 + 150 + 50, FlxG.height / 2),
			new FlxPoint(FlxG.width / 2, FlxG.height / 2 - 150 - 50),
			new FlxPoint(FlxG.width / 2, FlxG.height / 2 + 150 + 50)
		];

		var _types:Array<Int> = [
			OtrioPlayer.VERTICAL,
			OtrioPlayer.VERTICAL,
			OtrioPlayer.HORIZONTAL,
			OtrioPlayer.HORIZONTAL
		];

		for (i in 0..._playerCount)
		{
			var _player:OtrioPlayer = new OtrioPlayer(i, _types[i], _startPositions[i]);

			_player.setEnd(_endPositions[i]);

			if (i < _playerCount - 1)
				_player.setSpawnComplete(spawnNextPlayer);
			else
				_player.setSpawnComplete(gameReady);

			this.players.add(_player);
		}
	} // End of createPlayer function.

	// Start Game
	public function newGame():Void
	{
		add(players);
		add(board);

		// Spawn the board
		board.spawn();
	} // End of startGame function.

	private function onSpawnNextPlayer():Void
	{
		var player:OtrioPlayer = players.getFirstDead();

		// Check if there are any players left to spawn
		if (player != null)
			player.spawn(0.25);
		else
			Log.trace("No more players to spawn.");
	} // End of spawnPlayer function.

	// Spawn next slot
	public function onSpawnSlots():Void
	{
		// Spawn the next slot
		Log.trace("Spawn slot");
	} // End of spawnNextSlot function.

	// On game ready
	public function onGameReady():Void
	{
		// For testing: Draw lines the board
		this.drawBoard();

		Log.trace("Game Ready");
	} // End of onGameReady function.

	public function drawBoard()
	{
		// Center Horizontal
		var _line1:FlxSprite = new FlxSprite();
		_line1.makeGraphic(250, 5, FlxColor.BLACK);
		_line1.screenCenter();
		_line1.y = _line1.y + 50;
		add(_line1);

		var _line2:FlxSprite = new FlxSprite();
		_line2.makeGraphic(250, 5, FlxColor.BLACK);
		_line2.screenCenter();
		_line2.y = _line2.y - 50;
		add(_line2);

		var _line3:FlxSprite = new FlxSprite();
		_line3.makeGraphic(5, 250, FlxColor.BLACK);
		_line3.screenCenter();
		_line3.x = _line3.x + 50;
		add(_line3);

		var _line4:FlxSprite = new FlxSprite();
		_line4.makeGraphic(5, 250, FlxColor.BLACK);
		_line4.screenCenter();
		_line4.x = _line4.x - 50;
		add(_line4);
	} // End drawBoard
} // End of OtrioPlayState class.

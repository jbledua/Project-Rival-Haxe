package otrio;

import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxSignal;
import haxe.Log;
import js.html.EventListener;

class OtrioPlayState extends FlxState
{
	private var board:OtrioBoard;
	private var boardSpawned:FlxSignal;

	private var players:FlxTypedGroup<OtrioPlayer>;
	private var spawnNextPlayer:FlxSignal;
	private var allPlayersSpawned:FlxSignal;

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
		// Create the board
		createBoard();

		// Create the players
		createPlayers();

		add(board);
		add(players);
	} // End of startGame function.

	public function createBoard():Void
	{
		boardSpawned = new FlxSignal();
		boardSpawned.add(onSpawnNextPlayer);

		// Create the board
		board = new OtrioBoard(boardSpawned);

		// Spawn the board
		board.spawn();
	} // End of createBoard function.

	public function createPlayers(_playerCount:Int = 4):Void
	{
		spawnNextPlayer = new FlxSignal();
		spawnNextPlayer.add(onSpawnNextPlayer);

		allPlayersSpawned = new FlxSignal();
		allPlayersSpawned.add(onGameReady);

		players = new FlxTypedGroup<OtrioPlayer>(_playerCount);

		// for (i in 0...players.maxSize)
		// {
		// 	this.players.add(new OtrioPlayer(onPlayerSpawned));
		// }

		this.players.add(new OtrioPlayer(0, spawnNextPlayer));
		this.players.add(new OtrioPlayer(1, spawnNextPlayer));
		this.players.add(new OtrioPlayer(2, spawnNextPlayer));
		this.players.add(new OtrioPlayer(3, allPlayersSpawned));

		Log.trace("Created " + players.length + " players.");
	} // End of createPlayer function.

	// Start Game
	public function newGame():Void
	{
		// Spawn the board
		board.spawn();
	} // End of startGame function.

	public function onSpawnNextPlayer():Void
	{
		var player = players.getFirstDead();

		if (player != null)
		{
			player.spawn();
		}
		else
		{
			Log.trace("All players spawned.");
		}

		// var i = players.length - 1;
		// while (i > 0)
		// for (i in 0...players.maxSize)
		// {
		// 	if (players.members[i].alive == true)
		// 	{
		// 		Log.trace("Spawning player " + i);
		// 		players.members[i].spawn();

		// 		break;
		// 	}
		// 	// i--;
		// }
	} // End of spawnPlayer function.

	// On game ready
	public function onGameReady():Void
	{
		Log.trace("Game Ready");
	} // End of onGameReady function.
} // End of OtrioPlayState class.

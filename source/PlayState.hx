package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import otrio.OtrioSplashState;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();

		// Create the Otrio button.
		var otrioButton = new FlxButton(0, 0, "Otrio", onPressOtrioButton);
		otrioButton.screenCenter();

		// Add the Otrio button to the state.
		add(otrioButton);
	} // End of create function.

	// This function is called when the Otrio button is pressed.
	public function onPressOtrioButton():Void
	{
		FlxG.switchState(new OtrioSplashState());
	} // End of onPressOtrioButton function.

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	} // End of update function.
} // End of PlayState class.

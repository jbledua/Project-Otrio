package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;

class GameOverState extends FlxState
{
    override public function create():Void
    {
        // Display the final score
        var scoreText:FlxText = new FlxText(0, FlxG.height / 4, FlxG.width, "Game Over");
        scoreText.setFormat(null, 64, 0xFFFFFF, "center");
        add(scoreText);

        // Add buttons to restart or return to the main menu
        var restartButton:FlxButton = new FlxButton(FlxG.width / 2 - 50, FlxG.height / 2, "Restart", restartGame);
        var menuButton:FlxButton = new FlxButton(FlxG.width / 2 - 50, 270, "Return to Menu", returnToMenu);
        add(restartButton);
        add(menuButton);
    }

    public function restartGame():Void
    {
        // Restart the game by switching to a new instance of the main game state
        FlxG.switchState(new MenuState());
    }

    public function returnToMenu():Void
    {
        // Return to the main menu by switching to a new instance of the menu state
        FlxG.switchState(new MenuState());
    }
}


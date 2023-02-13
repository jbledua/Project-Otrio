import haxe.Log;

// ADD AI to this class
class PlayerVertAI extends PlayerVert
{
    override public function startTurn()
    {
        Log.trace("Start Turn - AI Player");


        // Unlock all Pieces that are not on the board
        for (i in 0...slots.length)
        {
            for (j in 0...pieces.length)
            {
                if(slots.members[i].overlaps(pieces.members[j]))
                {
                    pieces.members[j].setLocked(true);
                }
            }
        }

    }
    
    override public function endTurn()
    {
        Log.trace("End Turn - AI Player");

        // Lock all Pieces
        for (i in 0...pieces.length)
        {
            pieces.members[i].setLocked(false);
        }
    }
}
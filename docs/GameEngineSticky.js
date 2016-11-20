var StickyGameSamples = [];

function StickyGameSample(sizeX, sizeY, Tiles)
{
	this.sizeX = sizeX;
	this.sizeY = sizeY;
	this.tiles = [];
	
	var i;
	
	for (i = 0; i < Tiles.length; i++) 
	{
		this.tiles.push( Tiles[i]);
	}
	
	//--------------------------------------------------
	this.toString = function () 
	{
		var s;
		s = "Board is " + this.sizeX + " by " + this.sizeY + " Nodes:";
		
		var i;
		for (i = 0; i < this.tiles.length; i++) 
		{
			s += this.tiles[i] + ", ";
		}
		s += "<br>";
		return s;
	};	
}

function WriteGameSamples()
{
	var i;
	var s;
	s = "there are " + StickyGameSamples.length + " Game Samples <br>";
	
	for ( i = 0 ; i < StickyGameSamples.length ; i++ )
	{
		s += "Sample " + (i+1) + ":<br>" + StickyGameSamples[i].toString();
	}
	
	return s;
}

// Format:
// SizeX, SizeY, Tile, Tile, Tile
// Tile: id, posX, posY, sizeX, sizeY, isLocked

//StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[5,4,0,1,1,false],[5,4,1,1,1,false],[5,4,2,1,1,false],[5,4,3,1,1,false],[6,4,4,1,1,false],[6,4,5,1,1,false],[6,5,0,1,1,false],[6,5,1,1,1,false],[6,5,2,1,1,false]]) );
//StickyGameSamples.push( new StickyGameSample(4,4,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[3,3,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false]]) );

StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,1,0,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[2,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[2,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,5,0,1,1,false],[2,5,1,1,1,false],[2,5,2,1,1,false],[2,5,3,1,1,false],[2,5,4,1,1,false],[2,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[2,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,2,0,1,1,false],[2,2,1,1,1,false],[2,2,2,1,1,false],[2,2,3,1,1,false],[2,2,4,1,1,false],[2,2,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[3,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[2,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false]]) );

StickyGameSamples.push( new StickyGameSample(6,6,[[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[4,4,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[3,5,0,1,1,false],[3,5,1,1,1,false],[3,5,2,1,1,false],[3,5,3,1,1,false],[3,5,4,1,1,false],[3,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[2,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,2,0,1,1,false],[2,2,1,1,1,false],[2,2,2,1,1,false],[2,2,3,1,1,false],[2,2,4,1,1,false],[2,2,5,1,1,false],[3,5,0,1,1,false],[3,5,1,1,1,false],[3,5,2,1,1,false],[3,5,3,1,1,false],[3,5,4,1,1,false],[3,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,1,1,1,1,false],[1,0,2,1,1,false],[1,1,3,1,1,false],[1,0,4,1,1,false],[1,1,5,1,1,false],[2,0,1,1,1,false],[2,0,3,1,1,false],[2,0,5,1,1,false],[2,1,0,1,1,false],[2,1,2,1,1,false],[2,1,4,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[3,0,0,1,1,false],[3,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,2,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[2,1,0,1,1,false],[1,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,2,1,1,1,false],[1,0,2,1,1,false],[1,2,3,1,1,false],[1,0,4,1,1,false],[1,2,5,1,1,false],[2,0,1,1,1,false],[2,0,3,1,1,false],[2,0,5,1,1,false],[3,1,0,1,1,false],[3,1,1,1,1,false],[3,1,2,1,1,false],[3,1,3,1,1,false],[3,1,4,1,1,false],[3,1,5,1,1,false],[2,2,0,1,1,false],[2,2,2,1,1,false],[2,2,4,1,1,false]]) );

StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,1,1,1,1,false],[1,2,2,1,1,false],[1,0,3,1,1,false],[1,1,4,1,1,false],[1,2,5,1,1,false],[2,0,1,1,1,false],[2,1,2,1,1,false],[3,0,2,1,1,false],[2,0,4,1,1,false],[3,0,5,1,1,false],[3,1,0,1,1,false],[3,1,3,1,1,false],[2,1,5,1,1,false],[2,2,0,1,1,false],[3,2,1,1,1,false],[2,2,3,1,1,false],[3,2,4,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,1,1,1,1,false],[1,2,2,1,1,false],[1,2,3,1,1,false],[1,1,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,2,1,1,1,false],[2,3,2,1,1,false],[2,3,3,1,1,false],[2,2,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,3,1,1,1,false],[3,4,2,1,1,false],[3,4,3,1,1,false],[3,3,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,4,1,1,1,false],[4,4,0,1,1,false],[4,4,5,1,1,false],[4,4,4,1,1,false],[4,3,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[4,4,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[3,5,0,1,1,false],[3,5,1,1,1,false],[3,5,2,1,1,false],[3,5,3,1,1,false],[3,5,4,1,1,false],[3,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[4,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[2,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[3,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[3,0,0,1,1,false],[3,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,2,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[2,1,0,1,1,false],[1,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false]]) );

StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[2,4,3,1,1,false],[2,4,4,1,1,false],[2,4,5,1,1,false],[1,5,3,1,1,false],[1,5,4,1,1,false],[1,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[1,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,1,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,2,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,3,0,1,1,false],[3,4,1,1,1,false],[3,4,2,1,1,false],[3,4,3,1,1,false],[3,4,4,1,1,false],[3,4,5,1,1,false],[4,4,0,1,1,false],[4,5,1,1,1,false],[4,5,2,1,1,false],[4,5,3,1,1,false],[4,5,4,1,1,false],[4,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[1,5,3,1,1,false],[1,5,4,1,1,false],[1,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[4,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[3,3,5,1,1,false]]) );

StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,3,4,1,1,false],[4,2,0,1,1,false],[4,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[3,3,5,1,1,false],[3,2,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,1,0,1,1,false],[1,1,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,2,0,1,1,false],[2,2,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,3,0,1,1,false],[3,3,1,1,1,false],[3,4,2,1,1,false],[3,4,3,1,1,false],[3,4,4,1,1,false],[3,4,5,1,1,false],[4,4,0,1,1,false],[4,4,1,1,1,false],[4,5,2,1,1,false],[4,5,3,1,1,false],[4,5,4,1,1,false],[4,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,3,4,1,1,false],[4,2,0,1,1,false],[4,2,1,1,1,false],[4,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[3,3,3,1,1,false],[3,3,5,1,1,false],[3,2,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[2,4,3,1,1,false],[2,4,4,1,1,false],[2,4,5,1,1,false],[1,5,3,1,1,false],[1,5,4,1,1,false],[1,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[2,0,3,1,1,false],[2,0,4,1,1,false],[2,0,5,1,1,false],[3,1,0,1,1,false],[3,1,1,1,1,false],[3,1,2,1,1,false],[3,1,3,1,1,false],[3,1,4,1,1,false],[3,1,5,1,1,false],[4,2,0,1,1,false],[4,2,1,1,1,false],[4,2,2,1,1,false],[4,2,3,1,1,false],[4,2,4,1,1,false],[4,2,5,1,1,false],[1,3,0,1,1,false],[1,3,1,1,1,false],[1,3,2,1,1,false],[2,3,3,1,1,false],[2,3,4,1,1,false],[2,3,5,1,1,false]]) );

StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,1,0,1,1,true]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[2,0,0,1,1,true],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,1,0,1,1,true],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,true],[2,0,1,1,1,false],[2,0,2,1,1,false],[2,0,3,1,1,false],[2,0,4,1,1,false],[2,0,5,1,1,false],[2,5,0,1,1,true],[1,5,1,1,1,false],[1,5,2,1,1,false],[1,5,3,1,1,false],[1,5,4,1,1,false],[1,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,1,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,2,0,1,1,true],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,0,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,1,0,1,1,false],[1,1,1,1,1,false],[1,1,2,1,1,false],[1,1,3,1,1,false],[1,1,4,1,1,false],[1,1,5,1,1,false],[2,4,0,1,1,false],[2,3,1,1,1,false],[2,3,2,1,1,false],[2,3,3,1,1,false],[2,3,4,1,1,false],[2,3,5,1,1,true],[3,5,0,1,1,false],[3,5,1,1,1,false],[3,5,2,1,1,false],[3,5,3,1,1,false],[3,5,4,1,1,false],[3,5,5,1,1,false]]) );

//31
StickyGameSamples.push( new StickyGameSample(6,6,[[1,1,0,1,1,false],[1,1,1,1,1,false],[1,1,2,1,1,false],[1,1,3,1,1,false],[1,1,4,1,1,false],[1,1,5,1,1,false],[2,4,0,1,1,false],[2,3,1,1,1,false],[2,3,2,1,1,false],[2,3,3,1,1,false],[2,3,4,1,1,false],[2,3,5,1,1,true],[3,5,0,1,1,false],[3,5,1,1,1,false],[3,5,2,1,1,false],[3,5,3,1,1,false],[3,5,4,1,1,false],[3,5,5,1,1,true]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,1,1,1,1,true],[1,1,2,1,1,true],[1,1,3,1,1,true],[1,1,4,1,1,true],[1,1,5,1,1,true],[2,2,1,1,1,true],[2,2,2,1,1,true],[2,2,3,1,1,true],[2,2,4,1,1,true],[2,2,5,1,1,true],[1,3,4,1,1,false],[2,3,5,1,1,false],[4,4,0,1,1,false],[3,5,0,1,1,false],[3,5,1,1,1,false],[3,5,2,1,1,false],[3,5,3,1,1,false],[3,5,4,1,1,false],[3,5,5,1,1,false],[4,0,1,1,1,false],[4,0,2,1,1,false],[4,0,3,1,1,false],[4,0,4,1,1,false],[4,0,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,3,1,1,1,false],[3,3,2,1,1,false],[3,3,3,1,1,false],[3,3,4,1,1,false],[3,3,5,1,1,true],[3,4,0,1,1,false],[4,5,0,1,1,false],[4,5,1,1,1,false],[4,5,2,1,1,false],[4,5,3,1,1,false],[4,5,4,1,1,false],[4,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,true],[2,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,1,0,1,1,false],[2,1,1,1,1,true],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,true],[2,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,1,0,1,1,false],[2,1,1,1,1,true],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,true],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false]]) );

//36
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,true],[2,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,1,0,1,1,false],[2,1,1,1,1,true],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,true],[3,2,3,1,1,true],[3,2,4,1,1,true],[3,2,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[3,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,true],[2,2,0,1,1,false],[2,2,1,1,1,false],[2,2,2,1,1,false],[2,2,3,1,1,false],[2,2,4,1,1,false],[2,2,5,1,1,true],[3,4,1,1,1,false],[3,4,2,1,1,false],[3,4,3,1,1,false],[3,4,4,1,1,false],[3,4,5,1,1,true],[1,4,0,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[2,0,5,1,1,false],[3,1,0,1,1,false],[3,1,1,1,1,true],[3,1,2,1,1,true],[3,1,3,1,1,true],[3,1,4,1,1,true],[3,1,5,1,1,true],[1,2,0,1,1,false],[2,2,1,1,1,false],[2,2,2,1,1,false],[2,2,3,1,1,false],[2,2,4,1,1,false],[2,2,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[2,0,5,1,1,false],[3,1,0,1,1,false],[3,1,1,1,1,true],[3,1,2,1,1,true],[3,1,3,1,1,true],[3,1,4,1,1,true],[3,1,5,1,1,true],[1,2,0,1,1,false],[2,2,1,1,1,false],[2,2,2,1,1,false],[2,2,3,1,1,false],[2,2,4,1,1,false],[2,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,true],[1,0,4,1,1,false],[4,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,true],[2,1,4,1,1,false],[2,1,5,1,1,true],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,true],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[1,3,4,1,1,false],[4,3,5,1,1,false]]) );

//41
StickyGameSamples.push( new StickyGameSample(6,6,[[4,0,0,1,1,false],[4,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,true],[1,3,0,1,1,false],[1,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,true]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[4,0,0,1,1,false],[4,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,true],[3,2,1,1,1,true],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,true],[1,3,0,1,1,false],[1,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,true]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[4,0,0,1,1,false],[4,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,true],[3,2,1,1,1,true],[3,2,2,1,1,true],[3,2,3,1,1,true],[3,2,4,1,1,false],[3,2,5,1,1,false],[1,3,0,1,1,false],[1,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,true]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,true],[2,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,1,0,1,1,false],[2,1,1,1,1,true],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,true],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,true],[4,3,4,1,1,false],[4,3,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,true],[2,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,true],[1,1,0,1,1,false],[2,1,1,1,1,true],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,true],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,true],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,true],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,true],[4,3,4,1,1,false],[4,3,5,1,1,true]]) );

//46
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,4,0,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[5,4,5,1,1,false],[5,4,1,1,1,false],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,false],[5,3,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,4,0,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[5,3,3,1,1,false],[5,3,4,1,1,false],[5,4,5,1,1,false],[4,4,1,1,1,false],[4,4,2,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,false],[5,3,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[5,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[3,4,0,1,1,false],[5,4,5,1,1,false],[5,4,1,1,1,false],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[5,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[3,4,0,1,1,false],[5,4,5,1,1,true],[5,4,1,1,1,false],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[5,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,true],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,true],[3,4,0,1,1,false],[5,4,5,1,1,true],[5,4,1,1,1,false],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,false]]) );

//51
StickyGameSamples.push( new StickyGameSample(6,6,[[5,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,true],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,true],[1,4,0,1,1,false],[5,4,5,1,1,true],[5,4,1,1,1,false],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,true],[3,2,4,1,1,false],[3,2,5,1,1,false],[5,3,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,true],[4,4,0,1,1,false],[5,4,5,1,1,true],[5,4,1,1,1,false],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,true],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,true],[3,2,4,1,1,false],[3,2,5,1,1,false],[5,3,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,true],[4,4,0,1,1,false],[5,4,5,1,1,true],[5,4,1,1,1,false],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,2,1,1,false],[1,0,4,1,1,false],[1,0,0,1,1,false],[1,0,3,1,1,false],[1,0,1,1,1,false],[1,0,5,1,1,false],[2,1,1,1,1,false],[2,1,0,1,1,false],[2,1,2,1,1,true],[2,1,5,1,1,false],[2,1,4,1,1,false],[2,1,3,1,1,false],[3,2,1,1,1,false],[4,2,4,1,1,false],[3,2,2,1,1,true],[3,2,3,1,1,true],[5,3,5,1,1,false],[3,2,5,1,1,false],[5,4,0,1,1,false],[3,3,3,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,true],[3,2,0,1,1,false],[4,3,4,1,1,true],[4,3,0,1,1,false],[5,4,5,1,1,true],[5,4,1,1,1,false],[5,4,2,1,1,true],[5,4,3,1,1,false],[4,4,4,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,2,1,1,false],[1,0,4,1,1,false],[1,0,0,1,1,false],[1,0,3,1,1,false],[1,0,1,1,1,false],[1,0,5,1,1,false],[2,1,1,1,1,false],[2,1,0,1,1,false],[2,1,2,1,1,true],[2,1,5,1,1,false],[2,1,4,1,1,false],[2,1,3,1,1,false],[3,2,1,1,1,false],[4,2,4,1,1,false],[3,2,2,1,1,true],[3,2,3,1,1,true],[5,3,5,1,1,false],[3,2,5,1,1,false],[5,4,0,1,1,false],[3,3,3,1,1,false],[4,3,1,1,1,true],[4,3,2,1,1,true],[3,2,0,1,1,false],[4,3,4,1,1,true],[4,3,0,1,1,false],[5,4,5,1,1,true],[5,4,1,1,1,false],[5,4,2,1,1,true],[5,4,3,1,1,false],[4,4,4,1,1,false]]) );

//56
StickyGameSamples.push( new StickyGameSample(6,6,[[1,5,2,1,1,false],[1,0,2,1,1,false],[1,2,1,1,1,false],[1,1,1,1,1,false],[1,4,1,1,1,false],[1,0,5,1,1,false],[2,0,3,1,1,false],[2,5,1,1,1,false],[2,1,2,1,1,true],[2,1,5,1,1,false],[2,1,4,1,1,false],[5,1,3,1,1,false],[3,0,4,1,1,false],[4,2,4,1,1,false],[3,2,2,1,1,true],[3,2,3,1,1,true],[5,3,5,1,1,false],[4,2,5,1,1,false],[5,5,5,1,1,false],[3,3,3,1,1,false],[4,3,1,1,1,true],[4,3,2,1,1,true],[3,5,3,1,1,false],[4,3,4,1,1,true],[4,5,4,1,1,false],[5,4,5,1,1,true],[5,0,1,1,1,false],[5,4,2,1,1,true],[2,4,3,1,1,false],[3,4,4,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,true],[5,1,2,1,1,false],[5,1,3,1,1,false],[2,1,4,1,1,true],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,true],[3,2,3,1,1,true],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,true],[4,3,3,1,1,true],[4,3,4,1,1,false],[4,3,5,1,1,false],[5,4,0,1,1,false],[5,4,1,1,1,true],[2,4,2,1,1,false],[2,4,3,1,1,false],[5,4,4,1,1,true],[5,4,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,true],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,true],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,true],[3,2,3,1,1,true],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,true],[4,3,3,1,1,true],[4,3,4,1,1,false],[4,3,5,1,1,false],[5,4,0,1,1,false],[5,4,1,1,1,true],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,true],[5,4,5,1,1,false],[1,5,0,1,1,false],[1,5,1,1,1,false],[1,5,2,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,true],[2,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,1,0,1,1,false],[2,1,1,1,1,true],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,true],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,true],[4,3,4,1,1,false],[4,3,5,1,1,false],[5,4,0,1,1,false],[5,4,1,1,1,false],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,true],[5,4,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,true],[2,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[1,1,0,1,1,false],[2,1,1,1,1,true],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,true],[2,1,5,1,1,true],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,true],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,true],[4,3,4,1,1,false],[4,3,5,1,1,false],[5,4,0,1,1,true],[5,4,1,1,1,true],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,true],[5,4,5,1,1,false]]) );

//61
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,false],[5,4,5,1,1,false],[5,5,5,1,1,false],[5,5,4,1,1,false],[5,5,3,1,1,false],[6,4,2,1,1,false],[6,4,1,1,1,false],[6,4,0,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,false],[5,4,5,1,1,false],[5,5,5,1,1,false],[5,5,4,1,1,false],[5,5,3,1,1,false],[6,4,2,1,1,false],[6,4,1,1,1,false],[6,4,0,1,1,false],[6,5,0,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,4,0,1,1,false],[4,4,1,1,1,false],[4,4,2,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[5,3,3,1,1,false],[5,3,4,1,1,false],[5,3,5,1,1,false],[5,4,5,1,1,false],[5,4,4,1,1,false],[5,4,3,1,1,false],[6,5,2,1,1,false],[6,5,1,1,1,false],[6,5,0,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,4,0,1,1,false],[4,4,1,1,1,false],[4,4,2,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[5,3,3,1,1,false],[5,3,4,1,1,false],[5,3,5,1,1,false],[5,4,5,1,1,false],[5,4,4,1,1,false],[5,4,3,1,1,false],[6,5,2,1,1,false],[6,5,1,1,1,false],[6,5,0,1,1,false],[6,5,3,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[6,5,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,4,0,1,1,false],[4,4,1,1,1,false],[4,5,5,1,1,false],[4,4,4,1,1,false],[4,4,3,1,1,false],[4,4,2,1,1,false],[5,3,0,1,1,false],[5,3,1,1,1,false],[5,3,2,1,1,false],[5,3,3,1,1,false],[5,3,4,1,1,false],[5,3,5,1,1,false],[6,5,2,1,1,false],[6,5,1,1,1,false],[6,5,3,1,1,false],[3,4,5,1,1,false]]) );

//66
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,5,1,1,false],[4,3,4,1,1,false],[4,3,3,1,1,false],[5,5,3,1,1,false],[5,5,4,1,1,false],[5,4,5,1,1,false],[5,5,2,1,1,false],[5,5,1,1,1,false],[5,5,0,1,1,false],[6,4,0,1,1,false],[6,4,1,1,1,false],[6,4,2,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[4,4,3,1,1,false],[4,4,4,1,1,false],[4,4,5,1,1,false],[5,5,3,1,1,false],[5,5,4,1,1,false],[5,5,5,1,1,false],[5,5,2,1,1,false],[5,5,1,1,1,false],[5,5,0,1,1,false],[6,3,2,1,1,false],[6,3,1,1,1,false],[6,3,0,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[6,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,5,4,1,1,false],[5,5,3,1,1,false],[5,5,2,1,1,false],[5,5,1,1,1,false],[6,4,1,1,1,false],[6,4,0,1,1,false],[4,5,0,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[6,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[6,4,2,1,1,false],[5,4,3,1,1,false],[5,5,4,1,1,false],[5,5,3,1,1,false],[5,5,2,1,1,false],[5,5,1,1,1,false],[6,4,1,1,1,false],[6,4,0,1,1,false],[5,5,5,1,1,false],[4,5,0,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[5,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[6,5,2,1,1,false],[5,4,0,1,1,false],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,4,4,1,1,false],[6,4,5,1,1,false],[6,5,3,1,1,false],[6,5,4,1,1,false],[5,4,1,1,1,false],[4,5,5,1,1,false]]) );

//71
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[6,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,4,0,1,1,false],[4,4,1,1,1,false],[4,4,5,1,1,false],[4,4,4,1,1,false],[4,4,3,1,1,false],[4,4,2,1,1,false],[5,3,0,1,1,false],[5,3,1,1,1,false],[5,3,2,1,1,false],[5,3,3,1,1,false],[5,3,4,1,1,false],[5,3,5,1,1,false],[6,5,2,1,1,false],[6,5,1,1,1,false],[3,5,0,1,1,false],[6,5,3,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,4,1,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[6,5,2,1,1,false],[5,5,1,1,1,false],[5,4,2,1,1,false],[5,4,3,1,1,false],[5,3,0,1,1,false],[6,5,4,1,1,false],[6,4,5,1,1,false],[5,4,4,1,1,false],[6,5,3,1,1,false],[6,5,5,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,4,3,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,false],[5,4,0,1,1,false],[5,4,2,1,1,false],[5,5,5,1,1,false],[6,5,3,1,1,false],[5,3,0,1,1,false],[6,5,0,1,1,false],[6,5,2,1,1,false],[6,5,4,1,1,false],[5,4,1,1,1,false],[6,5,1,1,1,false]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,false],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,false],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,true],[5,4,0,1,1,false],[5,5,1,1,1,false],[5,5,2,1,1,false],[5,5,3,1,1,false],[5,5,4,1,1,false],[5,5,5,1,1,true]]) );
StickyGameSamples.push( new StickyGameSample(6,6,[[1,0,0,1,1,false],[1,0,1,1,1,false],[1,0,2,1,1,false],[1,0,3,1,1,false],[1,0,4,1,1,false],[1,0,5,1,1,false],[2,1,0,1,1,false],[2,1,1,1,1,false],[2,1,2,1,1,false],[2,1,3,1,1,false],[2,1,4,1,1,false],[2,1,5,1,1,true],[3,2,0,1,1,false],[3,2,1,1,1,false],[3,2,2,1,1,false],[3,2,3,1,1,false],[3,2,4,1,1,false],[3,2,5,1,1,true],[4,3,0,1,1,false],[4,3,1,1,1,false],[4,3,2,1,1,false],[4,3,3,1,1,false],[4,3,4,1,1,false],[4,3,5,1,1,true],[5,4,0,1,1,false],[5,5,1,1,1,false],[5,5,2,1,1,false],[5,5,3,1,1,false],[5,5,4,1,1,false],[5,5,5,1,1,true]]) );



//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
function StickytileClass()
{
	this.id = 0;
	this.pos = new posClass( 0, 0 ); //logical position
	this.tileSize = new posClass( 0, 0 );
	this.currentPos = new posClass( 0, 0 );
	this.savedPos = new posClass( 0, 0 ); //to save logical position
	this.undoPos = new posClass( 0, 0 ); //position for undo
	this.isMoving = false;
	this.isVisited = false;
	this.isLocked = false;
	
	//checks if the position is same as the position saved for UNDO
	this.isSameAsUndo = function()
	{
		if ( ( this.currentPos.x == this.undoPos.x ) && ( this.currentPos.y == this.undoPos.y ) )
		{
			return true;
		}
		
		return false;
	}
	
	this.Occupies = function( pos )
	{
		var occupies = false;
		
		var tempX;
		var tempY;
		
		if ( this.id != 0 )
		{
			for ( x = 0 ; x < this.tileSize.x ; x++ )
			{
				for ( y = 0 ; y < this.tileSize.y ; y++ )
				{
				   tempX = this.pos.x + x;
				   tempY = this.pos.y + y;
				   if ( ( tempX == pos.x ) && ( tempY == pos.y ) )
				   {
					   occupies = true;
					   break;
				   }
				}
			}
		}
		
		return occupies;
	}
	
	this.Move = function( delta_row, delta_col, cellSize )
	{
		this.pos.y += delta_row;
		this.pos.x += delta_col;

		this.currentPos.x = this.pos.x*cellSize;
		this.currentPos.y = this.pos.y*cellSize;
	}
	
	// delta: the vector to move the tile
    // Move the block by pixels	
	this.MoveTile = function( delta, cellSize )
	{
		this.currentPos.x = this.pos.x*cellSize + delta.x;
		this.currentPos.y = this.pos.y*cellSize + delta.y;
	}
	

	this.SetRowAndCol = function ( row, col, cellSize )
	{
		this.pos.y = row;
		this.pos.x = col;

		this.currentPos.x = this.pos.x*cellSize;
		this.currentPos.y = this.pos.y*cellSize;
	}	
}

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
function StickyGameApp( Canvas, Context ) {
	
	//maximum size
	const MAX_RANGE = 6;

	const MOVE_DIRECTION_NONE = 0;
	const MOVE_DIRECTION_HORIZONTAL = 1;
	const MOVE_DIRECTION_VERTICAL = 2;
	const MOVE_DETECTION_PIXELS =	3;

	const DIRECTION_UP = 0;
	const DIRECTION_DOWN = 1;
	const DIRECTION_LEFT = 2;
	const DIRECTION_RIGHT = 3;

    const StickygameCellSizeMax = 60;
    var StickygameCellSize = StickygameCellSizeMax;

	const navUndo = 0;
	const navSelector = 1;
	const navHome = 2;
	const navReset = 3;
	const navHelp = 4;
	const gameId = STICKY_GAME_ID;

	const m_is_sticky_on = true;
	
	var gameIconSize = 48;

	var gameNavItems = 5;
	var gameNavHeight = StickygameCellSize;
	
	var theCanvas = Canvas;
	var context = Context;
	var currentLevel = 0;
	var cellPadding = 5;
	var sizeX = 0;
	var sizeY = 0;
	var tileCount = 0;
	var tiles = [];
	var dragging = false;
	var touchPos = new posClass( 0, 0);
	var currentPos = new posClass( 0, 0);
	var touchedCell = new posClass( 0, 0);
	var m_move_direction = MOVE_DIRECTION_NONE;
	var m_upper_bound = 0;
	var m_lower_bound = 0;
	var direction_vector = [];
	var	navCellWidth = 0;
	var	navBarTop = 0;
	var gameFontSize = 30;
	var requestDraw = true;
	var xOffset = 0;
	var moveCount = 0;

    //images
	var imgLock = new Image();
	var imgUndo = new Image();
	var imgHome = new Image();
	var imgSelector = new Image();
	var imgReset = new Image();
	var imgHelp = new Image();
	var helpPage = 1;	
	
	init();

	this.loadGameEx = function(level)
	{
	    updateCoordinates();
		loadGame(level);
	}
	
	this.getCurrentLevel = function()
	{
		return currentLevel;
	}
	
	function init()
	{
		var tempPos = new posClass( 0, 0);
		var i;
		
		for ( i = 0 ; i < MAX_RANGE * MAX_RANGE ; i++ )
		{
			tiles.push( new StickytileClass() );
		}
		
		direction_vector.push( new posClass( 0, -1 ) );  // DIRECTION_UP 		
		direction_vector.push( new posClass( 0, +1 ) );  // DIRECTION_DOWN,
		direction_vector.push( new posClass(-1, 0  ) );  // DIRECTION_LEFT,
		direction_vector.push( new posClass(+1, 0  ) );  //DIRECTION_RIGHT	
		
		var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
			
		StickygameCellSize = Math.min( (width)/(MAX_RANGE+1), StickygameCellSizeMax );
		
		if ( StickygameCellSize == StickygameCellSizeMax )
		{
			gameIconSize = 48;
			imgLock.src = "img/lock.png";
			imgLock.onload = function () { requestDraw = true; }
			
			imgUndo.src = "img/undo.png";
			imgUndo.onload = function () { requestDraw = true; }
			
			imgHome.src = "img/home.png";
			imgHome.onload = function () { requestDraw = true; }
			
			imgSelector.src = "img/selector.png";
			imgSelector.onload = function () { requestDraw = true; }
			
			imgReset.src = "img/Reset.png";
			imgReset.onload = function () { requestDraw = true; }		

			imgHelp.src = "img/help.png";
			imgHelp.onload = function () { requestDraw = true; }		

			gameFontSize = 27;
		}
		else
		{
			gameIconSize = 32;
			imgLock.src = "img/locks.png";
			imgLock.onload = function () { requestDraw = true; }
			
			imgUndo.src = "img/undos.png";
			imgUndo.onload = function () { requestDraw = true; }
			
			imgHome.src = "img/homes.png";
			imgHome.onload = function () { requestDraw = true; }
			
			imgSelector.src = "img/selectors.png";
			imgSelector.onload = function () { requestDraw = true; }
			
			imgReset.src = "img/Resets.png";
			imgReset.onload = function () { requestDraw = true; }		

			imgHelp.src = "img/helps.png";
			imgHelp.onload = function () { requestDraw = true; }		

			gameFontSize = 18;
		}
		
		updateCoordinates();
	}
	
	//to decide cellSize and other Coordinates
	function updateCoordinates()
	{
		var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
			
		StickygameCellSize = Math.min( (width)/(MAX_RANGE+1), StickygameCellSizeMax );
	
	    cellPadding = 3;
		gameNavHeight = StickygameCellSize;
		
		theCanvas.width  = (MAX_RANGE+1)*StickygameCellSize;
		theCanvas.height = (MAX_RANGE+3)*StickygameCellSize;	
				
		navCellWidth = ( theCanvas.width - StickygameCellSize ) / gameNavItems;
		navBarTop = (MAX_RANGE + 1.5)*StickygameCellSize;	

	}
	
	function IsSolved()
	{
		var row, col;
			
		var pos = new posClass( 0,0 );
		
		var tileIndex;
		
		var colorIndex;
		
		//indicates which color goes to which column
		var colColors = [];
		
		var emptyBoard = true;
		
		for ( col = 0 ; col < MAX_RANGE+1 ; col++ )
		{
			colColors[ col ] = -1;
		}
		
		for ( col = 0 ; col < sizeX ; col++ )
		{
			pos.x = col;
			for ( row = 0 ; row < sizeY ; row++ )
			{
				pos.y = row;
				
				tileIndex =  GetTile( pos );
				
				//check if there's a tile
				if ( tileIndex >= 0 )
				{
					emptyBoard = false;
					
					colorIndex = tiles[ tileIndex ].id;
					//
					if ( colColors[ colorIndex ] >= 0 )
					{
						if ( col != colColors[ colorIndex ] )	
						{
							return false;
						}
					}
					else
					{
						//color is not established, set it
						colColors[ colorIndex ] = col;
					}
				}
			}
		}
		
		if ( emptyBoard )
		{
			return false;
		}
		else
		{
			return true;
		}
	}
	
	function loadGame( level )
	{
		currentLevel = level;
		
		if ( currentLevel == 25 )
		{
			AsyncPopupInfo();
		}
		else if ( ( currentLevel ) && ( ( currentLevel % 5 ) == 0 ) ) //ask to share every 5 levels, only if hasn't shared already
		{
			AsyncShareDialog();
		}
		
		sizeX = StickyGameSamples[currentLevel].sizeX;
		sizeY = StickyGameSamples[currentLevel].sizeY;
		
		tileCount = StickyGameSamples[currentLevel].tiles.length;
		var i;
		
		for ( i = 0 ; i < tileCount ; i++ )
		{
			tiles[i].id = StickyGameSamples[currentLevel].tiles[i][0];
			tiles[i].SetRowAndCol( StickyGameSamples[currentLevel].tiles[i][2], StickyGameSamples[currentLevel].tiles[i][1], StickygameCellSize);
			tiles[i].tileSize.x = StickyGameSamples[currentLevel].tiles[i][3];
			tiles[i].tileSize.y = StickyGameSamples[currentLevel].tiles[i][4];
			tiles[i].isLocked = StickyGameSamples[currentLevel].tiles[i][5];
		}
			
		console.log("Game Loaded");
						
		SavePositionsUndo();
		
		dragging = false;
		
		xOffset = ( MAX_RANGE + 1 - sizeX )*StickygameCellSize/2;
		
		moveCount = 0;
		 
		requestDraw = true;
	}
	
	function LogData()
	{
		console.log("There are " + tileCount + " tiles");
		var i;
		for ( i = 0 ; i < tileCount ; i++ )
		{
			console.log("Tile(" + i + "):X=" + tiles[i].pos.x + ",Y=" + tiles[i].pos.y + ",x=" + tiles[i].currentPos.x + ",y=" + tiles[i].currentPos.y );
		}
	}
	
	function isSameAsUndo()
	{
		var i;
		for ( i = 0 ; i < tileCount ; i++ )
		{
			if ( ! tiles[i].isSameAsUndo() )
			{
				return false;
			}
		}
		
		return true;
	}
	
	//saves positions for undo
	function SavePositionsUndo()
	{
		if ( !isSameAsUndo() )
		{
			for ( i = 0 ; i < tileCount ; i++ )
			{
				tiles[i].undoPos.x = tiles[i].pos.x;
				tiles[i].undoPos.y = tiles[i].pos.y;
			}
		}
	}
	
	function RestorePositionsUndo()
	{
		for ( i = 0 ; i < tileCount ; i++ )
		{
			tiles[i].SetRowAndCol( tiles[i].undoPos.y, tiles[i].undoPos.x, StickygameCellSize );
		}
	}
	
	
	function SavePositions()
	{
		for ( i = 0 ; i < tileCount ; i++ )
		{
			tiles[i].savedPos.x = tiles[i].pos.x;
			tiles[i].savedPos.y = tiles[i].pos.y;
		}
	}
	
	function RestorePositions()
	{
		for ( i = 0 ; i < tileCount ; i++ )
		{
			tiles[i].SetRowAndCol( tiles[i].savedPos.y, tiles[i].savedPos.x, StickygameCellSize );
		}
	}
	
	function MoveBlocks( delta )
	{
		var i;
		for ( i = 0; i < tileCount ; i++ )
		{
			if ( tiles[i].isMoving )
			{
				tiles[i].MoveTile( delta, StickygameCellSize );
			}
		}
	}	
	
	function MoveTiles( delta_row, delta_col )
	{
		var error_detected = false;

		var tileIndex;
		
		for ( tileIndex = 0; tileIndex < tileCount ; tileIndex++ )
		{
			if ( tiles[tileIndex].isMoving )
			{
				tiles[tileIndex].Move( delta_row, delta_col, StickygameCellSize );
				
				if ( !IsTilePositionValid( tileIndex ))
				{
					error_detected = true;
					break;
				}
			}
		}

		return !error_detected;
	}
	
	function GetTile( pos )
	{
		for ( i = 0 ; i < tileCount ; i++ )
		{
			if ( tiles[i].Occupies( pos ) )
			{
				return i;
			}
		}
		
		return -1;	
	}
	
	function GetTileNeighbor( row, col, direction )
	{
		var pos = new posClass( col + direction_vector[ direction ].x , row + direction_vector[ direction ].y);
		return GetTile( pos );
	}
	
	function GetTileCount( pos )
	{
		var count = 0;
		
		for ( i = 0 ; i < tileCount ; i++ )
		{
			if ( tiles[i].Occupies( pos ) )
			{
				count++;
			}
		}
		
		return count;	
	}
	
	function FindOverlap()
	{
		var row;
		var col;
		var tempPos = new posClass( 0, 0);

		for ( row = 0 ; row < sizeY ; row++ )
			for ( col = 0 ; col < sizeX ; col++ )
			{
				tempPos.x = col;
				tempPos.y = row;
				
				if ( GetTileCount( tempPos ) > 1 )
				{
					return true; 
				}
			}

		return false;
	}
	
	
	function ResetMovingFlag()
	{
		for ( i = 0 ; i < tileCount ; i++ )
		{
			tiles[i].isMoving = false;
		}		
	}
	
	function ResetVisitedFlag()
	{
		for ( i = 0 ; i < tileCount ; i++ )
		{
			tiles[i].isVisited = false;
		}		
	}
	
	function ResetMovingFlag()
	{
		for ( i = 0 ; i < tileCount ; i++ )
		{
			tiles[i].isMoving = false;
		}		
	}
	
	this.drawScreen = function() {
		
		if ( !requestDraw )
		{
			return;
		}
		
		requestDraw = false;

		context.clearRect(0,0,theCanvas.width,theCanvas.height);	
		
		//additional frame
//		var i;
//		for ( i = 0 ; i < 4 ; i++ )
//		{
//			context.rect(i*5,i*5,theCanvas.width-i*10,theCanvas.height-i*10 );
//			context.stroke();
//		}
		
		//-------------------------------------------------
		//Drawing the title
		var height = gameFontSize*2/3;
		context.font = (Math.floor(gameFontSize*2/3)) + "pt Arial";
		
		context.fillStyle = "rgba(255,255,255,0.5)";
		
		// the height of top part is ONE cellSize
	    roundRect(
					     context
					     ,xOffset + (3.5)*StickygameCellSize 
					     ,cellPadding
					     ,(2.5)*StickygameCellSize
					     ,StickygameCellSize/2 - 2*cellPadding,
					     StickygameCellSize/8, true, false 
					     );
		
	    roundRect(
					     context
					     ,xOffset + (3.5)*StickygameCellSize 
					     ,StickygameCellSize/2 + cellPadding
					     ,(2.5)*StickygameCellSize
					     ,StickygameCellSize/2 - 2*cellPadding,
					     StickygameCellSize/8, true, false 
					     );
		
		context.fillStyle="black";
		
		context.textAlign = "left";
		context.fillText("Moves: " + moveCount, xOffset + (3.5)*StickygameCellSize + cellPadding , StickygameCellSize/2 - 2*cellPadding  );		
		context.fillText("Level: " + (currentLevel + 1) , xOffset + (3.5)*StickygameCellSize + cellPadding , StickygameCellSize - 2*cellPadding );		

		height = gameFontSize;
		context.font = (Math.floor(gameFontSize)) + "pt Arial";
		context.fillText("Sticky Tiles" , xOffset , ( StickygameCellSize + height )/2 );		
		
			
		drawGrid();
		drawTiles();
	}	
	
	function GetTileColor( id )
	{
		var tileColor = "#ffff33";
		
		switch( id )
		{
			case 1:
				tileColor = "#ff3333";
				break;
			case 2:
				tileColor = "#99ccff";
				break;
			case 3:
				tileColor = "#999900";
				break;
			case 4:
				tileColor = "#0808ff";
				break;
			case 5:
				tileColor = "#990066";
				break;
			case 6:
				tileColor = "#009900";
				break;
		};
		
		return tileColor;
	}
	
	function drawTiles()
	{
		var col,row;
		var index;
		var drawTile;
		
		var i;
		
		context.strokeStyle = "black";
		
		for ( i = 0 ; i < tileCount ; i++ )
		{
			row = tiles[i].currentPos.y;
			col = tiles[i].currentPos.x;
			
			context.fillStyle = GetTileColor( tiles[i].id );
			
			if ( tiles[i].isMoving )
		    {
		        context.lineWidth = 3;
		    }
		    else
		    {
		        context.lineWidth = 1;
		    }
			
			roundRect(
							 context
							 ,xOffset + col + cellPadding
							 ,StickygameCellSize + row + cellPadding
							 ,StickygameCellSize*tiles[i].tileSize.x - 2*cellPadding
							 ,StickygameCellSize*tiles[i].tileSize.y - 2*cellPadding,
							 StickygameCellSize/8, true, true 
							 );
							 
			/*context.fillRect( boardOffset + col + cellPadding
							 ,boardOffset + row + cellPadding
							 ,StickygameCellSize*tiles[i].tileSize.x - 2*cellPadding
							 ,StickygameCellSize*tiles[i].tileSize.y - 2*cellPadding );*/

			if ( tiles[i].isLocked )
			{
				context.drawImage(imgLock, xOffset + col + ( StickygameCellSize*tiles[i].tileSize.x - gameIconSize )/2, StickygameCellSize + row + ( StickygameCellSize*tiles[i].tileSize.y - gameIconSize )/2 );							 				
			}
		}	
		
		context.lineWidth = 1;
	}
	
	function drawGrid()
	{
		var i;
		var j;
		
		//----------------------------------------------------------------------------------
		//Drawing Game Board
		
		/*context.lineWidth = 1;
		context.rect(5,5,(MAX_RANGE+1)*StickygameCellSize - 10, (MAX_RANGE+3)*StickygameCellSize - 10 );
		context.rect(10,10,(MAX_RANGE+1)*StickygameCellSize - 20, (MAX_RANGE+3)*StickygameCellSize - 20 );
		context.rect(15,15,(MAX_RANGE+1)*StickygameCellSize - 30, (MAX_RANGE+3)*StickygameCellSize - 30 );
		context.stroke();*/
		
		context.lineWidth = 1;
		context.fillStyle="#bbada0";
		roundRect( context, xOffset, StickygameCellSize, sizeX*StickygameCellSize, sizeY*StickygameCellSize, StickygameCellSize/8, true, true );
		
		context.lineWidth = 1;
		
		//vertical lines
		for ( i = 1 ; i < sizeX ; i++ )
		{
			context.beginPath();
			context.moveTo( xOffset + i*StickygameCellSize, StickygameCellSize );
			context.lineTo( xOffset + i*StickygameCellSize, StickygameCellSize + sizeY*StickygameCellSize);
			context.stroke();
		}
		
		//horizontal lines
		for ( i = 1 ; i < sizeY ; i++ )
		{
			context.beginPath();
			context.moveTo( xOffset, ( i + 1)*StickygameCellSize );
			context.lineTo( xOffset + sizeX*StickygameCellSize, ( i + 1)*StickygameCellSize );
			context.stroke();
		}
		

		//----------------------------------------------------------------------------------
		//Drawing Navigation Items
		
		//vertical lines
		for ( i = 0 ; i <= gameNavItems ; i++ )
		{
			/*context.beginPath();
			context.moveTo( StickygameCellSize/2 + i*navCellWidth, navBarTop );
			context.lineTo( StickygameCellSize/2 + i*navCellWidth, navBarTop + gameNavHeight);
			context.stroke();*/
			
			switch ( i )
			{
				case navUndo:
					context.drawImage(imgUndo, StickygameCellSize/2 + i*navCellWidth + ( navCellWidth - gameIconSize )/2, navBarTop + ( gameNavHeight - gameIconSize )/2 );							 				
					break;
					
				case navSelector:
					context.drawImage(imgSelector, StickygameCellSize/2 + i*navCellWidth + ( navCellWidth - gameIconSize )/2, navBarTop + ( gameNavHeight - gameIconSize )/2 );							 				
					break;
					
				case navHome:
					context.drawImage(imgHome, StickygameCellSize/2 + i*navCellWidth + ( navCellWidth - gameIconSize )/2, navBarTop + ( gameNavHeight - gameIconSize )/2 );							 				
					break;
					
				case navReset:
					context.drawImage(imgReset, StickygameCellSize/2 + i*navCellWidth + ( navCellWidth - gameIconSize )/2, navBarTop + ( gameNavHeight - gameIconSize )/2 );							 				
					break;
					
				case navHelp:
					context.drawImage(imgHelp, StickygameCellSize/2 + i*navCellWidth + ( navCellWidth - gameIconSize )/2, navBarTop + ( gameNavHeight - gameIconSize )/2 );							 				
					break;
			}
			
		}
		
		//horizontal lines
/*		for ( i = 0 ; i <= 1 ; i++ )
		{
			context.beginPath();
			context.moveTo( boardOffset, navBarTop + i*gameNavHeight );
			context.lineTo( boardOffset + sizeX*StickygameCellSize, navBarTop + i*gameNavHeight );
			context.stroke();
		}	*/		
		
		
	}
	
	function IsInsideGrid( x , y )
	{
		//getting mouse position correctly, being mindful of resizing that may have occured in the browser:
		var bRect = theCanvas.getBoundingClientRect();
		var posX = Math.floor( (x - bRect.left)*(theCanvas.width/bRect.width) );
		var posY = Math.floor( (y - bRect.top)*(theCanvas.height/bRect.height) );
		
		if ( 
		   ( posX > xOffset ) &&
		   ( posX < xOffset + StickygameCellSize*sizeX ) &&
		   ( posY > StickygameCellSize ) &&
		   ( posY < StickygameCellSize + StickygameCellSize*sizeY )
		   )
		   {
			   return true;
		   }
		   else
		   {
			   return false;
		   }
	}
	
	function CheckNavBar( x , y )
	{
		//getting mouse position correctly, being mindful of resizing that may have occured in the browser:
		var bRect = theCanvas.getBoundingClientRect();
		var posX = Math.floor( (x - bRect.left)*(theCanvas.width/bRect.width) );
		var posY = Math.floor( (y - bRect.top)*(theCanvas.height/bRect.height) );
		var selectedItem;
		
		if ( 
		   ( posX > StickygameCellSize/2 ) &&
		   ( posX < StickygameCellSize/2 + navCellWidth*gameNavItems ) &&
		   ( posY > navBarTop ) &&
		   ( posY < navBarTop + gameNavHeight )
		   )
		   {
			   selectedItem = Math.floor((posX - StickygameCellSize/2)/navCellWidth);
			   switch ( selectedItem )
			   {
			   case navUndo:
					RestorePositionsUndo();
					requestDraw = true;
					break;
					
			   case navSelector:
					AsyncConfirmYesNo(
						"Current Level will be reset",
						"Do you want to continue?",
						levelSelectorAccept,
						levelSelectorReject
					);
					break;
					
			   case navHome:
					AsyncConfirmYesNo(
						"Current Level will be reset",
						"Do you want to continue?",
						homeAccept,
						homeReject
					);
					break;
					
			   case navReset:
					AsyncConfirmYesNo(
						"Current Level will be reset",
						"Do you want to continue?",
						resetGameAccept,
						resetGameReject
					);
					break;
					
				case navHelp:
				    helpPage = 1;
				    SetHelpPopupInfo();
			        AsyncPopupInfo();
			        break;
					
			   }
			   return selectedItem;
		   }
		   else
		   {
			   return -1;
		   }
	}
	
	function IsPositionValid( pos )
	{
		if ( ( pos.x >= 0 ) && ( pos.x < sizeX ) && ( pos.y >= 0 ) && ( pos.y < sizeY ) ) 
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	function IsTilePositionValid( tileIndex )
	{
		var isValid = true;

		var pos = new posClass( 0, 0 );

	    var x,y;
		
		for ( x = 0 ; x < tiles[ tileIndex ].tileSize.x ; x++ )
			for ( y = 0 ; y < tiles[ tileIndex ].tileSize.y ; y++ )
			{
				pos.x = tiles[ tileIndex ].pos.x + x;
				pos.y = tiles[ tileIndex ].pos.y + y;

				if ( !IsPositionValid( pos ) )
				{
					return  false;
				}
			}

		return isValid;
	}
	
	function OppositDirection( direction )
	{
		switch ( direction )
		{
			case DIRECTION_UP:
				return DIRECTION_DOWN;
				
			case DIRECTION_DOWN:
				return DIRECTION_UP;
			
			case DIRECTION_LEFT:
				return DIRECTION_RIGHT;
			
			case DIRECTION_RIGHT:
				return DIRECTION_LEFT;
			
		}
		
		console.log("OppositDirection bad input");
		return DIRECTION_UP; //just return sth, not supposed to happen
	}
	
	function FindMovingBlock( row, col, direction )
	{		
		var is_horizontal = false;
		
		if ( ( direction == DIRECTION_LEFT ) || ( direction == DIRECTION_RIGHT ) )
		{
			is_horizontal = true;
		}

		//Mark every tile as NOT visited
		ResetVisitedFlag();
		
		//Mark every tile as NOT moving
		ResetMovingFlag();
		
		// reset the movement range
		m_upper_bound = 0;
		m_lower_bound = 0;

		var queue = [];
		
		var currentTile = GetTile(touchedCell);
				
		if ( ( currentTile >= 0 ) && ( !tiles[ currentTile ].isLocked ) )
		{
			queue.push( currentTile );
			tiles[ currentTile ].isVisited = true;
		}
		
		var x,y;
		
		var canMove = true;
		
		var newTile;
		
		while ( queue.length )
		{
			currentTile = queue.shift();

			for ( x = 0 ; x < tiles[ currentTile ].tileSize.x ; x++ )
			   for ( y = 0 ; y < tiles[ currentTile ].tileSize.y ; y++ )
			   {
				    newTile = GetTileNeighbor(  tiles[ currentTile ].pos.y + y,  tiles[ currentTile ].pos.x + x, direction );				   
				   
				    if ( ( newTile >= 0 ) && (!tiles[ newTile ].isVisited) && ( !tiles[ newTile ].isLocked ) )
				    {
					   tiles[ newTile ].isVisited = true;
					   queue.push( newTile );
				    }
				   
				    if ( m_is_sticky_on )
					{
						newTile = GetTileNeighbor(  tiles[ currentTile ].pos.y + y,  tiles[ currentTile ].pos.x + x, OppositDirection( direction ) );				   
					   
						if ( ( newTile >= 0 ) && (!tiles[ newTile ].isVisited) && ( !tiles[ newTile ].isLocked ) )
						{
						   tiles[ newTile ].isVisited = true;
						   queue.push( newTile );
						}						
					}
			   }
		}
		
		// now the "visited" flag of the tiles belonging to the block is set
		//Mark every visited tile as moving
		for ( i = 0 ; i < tileCount ; i++ )
		{
			if ( tiles[i].isVisited )
			{
				tiles[i].isMoving = true;
			}
		}
			
		// now find how much this block can move
		if ( is_horizontal )
		{
			m_upper_bound = FindRange( DIRECTION_RIGHT );
			m_lower_bound = FindRange( DIRECTION_LEFT );
		}
		else
		{
			m_upper_bound = FindRange( DIRECTION_DOWN );
			m_lower_bound = FindRange( DIRECTION_UP );
		}
	}
	
	function FindRange( direction )
	{
		var delta = direction_vector[ direction ];

		var range = 0;
		
		var index;

		SavePositions();

		for ( index = 1 ; index < MAX_RANGE ; index++ )
		{
			if ( MoveTiles( delta.y*index , delta.x*index ) )
			{
				if ( !FindOverlap() )
				{	
					range = index;
				}
				else
				{ //overlap detected, jump out
					break;
				}
			}

			RestorePositions();
		}

		RestorePositions();
		
		return range;
	}
	
	function EstablishDirection()
	{
		var delta_x = Math.abs( currentPos.x - touchPos.x );
		var delta_y = Math.abs( currentPos.y - touchPos.y );

		var row,col;

		if ( Math.max( delta_x, delta_y ) >= MOVE_DETECTION_PIXELS )
		{
			if ( delta_x > delta_y )
			{
				m_move_direction = MOVE_DIRECTION_HORIZONTAL;
				row = Math.floor( touchPos.y / StickygameCellSize );
				col = Math.floor( touchPos.x / StickygameCellSize );

				if ( currentPos.x > touchPos.x )
				{
					FindMovingBlock( row, col, DIRECTION_RIGHT );
				}
				else
				{
					FindMovingBlock( row, col, DIRECTION_LEFT );
				}
			}
			else if ( delta_x < delta_y )
			{
				m_move_direction = MOVE_DIRECTION_VERTICAL;
				row = Math.floor( touchPos.y / StickygameCellSize );
				col = Math.floor( touchPos.x / StickygameCellSize );

				if ( currentPos.y > touchPos.y )
				{
					FindMovingBlock( row, col, DIRECTION_DOWN );
				}
				else
				{
					FindMovingBlock( row, col, DIRECTION_UP );
				}
			}
		}
	}
	
	this.OnMouseDown = function( x, y )
	{
		if ( IsInsideGrid( x, y ) )
		{
			//getting mouse position correctly, being mindful of resizing that may have occured in the browser:
			var bRect = theCanvas.getBoundingClientRect();
			touchPos.x = Math.floor( (x - bRect.left)*(theCanvas.width/bRect.width) )  - xOffset;
			touchPos.y = Math.floor( (y - bRect.top)*(theCanvas.height/bRect.height) ) - StickygameCellSize;

			touchedCell.x = Math.floor(( touchPos.x )/StickygameCellSize );
			touchedCell.y = Math.floor(( touchPos.y )/StickygameCellSize );
			
			if ( GetTile(touchedCell) >= 0 )
			{
				dragging = true;
			}
		}
		else 
		{
			CheckNavBar(  x, y  );
		}		
	}
	
	this.OnMouseMove = function( x, y)
	{
		if ( dragging )
		{
			if ( IsInsideGrid( x, y ) )
			{
				//getting mouse position correctly, being mindful of resizing that may have occured in the browser:
				var bRect = theCanvas.getBoundingClientRect();
				currentPos.x = Math.floor( (x - bRect.left)*(theCanvas.width/bRect.width) )  - xOffset;
				currentPos.y = Math.floor( (y - bRect.top)*(theCanvas.height/bRect.height) ) - StickygameCellSize;
				
				if ( m_move_direction == MOVE_DIRECTION_NONE )
				{
					EstablishDirection();
				}
				
				var delta;

				var move_vector = new posClass(0,0);

				if ( m_move_direction == MOVE_DIRECTION_HORIZONTAL )
				{
					delta = currentPos.x - touchPos.x;

					move_vector.y = 0;

					if ( delta > 0 )
					{
						// moving right
						if ( delta > m_upper_bound*StickygameCellSize )
						{
							move_vector.x = m_upper_bound*StickygameCellSize;
						}
						else
						{
							move_vector.x = delta;
						}
					}
					else
					{
						// moving left
						if ( delta < (-m_lower_bound)*StickygameCellSize )
						{
							move_vector.x = (-m_lower_bound)*StickygameCellSize;
						}
						else
						{
							move_vector.x = delta;
						}
					}

					MoveBlocks( move_vector );
				}
				else if ( m_move_direction == MOVE_DIRECTION_VERTICAL )
				{
					delta = currentPos.y - touchPos.y;

					move_vector.x = 0;

					if ( delta > 0 )
					{
						// moving right
						if ( delta > m_upper_bound*StickygameCellSize )
						{
							move_vector.y = m_upper_bound*StickygameCellSize;
						}
						else
						{
							move_vector.y = delta;
						}
					}
					else
					{
						// moving left
						if ( delta < (-m_lower_bound)*StickygameCellSize )
						{
							move_vector.y = (-m_lower_bound)*StickygameCellSize;
						}
						else
						{
							move_vector.y = delta;
						}
					}

					MoveBlocks( move_vector );
				}

				requestDraw = true;
			}
			else
			{
				//moved out, as if mouse button is up
				this.OnMouseUp();
			}
		}
	}
	
	this.OnMouseUp = function()
	{
		var delta_x_units = 0;
		var delta_y_units = 0;
		
		if (dragging) 
		{
			//document.getElementById('audiotagmove').play();
			
			switch ( m_move_direction )
			{
			case MOVE_DIRECTION_HORIZONTAL:

				delta_x_units = Math.floor( ( currentPos.x - touchPos.x + StickygameCellSize/2 ) / StickygameCellSize );

				// must be in range
				if ( delta_x_units > m_upper_bound )
				{
					delta_x_units = m_upper_bound;
				}
				else if ( delta_x_units < (-m_lower_bound) )
				{
					delta_x_units = (-m_lower_bound);
				}

				break;

			case MOVE_DIRECTION_VERTICAL:

				delta_y_units = Math.floor( ( currentPos.y - touchPos.y + StickygameCellSize/2 ) / StickygameCellSize );

				// must be in range
				if ( delta_y_units > m_upper_bound )
				{
					delta_y_units = m_upper_bound;
				}
				else if ( delta_y_units < (-m_lower_bound) )
				{
					delta_y_units = (-m_lower_bound);
				}

				break;
			}

            if ( ( delta_y_units ) || ( delta_x_units ) )
            {
			    SavePositionsUndo();
			    moveCount++;
			}
			
			MoveTiles( delta_y_units, delta_x_units );
		}
		ResetMovingFlag();
		dragging = false;
		
		m_is_moving = false;

		m_move_direction = MOVE_DIRECTION_NONE;

		m_upper_bound = 0;
		m_lower_bound = 0;
		
		requestDraw = true;
		
		if ( IsSolved() )
		{
			//document.getElementById('audiotagwin').play();
			fb.setCurrentUserLevel( currentLevel );
			
			if ( fb.user.get("id") !== "" )
			{
				fb.gameDataSave.set("userLevel", currentLevel );
				fb.gameDataSave.set("gameID", gameId );
				fb.gameDataSave.set("userID", fb.user.get("id") );
				fb.gameDataSave.set("score", moveCount );

				fb.gameDataSave.save();
			}
			else
			{
				//this is a guest
				fb.gameDataSave.set("userLevel", currentLevel );
				fb.gameDataSave.set("gameID", gameId );
				fb.gameDataSave.set("userID", 1 );
				fb.gameDataSave.set("score", 100 );		
				fb.gameDataSave.save();
			}
			
			
			if ( currentLevel < fb.getCurrentMaxLevel() )
			{
				AsyncConfirmYesNo(
					"Great Job! You have completed level " + (currentLevel + 1) + " successfully.",
					"Do you want to play the next level?",
					gameWinAccept,
					gameWinReject
				);
			}
			else
			{
				AsyncConfirmYesNo(
					"Great Job! You have completed all levels!",
					"We will provide more levels for you soon.",
					gameWinAccept,
					gameWinReject
				);
			}
		}		
	}

	function AsyncConfirmYesNo(title, msg, yesFn, noFn) {
		var $confirm = $("#modalConfirmYesNo");
		$confirm.modal('show');
		$("#lblTitleConfirmYesNo").html(title);
		$("#lblMsgConfirmYesNo").html(msg);
		$("#btnYesConfirmYesNo").off('click').click(function () {
			yesFn();
			$confirm.modal("hide");
		});
		$("#btnNoConfirmYesNo").off('click').click(function () {
			noFn();
			$confirm.modal("hide");
		});
	}
	
	function AsyncShareDialog() {
	    if ( fb.user.get("hasShared") == 0 )
	    {
		    var $confirm = $("#modalShareDialog");
		    $confirm.modal('show');
		    $("#btnYesShareDialog").off('click').click(function () {
			    fbShare();
			    $confirm.modal("hide");
		    });
		    $("#btnNoShareDialog").off('click').click(function () {
			    $confirm.modal("hide");
		    });
		}
	}
	
	function AsyncPopupInfo() {
		var $confirm = $("#modalPopupInfo");
		$confirm.modal('show');
		$("#btnNoPopupInfo").off('click').click(function () {
		    $("#lblMsgPopupInfo").html("");
			$confirm.modal("hide");
		});
		$("#btnPrev").off('click').click(function () {
			helpPage--;
			SetHelpPopupInfo();
		});
		$("#btnNext").off('click').click(function () {
			helpPage++;
			SetHelpPopupInfo();
		});
	}
	
	function SetHelpPopupInfo()
	{
	    switch ( helpPage )
	    {
	    case 1:
    		$("#lblTitlePopupInfo").html("Sort the tiles vertically to win");
    		$("#btnPrev").addClass('hidden');
    		$("#btnNext").removeClass('hidden');
    		$("#lblMsgPopupInfo").html("<p align='center'><img src='img/StickyHelp2.png'></p>")
	        break;
	        
	    case 2:
    		$("#lblTitlePopupInfo").html("When you move a tile horizontally or vertically, all the neighboring tiles will move as well");
    		$("#btnPrev").removeClass('hidden');
    		$("#btnNext").removeClass('hidden');
    		$("#lblMsgPopupInfo").html("<p align='center'><img src='img/StickyHelp.png'></p>")
	        break;
	        
	    case 3:
    		$("#lblTitlePopupInfo").html("<img src='img/lock.png'>Locks");
    		$("#btnPrev").removeClass('hidden');
    		$("#btnNext").addClass('hidden');
    		$("#lblMsgPopupInfo").html("<p align='center'>Locked tiles do not move!, level 25 & up</p>")
	        break;
	    }
	}	

	function resetGameAccept() {
		loadGame( currentLevel );
	}

	function resetGameReject() {
		//do nothing
	}	
	
	function levelSelectorAccept()
	{
		window.location.href = "#selectlevel";
	}
	
	function levelSelectorReject()
	{
		//do nothing
	}
	
	function gameWinAccept()
	{
		if ( currentLevel < fb.getCurrentMaxLevel() )
		{
			currentLevel++;
		}
		
		fb.UpdateCurrentLevel( currentLevel );
		
		loadGame(currentLevel);
	}
	
	function gameWinReject()
	{
		//do nothing
	}

	function homeAccept()
	{
		window.location.href = "#";
	}
	
	function homeReject()
	{
		//do nothing
	}
	
	
}	


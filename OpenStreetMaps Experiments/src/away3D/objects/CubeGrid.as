package away3D.objects
{
	import away3d.containers.ObjectContainer3D;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.ShadingColorMaterial;
	import away3d.primitives.Cube;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import gs.TweenMax;
	import gs.easing.Back;
	
	public class CubeGrid extends ObjectContainer3D
	{
		
		// Will hold our grid
		public var grid:Vector.<Cube>;
		public var gridMapMaterials:Vector.<GridCubeMaterial>;
		
		// Will hold all the cubes from our grid
		public var cubes:ObjectContainer3D;
		
		private var defaultMaterial:ShadingColorMaterial;
		
		// holds bitmap data info to create the tiles on the cubes
		private var map:BitmapData;
		private var tile:Rectangle;
		
		private var gridColumns:uint;
		private var gridRows:uint;
		
		public function CubeGrid()
		{
			super();
			
			cubes = new ObjectContainer3D;
			addChild(cubes);
			
			grid = new Vector.<Cube>;
			gridMapMaterials = new Vector.<GridCubeMaterial>;
		}
		
		public function createGrid(rows:uint, columns:uint, width:uint, height:uint, padding:uint):void
		{			
			
			gridColumns = columns;
			gridRows = rows;
			
			defaultMaterial = new ShadingColorMaterial(0x999999);
			
			for(var c:uint = 0; c < columns; ++c)
			{
				for(var r:uint = 0; r < rows; ++r)
				{
					
					var cube:Cube = new Cube();
					cube.width = width; 
					cube.height = cube.depth = height;
					
					cube.material = new ShadingColorMaterial(0xFF0000 * (grid.length));
					
					var frontMaterial:GridCubeMaterial = new GridCubeMaterial(new BitmapData(width, height, false));
					frontMaterial.column = c;
					frontMaterial.row = r;
					
					cube.cubeMaterials.front = frontMaterial;
					
					cube.x = (c * width) + (c * padding);
					cube.y -= (r * height) + (r * padding);
					
					cube.rotationY = 180;
					
					grid.push(cube);
					gridMapMaterials.push(cube.cubeMaterials.front);
					
					cubes.addChild(cube);
				}
			}
			
			cubes.x -= (((columns-1) * (width + padding))) * .5;
			cubes.y = (((rows-1) * (height + padding))) * .5;
			
			tile = new Rectangle(0, 0, width, height);
			map = new BitmapData(columns * width, rows * height, false);
			
		}
		
		public function updateGridMaterials(bitmapData:BitmapData):void
		{
			// sets the bitmapdata from the map
			map = bitmapData;
			// updates the cube's front materials
			gridMapMaterials.forEach(updateGridTiles);
		}
		
		public function spinGrid():void
		{
			//spins the cubes 360
			grid.forEach(gridCubesSpin);
		}
		
		private function updateGridTiles(item:GridCubeMaterial, index:int, vector:Vector.<GridCubeMaterial>):void
		{
			
			var bounds:Rectangle = new Rectangle(item.column * tile.width, item.row * tile.height, tile.width, tile.height);
			
			var bmd:BitmapData = new BitmapData(tile.width, tile.height, false);
			bmd.copyPixels(map, bounds, new Point(0, 0));
			
			item.bitmap = bmd;
			
			//trace(bounds);
			//trace("column " + item.column);
			//trace("row " + item.row);
		}
		
		private function gridCubesSpin(item:Cube, index:int, vector:Vector.<Cube>):void
		{
			if(!TweenMax.isTweening(item)){
				TweenMax.to(item, 1, {rotationY: item.rotationY*-1, delay: index/40, ease: Back.easeOut});
			}
		}
	}
}
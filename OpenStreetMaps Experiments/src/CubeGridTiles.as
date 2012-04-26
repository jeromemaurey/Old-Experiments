package
{
	import com.modestmaps.TweenMap;
	import com.modestmaps.events.MapEvent;
	import com.modestmaps.extras.MapControls;
	import com.modestmaps.geo.Location;
	import com.modestmaps.mapproviders.OpenStreetMapProvider;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.system.Security;
	
	import gs.TweenMax;
	import gs.plugins.ColorMatrixFilterPlugin;
	import gs.plugins.TweenPlugin;
	
	import map3DTests.OSMCubeGridScene;
	
	import net.hires.debug.Stats;
	
	[SWF(backgroundColor="#ffffff", frameRate="30", quality="HIGH", width="800", height="480")]
	
	public class CubeGridTiles extends Sprite
	{
		
		// CONSTANTS
		private const PARIS:Location = new Location(48.85341, 2.3488);
		
		private const COLUMNS:uint = 4;
		private const ROWS:uint = 8;
		
		private const WIDTH:uint = 400;
		private const HEIGHT:uint = 300;
		
		private const CUBE_WIDTH:uint = Math.floor(WIDTH/COLUMNS);
		private const CUBE_HEIGHT:uint = Math.floor(HEIGHT/ROWS);
		
		private const PADDING:uint = 4;
		
		// MAP VARS
		private var provider:OpenStreetMapProvider;
		
		private var map:TweenMap;
		private var mapContainer:Sprite;
		
		// 3D VARS
		private var basic3Dscene:OSMCubeGridScene;
		
		// CONTAINER FOR RECYCLING
		private var bitmapData:BitmapData;
		
		public function CubeGridTiles()
		{
			TweenPlugin.activate([ColorMatrixFilterPlugin]);
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true);
		}
		
		
		private function addedToStageHandler(e:Event):void
		{
			
			// Cross-domain security
			Security.loadPolicyFile("http://tile.openstreetmap.org/crossdomain.xml");
			
			// SIGNATURE
			var signature:SignatureSprite = new SignatureSprite;
			signature.y = stage.stageHeight;
			addChild(signature);
			
			// MAP
			// create the container
			mapContainer = new Sprite;
			mapContainer.scaleX = mapContainer.scaleY = .8;
			mapContainer.y = stage.stageHeight *.5;
			
			addChild(mapContainer);
			
			// create our OSM provider
			provider = new OpenStreetMapProvider();

			// create our map 
			map = new TweenMap(WIDTH, HEIGHT, true, provider);
			// add default controls
			map.addChild( new MapControls( map ) );
			map.setCenterZoom(PARIS, 16);
			//map.visible = false;
			mapContainer.addChild(map);
			map.y -= HEIGHT * .5;
			map.x = 20;
			
			TweenMax.to(map, 1, {colorMatrixFilter:{saturation:0}});
			
			map.filters = [new DropShadowFilter(2, 90, 0, 1, 10, 10, 1, 2)];
			
			// holds the map's bitmap data
			bitmapData = new BitmapData(WIDTH, HEIGHT, false);
			
			
			//3D
			basic3Dscene = new OSMCubeGridScene();
			addChild(basic3Dscene);
			basic3Dscene.init();
			basic3Dscene.initGrid(ROWS, COLUMNS, CUBE_WIDTH, CUBE_HEIGHT, PADDING);
			basic3Dscene.y = stage.stageHeight *.5;
			basic3Dscene.x = 500;
			
			basic3Dscene.start();
			basic3Dscene.filters = [new DropShadowFilter(15, 45, 0, 1, 30, 30, 1, 2)];
			
			// adds proper listner(s)
			map.addEventListener(MapEvent.RENDERED, mapRenderedHandler, false, 0, true);
			map.addEventListener(MapEvent.START_ZOOMING, spinHandler, false, 0, true);
			
			var stats:Stats = new Stats();
			addChild(stats);
			
		}
		
		
		private function mapRenderedHandler(e:MapEvent):void
		{
			
			if(!basic3Dscene.cubeGrid) return;
			
			bitmapData.draw(map.grid);
			basic3Dscene.cubeGrid.updateGridMaterials(bitmapData);
		}
		
		private function spinHandler(e:MapEvent):void
		{
			basic3Dscene.cubeGrid.spinGrid();
		}
		
	}
}
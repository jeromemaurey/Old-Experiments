package
{
	import com.modestmaps.TweenMap;
	import com.modestmaps.events.MapEvent;
	import com.modestmaps.extras.MapControls;
	import com.modestmaps.geo.Location;
	import com.modestmaps.mapproviders.OpenStreetMapProvider;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	
	import gs.TweenMax;
	import gs.plugins.ColorMatrixFilterPlugin;
	import gs.plugins.TweenPlugin;
	
	import net.hires.debug.Stats;
	
	[SWF(backgroundColor="#ffffff", frameRate="30", quality="HIGH", width="800", height="480")]
	
	public class Pixalate extends Sprite
	{
		// CONSTANTS
		private const PARIS:Location = new Location(48.85341, 2.3488);
		
		private const WIDTH:uint = 400;
		private const HEIGHT:uint = 300;
		
		// MAP VARS
		private var provider:OpenStreetMapProvider;
		private var map:TweenMap;
		private var mapContainer:Sprite;
		
		// CONTAINER FOR RECYCLING
		private var bitmapData:BitmapData;
		private var tempBitmapData:BitmapData;
		private var bitmap:Bitmap;
		private var pixelateMatrix:Matrix;
		
		public function Pixalate()
		{
			TweenPlugin.activate([ColorMatrixFilterPlugin]);
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true);
		}
		
		
		private function addedToStageHandler(e:Event):void
		{
			
			// Cross-domain security
			//Security.loadPolicyFile("http://tile.openstreetmap.org/crossdomain.xml");
			
			// SIGNATURE
			var signature:SignatureSprite = new SignatureSprite;
			signature.y = stage.stageHeight;
			addChild(signature);
			
			// MAP
			// create the container
			mapContainer = new Sprite;
			mapContainer.scaleX = mapContainer.scaleY = .6;
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
			
			TweenMax.to(map.grid, 1, {colorMatrixFilter:{colorize: 0x3317326, contrast: 2}});
			
			map.filters = [new DropShadowFilter(2, 90, 0, 1, 10, 10, 1, 2)];
			
			// holds the map's bitmap data
			bitmapData = new BitmapData(WIDTH, HEIGHT, false);
			bitmap = new Bitmap(bitmapData);
			
			bitmap.x = (stage.stageWidth - WIDTH);
			bitmap.y = (stage.stageHeight - HEIGHT) * .5;
			
			addChild(bitmap);
			
			pixelateMatrix = new Matrix();
			
			// adds proper listner(s)
			map.addEventListener(MapEvent.RENDERED, mapRenderedHandler, false, 0, true);
			
			var stats:Stats = new Stats();
			addChild(stats);
			
		}
		
		
		private function mapRenderedHandler(e:MapEvent):void
		{
			
			pixelate(map.grid, bitmapData, 2, 6);

		}
		
		private function pixelate(source:DisplayObject, bmd:BitmapData, amountX:Number, amountY:Number):void
		{
			var scaleFactorX:Number = 1/amountX;
			var scaleFactorY:Number = 1/amountY;
			
			pixelateMatrix.identity();
			pixelateMatrix.scale(scaleFactorX, scaleFactorY);
			
			tempBitmapData = new BitmapData(scaleFactorX * source.width, scaleFactorY * source.height, false);
			tempBitmapData.draw(source, pixelateMatrix);
			
			pixelateMatrix.identity();
			pixelateMatrix.scale(amountX, amountY);
			
			bmd.draw(tempBitmapData, pixelateMatrix);
		}
		
	}
}
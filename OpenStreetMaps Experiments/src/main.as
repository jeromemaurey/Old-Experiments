package
{
	import com.pixelbreaker.ui.osx.MacMouseWheel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	
	import map3DTests.OSMPlaneScene;
	import map3DTests.OSMCubeScene;
	
	[SWF(backgroundColor="#3b3e44", frameRate="30", quality="HIGH", width="800", height="480")]
	
	public class main extends Sprite
	{
		
		private var osm3D:OSMCubeScene;
		
		public function main()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true);
		}
		
		
		private function addedToStageHandler(e:Event):void
		{
			
			// Cross-domain security
			Security.loadPolicyFile("http://tile.openstreetmap.org/crossdomain.xml")

				
			MacMouseWheel.setup(this.stage);
			
			// Cleanup!
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			// Startup!
			osm3D = new OSMCubeScene();
			addChild(osm3D);
			osm3D.init();
			osm3D.resize();
			osm3D.start();
			
		}
	}
}
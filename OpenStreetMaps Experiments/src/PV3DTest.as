package
{
	import com.pixelbreaker.ui.osx.MacMouseWheel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	
	import map3DTests.OSMPV3DScene;
	
	import org.papervision3d.cameras.CameraType;

	
	[SWF(backgroundColor="#3b3e44", frameRate="30", quality="HIGH", width="800", height="480")]
	
	public class PV3DTest extends Sprite
	{
		
		private var osmPV3D:OSMPV3DScene;
		
		public function PV3DTest()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true);
		}
		
		
		private function addedToStageHandler(e:Event):void
		{
			
			// Cross-domain security
			Security.loadPolicyFile("http://tile.openstreetmap.org/crossdomain.xml")
			
			
			MacMouseWheel.setup(this.stage);
			
			osmPV3D =  new OSMPV3DScene(800, 480, true, false, CameraType.TARGET);
			addChild(osmPV3D);
			
			osmPV3D.init();
			osmPV3D.startRendering();
			
			
			
			// Cleanup!
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			
		}
	}
}
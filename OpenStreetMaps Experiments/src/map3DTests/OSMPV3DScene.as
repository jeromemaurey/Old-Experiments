package map3DTests
{
	import com.modestmaps.Map;
	import com.modestmaps.extras.MapControls;
	import com.modestmaps.geo.Location;
	import com.modestmaps.mapproviders.OpenStreetMapProvider;
	
	import flash.events.Event;
	
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	public class OSMPV3DScene extends BasicView
	{
		
		private var plane:Plane;
		private var map:Map;
		
		public function OSMPV3DScene(viewportWidth:Number=640, viewportHeight:Number=480, scaleToStage:Boolean=true, interactive:Boolean=false, cameraType:String="Target")
		{
			super(viewportWidth, viewportHeight, scaleToStage, interactive, cameraType);
		}
		
		public function init():void
		{
			//Set the background to black
			opaqueBackground = 0;
			
			//Create the pano material
			map = new Map(400, 400, true, new OpenStreetMapProvider);
			map.setCenterZoom(new Location(48.85341, 2.3488), 10);
			map.addChild( new MapControls(map));
			
			addChild(map);
			
			var mat:MovieMaterial = new MovieMaterial(map, true);
			mat.animated = true;
			mat.interactive = true;
			mat.doubleSided = true;
			
			//Smooth is heavy, but it makes stuff look nicer...you could make it switch dynamically.
			mat.smooth = true;
			
			//Create the panosphere.
			plane = new Plane(mat, 400, 400, 8, 8);
			scene.addChild(plane);
			
			removeChild(map);
			
			//position the camera in the center of the sphere, and set it's properties for focus and zoom.
			camera.z = -500;
			camera.focus = 300;
			camera.zoom = 2;
			
		}
		
		override protected function onRenderTick(event:Event=null):void
		{
			plane.rotationY++;
			//plane.rotationX++;
			//Render as usual
			super.onRenderTick(event);
		}
	}
}
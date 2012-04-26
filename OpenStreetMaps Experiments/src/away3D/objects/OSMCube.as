package away3D.objects
{
	import away3d.containers.ObjectContainer3D;
	import away3d.core.utils.Cast;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MovieMaterial;
	import away3d.primitives.Cube;
	import away3d.primitives.Plane;
	import away3d.primitives.data.CubeMaterialsData;
	
	import com.modestmaps.Map;
	import com.modestmaps.events.MapEvent;
	import com.modestmaps.extras.MapControls;
	import com.modestmaps.geo.Location;
	import com.modestmaps.mapproviders.OpenStreetMapProvider;

	
	public class OSMCube extends ObjectContainer3D
	{
		

		[Embed (source = "assets/images/Shadow-256.png")]
		private var Shadow:Class;
		
		private var provider:OpenStreetMapProvider;
		
		private var front:Map;
		private var left:Map;
		private var back:Map;
		private var right:Map;
		
		private var cube:Cube;
		
		public function OSMCube(...parameters)
		{
			super(parameters);
		}
		
		public function init(size:uint = 400):void
		{
			
			var shadow:Plane = new Plane(
				{
					material: new BitmapMaterial( Cast.bitmap( new Shadow() ) ),
					width: size*1.8,
					height: size*1.8,
					y: -size/2 - 40
				}
			);
			
			
			addChild(shadow);
			
			// Maps
			// Set up a provider
			provider = new OpenStreetMapProvider();
			
			// Paris
			front 	= new Map(size, size, true, provider);
			front.setCenterZoom(new Location(48.85341, 2.3488), 10);
			front.addChild(new MapControls(front));
			
			// NYC
			left 	= new Map(size, size, true, provider);
			left.setCenterZoom(new Location(40.71427, -74.00597), 11);
			left.addChild(new MapControls(left));
			
			// Tokyo
			back 	= new Map(size, size, true, provider);
			back.setCenterZoom(new Location(35.68953, 139.69168), 9);
			back.addChild(new MapControls(back));
			
			//Moscow
			right 	= new Map(size, size, true, provider);
			right.setCenterZoom(new Location(55.75222, 37.61556), 12);
			right.addChild(new MapControls(right));
			
			// Cube
			var cubeMat:CubeMaterialsData = new CubeMaterialsData();
			cubeMat.front 	= new MovieMaterial(front, {interactive: true, smooth: true});
			cubeMat.left 	= new MovieMaterial(left, {interactive: true, smooth: true});
			cubeMat.back 	= new MovieMaterial(back, {interactive: true, smooth: true});
			cubeMat.right 	= new MovieMaterial(right, {interactive: true, smooth: true});
			cubeMat.top 	= cubeMat.bottom = new ColorMaterial(0xffffff);
			
			cube = new Cube();
			cube.segmentsH = cube.segmentsW = 6;
			
			cube.width = cube.height = cube.depth = size;
			cube.cubeMaterials = cubeMat;
			cube.rotationY = 180;
			
			addChild(cube);
		}
	}
}
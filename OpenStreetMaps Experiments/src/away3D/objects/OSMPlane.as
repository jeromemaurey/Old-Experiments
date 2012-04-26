package away3D.objects
{
	import away3d.containers.ObjectContainer3D;
	import away3d.materials.MovieMaterial;
	import away3d.primitives.Plane;
	
	import com.modestmaps.Map;
	import com.modestmaps.extras.MapControls;
	import com.modestmaps.geo.Location;
	import com.modestmaps.mapproviders.OpenStreetMapProvider;
	
	import flash.events.MouseEvent;
	
	public class OSMPlane extends ObjectContainer3D
	{
		
		public var map:Map;
		public var plane:Plane;
		
		public function OSMPlane(...parameters)
		{
			super(parameters);
		}
		
		public function init():void
		{
			map = new Map(400, 400, true, new OpenStreetMapProvider());
			
			map.addEventListener(MouseEvent.MOUSE_WHEEL, map.onMouseWheel);
			
			map.addChild(new MapControls(map));
			
			plane = new Plane(
				{
					material: new MovieMaterial(map, {interactive:true, smooth:true}),
					width: 400,
					height:400,
					bothsides: true
				}
			);
			
			addChild(plane);
		}
	}
}
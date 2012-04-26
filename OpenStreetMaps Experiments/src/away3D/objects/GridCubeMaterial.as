package away3D.objects
{
	import away3d.materials.BitmapMaterial;
	
	import flash.display.BitmapData;
	
	public class GridCubeMaterial extends BitmapMaterial
	{
		
		public var row:uint;
		public var column:uint;
		
		public function GridCubeMaterial(bitmap:BitmapData, init:Object=null)
		{
			super(bitmap, init);
		}
	}
}
package away3D.objects
{
	import away3d.containers.ObjectContainer3D;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.PhongBitmapMaterial;
	import away3d.primitives.Plane;
	
	import com.as3dmod.ModifierStack;
	import com.as3dmod.modifiers.Perlin;
	import com.as3dmod.plugins.away3d.LibraryAway3d;
	
	import flash.display.BitmapData;
	
	public class WavePlane extends ObjectContainer3D
	{
		
		private var phongMaterial:PhongBitmapMaterial;
		
		private var bitmapMaterial:BitmapMaterial;
		
		private var plane:Plane;
		
		private var mstack:ModifierStack;
		
		public function WavePlane(...parameters)
		{
			super(parameters);
		}
		
		public function init(w:uint, h:uint):void
		{
			
			// Bitmap data used to store the map's capture
			phongMaterial = new PhongBitmapMaterial(new BitmapData( w, h, false, 0xff0000));
			bitmapMaterial = new BitmapMaterial(new BitmapData( w, h, false, 0xff0000));
			
			// 3D plane
			plane = new Plane();
			plane.bothsides = true;
			plane.segmentsH = plane.segmentsW = 8;
			plane.width = w;
			plane.height = h;
			plane.material = bitmapMaterial;
			plane.rotationX = 10;
			
			addChild(plane);
			
			// Modifier
			mstack = new ModifierStack(new LibraryAway3d, plane);
			//mstack.addModifier( new Bend(-.4) );
			//mstack.addModifier( new Bend(-1) );
			mstack.addModifier( new Perlin(.2) );
			
		}
		
		public function applyModifier():void
		{
			mstack.apply();
		}
		
		public function updatePlaneMaterial(bmd:BitmapData):void
		{
			bitmapMaterial.bitmap = bmd;
			//phongMaterial = new PhongBitmapMaterial(bmd);
			//phongMaterial.shininess = 40;
			
			//plane.material = phongMaterial;
		}
	}
}
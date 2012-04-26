package map3DTests
{
	import away3D.Basic3DScene;
	import away3D.objects.OSMPlane;
	
	public class OSMPlaneScene extends Basic3DScene
	{
		
		public var osmPlane:OSMPlane;
		
		public function OSMPlaneScene()
		{
			super();
		}
		
		override public function init() : void
		{
			super.init();
			
			osmPlane = new OSMPlane();
			add3DObject(osmPlane);
			osmPlane.init();
			osmPlane.rotationX = 90;
		}
		
		override protected function onPreRender() : void
		{
			osmPlane.rotationY += .1;
		}
	}
}
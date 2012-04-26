package map3DTests
{
	import away3D.Basic3DScene;
	import away3D.objects.OSMCube;
	
	import away3d.core.math.Number3D;

	public class OSMCubeScene extends Basic3DScene
	{
		
		private var cube:OSMCube;
		
		public function OSMCubeScene()
		{
			super();
		}
		
		override public function init() : void
		{
			super.init();
			
			camera.z = -1200;
			camera.y = 400;
			camera.lookAt(new Number3D(0, 0, 0));
			
			cube = new OSMCube;
			add3DObject(cube);
			cube.init(300);
		}
		
		override protected function onPreRender() : void
		{
			cube.rotationY += .2;
		}
	}
}
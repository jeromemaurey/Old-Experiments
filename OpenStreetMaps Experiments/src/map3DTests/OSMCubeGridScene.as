package map3DTests
{
	import away3D.Basic3DScene;
	import away3D.objects.CubeGrid;
	
	import away3d.core.math.Number3D;
	
	public class OSMCubeGridScene extends Basic3DScene
	{
		
		public var cubeGrid:CubeGrid;
		
		public function OSMCubeGridScene()
		{
			super();
		}
		
		override public function init() : void
		{
			super.init();
			
			camera.z = -800;
			camera.lookAt( new Number3D( 0, 0, 0 ) );
			
			light.x = 400;
		}
		
		public function initGrid(rows:uint, columns:uint, width:uint, height:uint, padding:uint):void
		{
			cubeGrid = new CubeGrid();
			cubeGrid.createGrid(rows, columns, width, height, padding);
			cubeGrid.rotationY = 30;
			add3DObject(cubeGrid);
		}
		
		override protected function onPreRender() : void
		{
			//cubeGrid.rotationY += .1;
		}
	}
}
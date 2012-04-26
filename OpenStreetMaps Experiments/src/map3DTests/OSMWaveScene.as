package map3DTests
{
	import away3D.Basic3DScene;
	import away3D.objects.WavePlane;
	
	import away3d.core.math.Number3D;
	import away3d.core.render.Renderer;
	
	public class OSMWaveScene extends Basic3DScene
	{
		
		public var wavePlane:WavePlane;
		
		public function OSMWaveScene()
		{
			super();
		}
		
		override public function init():void
		{
			super.init();
			
			camera.z = -600;
			camera.x = -200;
			camera.y = 600;
			camera.lookAt( new Number3D(0, 0, 0) );
			
			
			light.position = camera.position;
			
		}
		
		public function initWave(w:uint, h:uint):void
		{
			wavePlane = new WavePlane;
			wavePlane.init(w, h);
			add3DObject(wavePlane);
		}
		
		
		override protected function onPreRender() : void
		{
			
			wavePlane.applyModifier();
			//wavePlane.rotationX += .2;
			wavePlane.rotationY += .2;
		}
	}
}
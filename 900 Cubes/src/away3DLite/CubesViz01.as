package away3DLite
{
	import away3dlite.containers.ObjectContainer3D;
	import away3dlite.materials.ColorMaterial;
	import away3dlite.primitives.Cube6;
	import away3dlite.templates.BasicTemplate;
	
	import com.leebrimelow.utils.Math2;
	
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import gs.TweenLite;
	
	import hype.extended.behavior.FunctionTracker;
	import hype.extended.layout.GridLayout;
	import hype.framework.sound.SoundAnalyzer;
	
	public class CubesViz01 extends BasicTemplate
	{
		
		private var origin:Vector3D = new Vector3D(0,0,0);
		
		public var soundAnalyzer:SoundAnalyzer;
		public var sound:Sound;
		public var layout:GridLayout;
		public var cubeContainer:ObjectContainer3D;
		
		
		public function CubesViz01()
		{
			super();
		}
		
		public function init():void
		{
			
			// hide Away3DLite stats
			debug = true;
			
			// init our sound object
			sound = new Sound();
			sound.load( new URLRequest( "assets/sounds/magenta2.mp3" ) );
			sound.play();
			
			// init the HYPE sound analyzer
			soundAnalyzer = new SoundAnalyzer();
			soundAnalyzer.start();
			
			// init the layout grid
			layout = new GridLayout(-900, -175, 30, 30, 60);
			
			// this will hold all the cubes
			cubeContainer = new ObjectContainer3D();
			view.scene.addChild(cubeContainer);
			
			// position and target the camera
			camera.z = -2000;
			camera.x = -1600;
			camera.y = 400;
			camera.lookAt( origin );
			
			// create the 900 cubes
			createCubes();
			
			// start the update camera behavior
			moveCamera();
		}
		
		private function createCubes():void
		{
			
			for(var i:uint = 0; i < 900; ++i){
				
				var cube:Cube6 = new Cube6( new ColorMaterial( 0x00 * Math.random(), .5 ), 25, 25, 25);
				
				layout.applyLayout(cube);
				
				var baseFrequency:uint = (i % 64)*4;
				
				var xScaleTracker:FunctionTracker = new FunctionTracker(cube, "scaleX", soundAnalyzer.getFrequencyRange, [baseFrequency, baseFrequency+4, .05, 3]);
				var yScaleTracker:FunctionTracker = new FunctionTracker(cube, "scaleY", soundAnalyzer.getFrequencyRange, [baseFrequency, baseFrequency+4, .05, 3]);
				var zScaleTracker:FunctionTracker = new FunctionTracker(cube, "scaleZ", soundAnalyzer.getFrequencyRange, [baseFrequency, baseFrequency+4, .05, 3]);
				
				xScaleTracker.start();
				yScaleTracker.start();
				zScaleTracker.start();
				
				cubeContainer.addChild(cube);
				
			}
		}
		
		private function moveCamera():void
		{
			
			var x:int = Math2.rand(-1200, 1200);
			var y:int = Math2.rand(-1200, 1200);
			var z:int = Math2.rand(-2000, 2000);
			
			TweenLite.to
				(
					camera, 
					4, 
					{
						x: x,
						y: y,
						z: z,
						delay: 2,
						onComplete: moveCamera,
						onUpdate: onCameraMove
					}
				);
			
			TweenLite.to
				(
					origin,
					4,
					{
						x: Math2.rand(-400, 400),
						y: Math2.rand(-100, 100),
						delay: 2	
					}
				);
					
				
				
		}
		
		private function onCameraMove():void
		{
			camera.lookAt( origin );
		}
		
		
		override protected function onPreRender() : void
		{
			cubeContainer.rotationY += .1;
			//cubeContainer.rotationX++;
		}
		
	}
}
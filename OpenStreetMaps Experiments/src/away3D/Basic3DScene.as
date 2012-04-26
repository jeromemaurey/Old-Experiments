package away3D
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.core.math.Number3D;
	import away3d.lights.DirectionalLight3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Basic3DScene extends Sprite
	{
		
		//  The scene object used in the template.
		public var scene:Scene3D;
		
		// The camera object used in the template.
		public var camera:Camera3D;
		
		// The view object used in the template.
		public var view:View3D;
		
		// light used for shading
		public var light:DirectionalLight3D;
		
		public function Basic3DScene()
		{
			super();
		}
		
		public function init():void
		{
			//init scene
			scene = new Scene3D();
			
			//init camera
			camera = new Camera3D();
			camera.z = -1000;
			camera.lookAt(new Number3D(0, 0, 0));
			
			//init view
			view = new View3D();
			view.scene = scene;
			view.camera = camera;
			
			//add view to the displaylist
			addChild(view);
			
			// init the main light
			light = new DirectionalLight3D({color:0xffffff, ambient:.25, diffuse:.75, specular:.9});
			light.position = new Number3D(0, 1000, -200);
			add3DObject( light );
		}
		
		// adds a 3D Object to the scene
		public function add3DObject(child:Object3D):void
		{
			view.scene.addChild(child);
		}
		
		// centers the 3D Scene
		public function resize():void
		{
			view.x = stage.stageWidth * .5;
			view.y = stage.stageHeight * .5;
		}
		
		// Starts the view rendering.
		public function start():void
		{
			addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
		}
		
		// Stops the view rendering.
		public function stop():void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		
		private function enterFrameHandler(e:Event):void
		{
			onPreRender();
			view.render();
			onPostRender();
		}
		
		
		protected function onPreRender() : void
		{
			
			
		}
		
		protected function onPostRender():void
		{	
			
			
		}
	}
}
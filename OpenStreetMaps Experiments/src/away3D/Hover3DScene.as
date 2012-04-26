package away3D
{
	
	import away3d.cameras.HoverCamera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.events.MouseEvent3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class Hover3DScene extends Sprite
	{
		// Away3D Vars		
		public var view:View3D;
		public var camera:HoverCamera3D;
		public var scene:Scene3D;
		
		// Timer used for rendering the scene
		public var renderTimer:Timer;
		
		
		// Vars used fo Camera Hover
		public var lastMousePosition:Point= new Point(0, 0);
		public var lastPanAngle:Number = 0;
		public var lastTiltAngle:Number	= 0;
		public var speed:Number = 1;
		
		public function Hover3DScene()
		{
		}
		
		
		public function init(	zoom:uint = 10, 
							 	focus:uint = 100, 
							 	distance:Number = 1000, 
							 	steps:uint = 10, 
							 	renderInterval:uint = 40,
							 	startRenderTimer:Boolean = true ):void
		{
			
			// Init the 3D elements	
			scene 	= new Scene3D();
			camera 	= new HoverCamera3D({	zoom: zoom, 
				focus: focus,
				steps: steps,
				distance: distance
			})
			view 	= new View3D({scene:scene, camera:camera, stats:true});
			addChild( view );
			
			// Init the render timer
			renderTimer = new Timer(renderInterval);
			renderTimer.addEventListener(TimerEvent.TIMER, render);
			
			// adds on added to stage listner
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true);
			
			// if true start rendering
			if(startRenderTimer) startRendering();
		}
		
		
		/* Start Rendering */
		public function startRendering():void
		{
			renderTimer.start();
		}
		
		
		
		/* Stop Rendering */
		public function stopRendering():void
		{
			renderTimer.stop();
		}
		
		
		
		/* Main render function */
		public function render(e:Event):void
		{
			
			onPreRender()
			
			// updates Camera Target Tilt and Pan
			camera.targetpanangle 	= 	speed	*	(lastMousePosition.x - stage.mouseX) + lastPanAngle;
			camera.targettiltangle 	= 	speed	*	(lastMousePosition.y - stage.mouseY) + lastTiltAngle;
			
			// Calls the Camera's hover
			camera.hover();
			
			// Render
			view.render();
			
			onPostRender();
		}
		
		
		
		/* Adds a 3D object to the scene */
		public function add3DObject(child:Object3D):void
		{
			view.scene.addChild(child);
		}
		
		
		
		
		/* Event Handlers */
		
		public function addedToStageHandler(event:Event):void
		{
			// Cleanup
		 	removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			// Once added to the stage init internal events
			view.addEventListener(MouseEvent3D.MOUSE_MOVE, mouseMoveHandler, false, 0, true);
		}
		
		public function mouseMoveHandler(event:MouseEvent3D):void
		{
			lastPanAngle 	= camera.targetpanangle;
			lastTiltAngle 	= camera.targettiltangle;
			
			lastMousePosition.x = stage.mouseX;
			lastMousePosition.y = stage.mouseY;	
		}
		
		
		public function stageResizeHandler(event:Event = null):void
		{
			x = Math.round(stage.stageWidth*0.5);
			y = Math.round(stage.stageHeight*0.5);
		}
		
		protected function onPreRender() : void
		{
			
			
		}
		
		protected function onPostRender():void
		{	
			
			
		}
	}
}
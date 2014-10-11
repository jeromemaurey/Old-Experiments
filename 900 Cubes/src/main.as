package
{
	import away3DLite.*;
	
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.media.SoundMixer;
	import flash.utils.Timer;
	
	import hype.extended.rhythm.FilterRhythm;
	import hype.framework.core.TimeType;
	import hype.framework.display.BitmapCanvas;
	
	// Preload for main app
	[Frame(factoryClass="FramePreload")]
	
	[SWF(backgroundColor="#000000", frameRate="30", quality="HIGH", width="800", height="360")]
	
	public class main extends Sprite
	{
		
		private var bitmapCanvas:BitmapCanvas;
		private var bitmapCanvasBlur:BitmapCanvas;
		private var filterCanvas:FilterRhythm;
		
		private var spectrumCheckTimer:Timer;
		
		private var soundSpectrumWarning:SoundSpectrumWarningSprite;
		
		public function main()
		{
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true);
			
		}
		
		private function addedToStageHandler(e:Event):void
		{
			
			//add the canvas for the 3D Scene
			bitmapCanvas = new BitmapCanvas(stage.stageWidth, stage.stageHeight, true, 0x0);
			bitmapCanvas.blendMode = BlendMode.ADD;
			
			// add the canvas for the blur trail
			bitmapCanvasBlur = new BitmapCanvas(stage.stageWidth, stage.stageHeight, false, 0x0);
			
			addChild(bitmapCanvasBlur);
			addChild(bitmapCanvas);
			
			// add the 3D scene and inits it
			var cubeViz:CubesViz01 = new CubesViz01;
			addChild(cubeViz);
			cubeViz.init();
			cubeViz.visible = false;
			
			// starts captures on the canvas
			bitmapCanvas.startCapture(cubeViz, false);
			bitmapCanvasBlur.startCapture(bitmapCanvas, true);
			
			// add blur filter
			filterCanvas = new FilterRhythm([new BlurFilter(2, 20, 1)], bitmapCanvasBlur.bitmap.bitmapData);
			filterCanvas.start(TimeType.ENTER_FRAME, 1);
			
			// add a check to see if the soundSpectrum computation is available
			// if another flash movie is playing sound this will fail
			soundSpectrumWarning = new SoundSpectrumWarningSprite();
			soundSpectrumWarning.x = stage.stageWidth *.5;
			soundSpectrumWarning.y = stage.stageHeight *.5;
			soundSpectrumWarning.visible = false;
			addChild(soundSpectrumWarning);
			
			// init the timer to check on spectrum comput availability
			spectrumCheckTimer = new Timer(2000);
			spectrumCheckTimer.addEventListener(TimerEvent.TIMER, checkForSpectrumAvailability, false, 0, true);
			spectrumCheckTimer.start();
			
			// add a mouse down handler for hiding the stencil (3D cubes)
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			bitmapCanvas.visible = (bitmapCanvas.visible == true)? false : true;
		}
		
		private function checkForSpectrumAvailability(e:TimerEvent):void
		{
			if(SoundMixer.areSoundsInaccessible()) soundSpectrumWarning.visible = true;
			else if(soundSpectrumWarning.visible) soundSpectrumWarning.visible = false;
		}
	}
}
package 
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.utils.getDefinitionByName;
	
		public class FramePreload extends MovieClip
		{
			
			private var preploadSprite:Sprite;
			
			private static const  w:uint = 200;
			private static const h:uint = 14;
			private static const border:uint = 2;
			
			public function FramePreload()
			{
				stop();
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
				
				preploadSprite = new Sprite;
				preploadSprite.filters = [ new DropShadowFilter(2, 90, 0, 1, 6, 6, 1, 2)];
				
				addChild(preploadSprite);
				
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
	
			public function onEnterFrame(event:Event):void
			{
					if(framesLoaded == totalFrames)
					{
						removeEventListener(Event.ENTER_FRAME, onEnterFrame);
						removeChild(preploadSprite);
						nextFrame();
						init();
					}
				else
				{
					drawPreload(root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal, preploadSprite.graphics);
				}
			}
	
			private function init():void
			{
				var mainClass:Class = Class(getDefinitionByName("main"));
				if(mainClass)
				{
					var app:Object = new mainClass();
					addChild(app as DisplayObject);
				}
			}
			
			
			private function drawPreload(percent:Number, graphics:Graphics):void
			{
				graphics.clear();
				
				// draw bg rect
				graphics.beginFill(0xffffff, .8);
				graphics.drawRect(
													(stage.stageWidth/2) - w/2, 
													(stage.stageHeight/2) - h/2,
													w, 
													h);
													
				// draw progress rect
				
				graphics.beginFill(0x3b3e44, .8);
				graphics.drawRect(
													(stage.stageWidth/2) - w/2 + border, 
													(stage.stageHeight/2) - h/2 + border,
													w * percent - (border*2), 
													h - (border*2));
				graphics.endFill();
			}
		}
}
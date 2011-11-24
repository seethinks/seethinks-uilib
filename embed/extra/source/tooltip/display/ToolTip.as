package tooltip.display 
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import tooltip.display.bg.CustomBg;
	import tooltip.utils.SpriteUtils;
	import tooltip.utils.TextFieldUtils;
	
	public class ToolTip extends Sprite
	{
		private var _bg:CustomBg;
		private var _tail:Sprite;
		private var _tipField:TextField;
		private static var _instance:ToolTip;
		
		public static function getInstance():ToolTip
		{
			if (!ToolTip._instance) ToolTip._instance = new ToolTip(new Singleton());
			return ToolTip._instance;
		}
		
		public function ToolTip(s:Singleton) 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			
			this.draw();
		}
		private function draw():void
		{
			this.alpha = 0;
			this._bg = new CustomBg("ToolTipBg", this);
			this._tail = SpriteUtils.attachSprite("ToolTipTail", this);
			this._tipField = TextFieldUtils.textField(this, "", "Arial", false, 13, 0x000000);
			
			TweenMax.to(this, 0, { dropShadowFilter: { color:0x000000, alpha:0.7, blurX:4, blurY:4, angle:45, distance:7 }} );
			
			this.removeChild(this._bg);
			this.removeChild(this._tail);
			this.removeChild(this._tipField);
		}
		private function arrange(style:int):void
		{
			var b:CustomBg = this._bg;
			var t:Sprite = this._tail;
			var tF:TextField = this._tipField;
			
			t.scaleY = 1;
			t.x = 0;
			t.y = 0;
			
			tF.width = tF.textWidth + 5;
			tF.height = tF.textHeight + 5;
			tF.x = 0;
			tF.y = 0;
			
			b.width = tF.width + 10;
			b.height = tF.height + 10;
			
			b.x = 0;
			b.y = 0;
			
			var mX:Number = this.stage.mouseX;
			var mY:Number = this.stage.mouseY;
			
			if (style == 0)
			{
				t.scaleY = -1;
				t.x = mX;
				t.y = mY + 40;
			
				b.x = mX - 10;
				b.y = mY + t.height + b.height - 5;
			}		
			else if (style == 1)
			{
				t.scaleY = -1;
				t.x = mX;
				t.y = mY + 40;
			
				b.x = mX - b.width * 0.5 + t.width * 0.5;
				b.y = mY + t.height + b.height - 5;
			}
			else if(style == 2)
			{
				t.scaleY = -1;
				t.x = mX;
				t.y = mY + 40;
			
				b.x = mX - b.width + t.width + 10;
				b.y = mY + t.height + b.height - 5;
			}	
			else if(style == 3 || style == 6)
			{
				t.x = mX;
				t.y = mY - t.height;
				
				b.x = t.x - 10;
				b.y = t.y - b.height + 2;
			}		
			else if(style == 4 || style == 7)
			{
				t.x = mX;
				t.y = mY - t.height;
				
				b.x = t.x - b.width * 0.5 + t.width * 0.5;
				b.y = t.y - b.height + 2;					
			}			
			else if(style == 5 || style == 8)
			{
				t.x = mX;
				t.y = mY - t.height;
				
				b.x = t.x - b.width + t.width + 10;
				b.y = t.y - b.height + 2;	
			}
							
			tF.x = b.x + 5;
			tF.y = b.y + 5;
		}
		public function show(message:String):void
		{
			this._tipField.htmlText = message;
			this.parent.setChildIndex(this, this.parent.numChildren - 1);
			
			this.addChild(this._bg);
			this.addChild(this._tail);
			this.addChild(this._tipField);
			
			TweenMax.to(this, 0.25, { alpha:1 } );
			
			this.addEventListener(Event.ENTER_FRAME, this.onFrame);
		}
		
		private function onFrame(e:Event):void 
		{
			var sW:Number = this.stage.stageWidth;
			var sH:Number = this.stage.stageHeight;
			
			var rW:Number = sW / 3;
			var rH:Number = sH / 3;
			
			var mX:Number = this.stage.mouseX;
			var mY:Number = this.stage.mouseY;
			
			if (mX < rW && mY < rH) this.arrange(0);
			else if (mX > rW && mX < rW * 2 && mY < rH) this.arrange(1);
			else if (mX > rW * 2 && mY < rH) this.arrange(2);
			else if (mX < rW && mY > rH && mY < rH * 2) this.arrange(3);
			else if (mX > rW && mX < rW * 2 && mY > rH && mY < rH * 2) this.arrange(4);
			else if (mX > rW * 2 && mY > rH && mY < rH * 2) this.arrange(5);
			else if (mX < rW && mY > rH * 2) this.arrange(6);
			else if (mX > rW && mX < rW * 2 && mY > rH * 2) this.arrange(7);
			else this.arrange(8);
		}
		public function hide():void
		{
			this.removeEventListener(Event.ENTER_FRAME, this.onFrame);
			TweenMax.to(this, 0.25, { alpha:0, onComplete:this.onCompleteHide } );
		}
		
		private function onCompleteHide():void
		{
			this.removeChild(this._bg);
			this.removeChild(this._tail);
			this.removeChild(this._tipField);
		}
	}

}
internal class Singleton{}
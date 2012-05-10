package com.hezi.uilib.components 
{
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.skin.SkinStyle;
	import com.hezi.uilib.util.GC;
	import com.hezi.uilib.util.StMotionEffects;
	import com.hezi.uilib.event.StUiEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getQualifiedSuperclassName;
	/**
	 * ToolTip组件
	 * @author seethinks@gmail.com
	 */
	public class StToolTipSpr extends AbstractComponentBase 
	{
		private var _styleMap:Object;
		private var _skinObj:Object;
		private var _bgSpr:Sprite;
		private var _tailSpr:Sprite;
		private var _tipSpr:Sprite;
		private static var _instance:StToolTipSpr;
		
		/**
		 * 单例类 （备注，背景皮肤建议用swf嵌入矢量九宫格）
		 * @param	s
		 * @param	skinObj
		 */
		public function StToolTipSpr(s:Singleton=null,skinObj:Object=null) 
		{
			_skinObj = skinObj;
			init();
		}
		
		public static function getInstance(skinObj:Object=null):StToolTipSpr
		{
			if (!StToolTipSpr._instance) StToolTipSpr._instance = new StToolTipSpr(new Singleton,skinObj);
			return StToolTipSpr._instance;
		}

		override public function init():void 
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			_styleMap = new Object();
			// *****************************************        初始化绘制        *********************
			var tempBmp:Bitmap;
			var tempSpr:Sprite;
			var parentType:String;
			var tempObj:*;
			
			// track
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.TOOLTIP_BG])
				{
					tempObj = _skinObj[SkinStyle.TOOLTIP_BG];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TOOLTIP_BG];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TOOLTIP_BG];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.TOOLTIP_BG] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.TOOLTIP_BG] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.TOOLTIP_BG] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StToolTipSpr, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}	
			}
			
			// _thumbSpr
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.TOOLTIP_TAIL])
				{
					tempObj = _skinObj[SkinStyle.TOOLTIP_TAIL];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TOOLTIP_TAIL];
				}			
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TOOLTIP_TAIL];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.TOOLTIP_TAIL] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.TOOLTIP_TAIL] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.TOOLTIP_TAIL] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StToolTipSpr, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			// -----------------------------------------        初始化绘制        ---------------------------
			draw();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler,false,0,true);
		}
		private function addedToStageHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
		}
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			destroy();
		}
		
		override public function setLocation(x:Number, y:Number):void 
		{
			this.x = x;
			this.y = y;
		}
		
		override public function setSize(w:Number, h:Number):void 
		{
			if (w > 0 && h > 0)
			{				
				this.scaleX = w / this._width ;
				this.scaleY = h / this._height;
				this._height = h
				this._width = w;
			}
		}
		
		override public function setStyle(styleName:String = "", styleObj:Object = null):void 
		{
		}
		
		override public function getStyle(styleName:String):Object 
		{
			return super.getStyle(styleName);
		}
		
		override public function draw():void 
		{
			this.alpha = 0;
			this._bgSpr = _styleMap[SkinStyle.TOOLTIP_BG] as Sprite;
			this._tailSpr = _styleMap[SkinStyle.TOOLTIP_TAIL] as Sprite;
			
			if (this._tailSpr)this.addChild(this._tailSpr);
			if (this._bgSpr) this.addChild(this._bgSpr);
			_tipSpr = new Sprite();
			addChild(_tipSpr);
		}
		
		private function arrange(style:int):void
		{
			var b:Sprite = this._bgSpr;
			var t:Sprite = this._tailSpr;
			var tF:Sprite = this._tipSpr;
			
			t.scaleY = 1;
			t.x = 0;
			t.y = 0;
			
			//tF.width = tF.getText().textWidth + 5;
			//tF.height = tF.getText().textHeight + 5;
			tF.x = 0;
			tF.y = 0;
			
			b.width = tF.width + 10;
			b.height = tF.height + 10;
			
			b.x = 0;
			b.y = 0;
			
			var mX:Number = this.stage.mouseX;
			var mY:Number = this.stage.mouseY;
			//trace(style);
			if (style == 0)
			{
				t.scaleY = -1;
				t.x = mX;
				t.y = mY + 40;
				t.y -= t.height / 2;
				b.x = mX - 10;
				b.y = t.y-2 ;
			}		
			else if (style == 1)
			{
				t.scaleY = -1;
				t.x = mX;
				t.y = mY + 40;
				t.y -= t.height / 2;
				b.x = mX - b.width * 0.5 + t.width * 0.5;
				b.y = t.y-2 ;
			}
			else if(style == 2)
			{
				t.scaleY = -1;
				t.x = mX;
				t.y = mY + 40;
				t.y -= t.height / 2;
				b.x = mX - b.width + t.width + 10;
				b.y = t.y -2 ;
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
			b.x += b.width / 2;
			b.y += b.height / 2;
			b.x -= t.width / 2;
			b.y -= 4;
			
			t.x -= t.width / 2;
			t.y -= 4;
			
			tF.x = b.x + 5;
			tF.y = b.y + 5;
			
			tF.x -= b.width / 2;
			tF.y-= b.height / 2;
		}
		
		/**
		 * 显示spr
		 * @param	Spr		
		 */
		public function show(spr:Sprite):void
		{
			this.alpha = 0;
			/*if (!spr)
			{
				this._tipSpr = new Sprite();
				this._tipSpr.graphics.clear();
				this._tipSpr.graphics.beginFill(0xff0000);
				this._tipSpr.graphics.drawRect(0, 0, 100, 300);
				this._tipSpr.graphics.endFill();
			}else
			{
				this._tipSpr = spr;
			}*/
			_tipSpr.addChild(spr);
			
			//if (this._tipSpr) this.addChild(this._tipSpr);	
			this.parent.setChildIndex(this, this.parent.numChildren - 1);
			//trace("showshowshowshowshow numChildren 1111:"+this.numChildren);
			/*while(this.numChildren>3)
			{
				this.removeChildAt(this.numChildren-1);
			}*/
			//trace("showshowshowshowshow numChildren 2222:"+this.numChildren);
			StMotionEffects.to(this, 0.35, { alpha:1} );
			//StMotionEffects.to(this, 0.35, { alpha:1 ,complete:showComplete} );
			this.visible = true;
			this.addEventListener(Event.ENTER_FRAME, this.onFrame);
		}
		
		private function showComplete():void 
		{
			this.dispatchEvent(new StUiEvent(StUiEvent.STTOOLTIPSPR_SHOWED));
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
			//trace("this._tipSpr.parent 11:", this._tipSpr.parent,this._tipSpr.parent.name);
			//trace("this._tipSpr 11111 1111 :",_tipSpr.numChildren);
			//GC.clearAllMc(_tipSpr);
			while(_tipSpr.numChildren>0)
			{
				_tipSpr.removeChildAt(_tipSpr.numChildren-1);
			}
			//trace("this._tipSpr 22222 2222:",_tipSpr.numChildren);
			this.removeEventListener(Event.ENTER_FRAME, this.onFrame);
			StMotionEffects.to(this, 0.25, { alpha:0 ,onComplete:this.onCompleteHide });
		}
		
		private function onCompleteHide():void 
		{
			this.visible = false;
		}
		
		override public function destroy():void 
		{
			GC.killMySelf(_bgSpr);
			GC.killMySelf(_tailSpr);
			GC.killMySelf(_tipSpr);
			this.removeEventListener(Event.ENTER_FRAME, this.onFrame);
			/*if (_bgSpr && _bgSpr.parent) _bgSpr.parent.removeChild(_bgSpr);
			if (_tailSpr && _tailSpr.parent) _tailSpr.parent.removeChild(_tailSpr);
			if (_tipSpr && _tipSpr.parent) _tipSpr.parent.removeChild(_tipSpr);*/
			_bgSpr = null;
			_tailSpr = null;
			_tipSpr = null;
			_styleMap = null ;
			_skinObj = null;
			_instance = null;
			GC.killMySelf(this);
			delete this;
			GC.Gc();
		}
	}
}
internal class Singleton{}
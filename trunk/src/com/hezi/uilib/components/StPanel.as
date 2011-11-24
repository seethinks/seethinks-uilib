package com.hezi.uilib.components 
{
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.event.StUiEvent;
	import com.hezi.uilib.skin.SkinStyle;
	import com.hezi.uilib.util.GC;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedSuperclassName;
	
	[Event (name="CHANGE_SIZE",type="com.hezi.uilib.event.StUiEvent")]
	
	/**
	 * 面板组件
	 * @author seethinks@gmail.com
	 */
	public class StPanel extends AbstractComponentBase 
	{
		private var _backGroundShape:Shape;	
		private var _backGroundTexture:BitmapData;
		private var _disableShape:Shape;	
		private var _disableTexture:BitmapData;
		private var _styleMap:Object;
		
		/**
		 * 
		 * @param	x x坐标
		 * @param	y y坐标
		 * @param	alpha 透明度
		 * @param	draged 可否拖动
		 * @param	dragedInStage 是否在舞台内拖动
		 */
		public function StPanel(x:Number = 0, y:Number = 0, alpha:Number = 1, draged:Boolean = false, dragedInStage:Boolean = false, enabled:Boolean = true ) 
		{
			setLocation(x, y);
			this._dragedInStage = dragedInStage;
			this._enabled = enabled;
			this._draged = draged;
			init();
		}
		
		override public function init():void 
		{
			_styleMap = new Object();
			
			_backGroundShape = new Shape();
			addChild(_backGroundShape);
			_disableShape = new Shape();
			addChild(_disableShape);
			_disableShape.visible = false;
			
			// *****************************************        初始化绘制        *********************
			var tempBmp:Bitmap;
			var parentType:String;
			var bmpData:BitmapData;

			// backGround
			parentType = getQualifiedSuperclassName(SkinStyle.Skin.SkinObj[SkinStyle.PANEL_DEFAULT]);
			if (parentType.indexOf("BitmapAsset") !=-1)
			{
				tempBmp = SkinStyle.Skin.SkinObj[SkinStyle.PANEL_DEFAULT];
				_styleMap[SkinStyle.PANEL_DEFAULT] = tempBmp.bitmapData.clone();
			}else if (parentType.indexOf("BitmapData") !=-1)
			{
				_styleMap[SkinStyle.PANEL_DEFAULT] = BitmapData(SkinStyle.Skin.SkinObj[SkinStyle.PANEL_DEFAULT]).clone();
			}else if (parentType.indexOf("SpriteAsset") !=-1)
			{
				bmpData = new BitmapData(SkinStyle.Skin.SkinObj[SkinStyle.PANEL_DEFAULT].width, SkinStyle.Skin.SkinObj[SkinStyle.PANEL_DEFAULT].height,true,0xffffff);
				bmpData.draw(SkinStyle.Skin.SkinObj[SkinStyle.PANEL_DEFAULT]);
				_styleMap[SkinStyle.PANEL_DEFAULT] = bmpData;
			}else 
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StPanel, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
			}
			
			// disable
			parentType = getQualifiedSuperclassName(SkinStyle.Skin.SkinObj[SkinStyle.PANEL_DISABLE]);
			if (parentType.indexOf("BitmapAsset") !=-1)
			{
				tempBmp = SkinStyle.Skin.SkinObj[SkinStyle.PANEL_DISABLE];
				_styleMap[SkinStyle.PANEL_DISABLE] = tempBmp.bitmapData.clone();
			}else if (parentType.indexOf("BitmapData") !=-1)
			{
				_styleMap[SkinStyle.PANEL_DISABLE] = BitmapData(SkinStyle.Skin.SkinObj[SkinStyle.PANEL_DISABLE]).clone();
			}else if (parentType.indexOf("SpriteAsset") !=-1)
			{
				bmpData = new BitmapData(SkinStyle.Skin.SkinObj[SkinStyle.PANEL_DISABLE].width, SkinStyle.Skin.SkinObj[SkinStyle.PANEL_DISABLE].height,true,0xffffff);
				bmpData.draw(SkinStyle.Skin.SkinObj[SkinStyle.PANEL_DISABLE]);
				_styleMap[SkinStyle.PANEL_DISABLE] = bmpData;
			}else 
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StPanel, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
			}
			
			//绘制完成后，根据资源显示大小
			draw();
			this._width = _backGroundTexture.width;
			this._height = _backGroundTexture.height;
			setSize(this._width,this._height);
			// -----------------------------------------        初始化绘制        ---------------------------
			if (this._draged)
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler,false,0,true);
			}
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler,false,0,true);
		}
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			destroy();
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			if (!this._dragedInStage)
			{
				this.startDrag();
			}else
			{
				this.startDrag(false,new Rectangle(0,0,stage.stageWidth-this._width,stage.stageHeight-this._height));
			}
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler,false,0,true);
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			this.stopDrag();
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
				this._width = w;
				this._height = h;
				dispatchEvent(new StUiEvent(StUiEvent.CHANGE_SIZE));
			}
		}
		
		/**
		 * 设置是否可用
		 * @param	b
		 */
		public function setDisable(b:Boolean):void 
		{
			if (!b)
			{
				_backGroundShape.visible = false;
				_disableShape.visible = true;
				this.enabled = false;
			}else
			{
				_backGroundShape.visible = true;
				_disableShape.visible = false;
				this.enabled = true;
			}
		}
		
		override public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		override public function draw():void 
		{
			_backGroundShape.graphics.clear();
			_disableShape.graphics.clear();
			_backGroundTexture = _styleMap[SkinStyle.PANEL_DEFAULT];
			_disableTexture = _styleMap[SkinStyle.PANEL_DISABLE];
			SkinStyle.fill9Grid(_backGroundShape.graphics, _backGroundTexture, new Rectangle(10, 10, 10, 10), _backGroundTexture.width, _backGroundTexture.height);
			SkinStyle.fill9Grid(_disableShape.graphics, _disableTexture,new Rectangle(10,10,10,10), _disableTexture.width, _disableTexture.height);
		}

		override public function setStyle(styleName:String = "", styleObj:Object = null):void 
		{
			var parentType:String;
			parentType = getQualifiedSuperclassName(styleObj);

			if (parentType.indexOf("BitmapAsset") !=-1)
			{
				var tempBmp:Bitmap;
				tempBmp = styleObj as Bitmap;
				_styleMap[styleName] = tempBmp.bitmapData.clone();
			}else if (parentType.indexOf("BitmapData") !=-1)
			{
				_styleMap[styleName] = BitmapData(styleObj).clone();
			}else if (parentType.indexOf("SpriteAsset") !=-1)
			{
				var bmpData:BitmapData;
				bmpData = new BitmapData(styleObj.width, styleObj.height,true,0xffffff);
				bmpData.draw(styleObj as Sprite);
				_styleMap[styleName] = bmpData;
			}else
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StPanel, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
			}
			redraw();
		}
		
		override public function getStyle(styleName:String):Object 
		{
			return _styleMap[styleName];
		}
		
		override public function destroy():void 
		{
			if (this._draged)
			{
				this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}		
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			if (_backGroundTexture)
			{
				_backGroundTexture.dispose();
				_backGroundTexture = null;
			}
			if (_disableTexture)
			{
				_disableTexture.dispose();
				_disableTexture = null;
			}
			if (_backGroundShape && _backGroundShape.parent) _backGroundShape.parent.removeChild(_backGroundShape);
			if (_disableShape && _disableShape.parent) _disableShape.parent.removeChild(_disableShape);
			_backGroundShape = null;
			_disableShape = null;
			_styleMap = null ;
			GC.killMySelf(this);
			delete this;
			GC.Gc();
		}
		
	}

}
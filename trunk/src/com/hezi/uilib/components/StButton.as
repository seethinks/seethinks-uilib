package com.hezi.uilib.components 
{
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.skin.ProtoTypeRect;
	import com.hezi.uilib.skin.SkinStyle;
	import com.hezi.uilib.util.GC;
	
	import flash.geom.Matrix;
	import flash.display.Sprite;
	import flash.utils.getQualifiedSuperclassName;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.events.Event;
	
	/**
	* 具体按钮类
	* @author seethinks@gmail.com
	*/
	public class StButton extends AbstractComponentBase
	{
		private var _skinObj:Object;
		private var _defaultSpr:Sprite;
		private var _rollOverSpr:Sprite;
		private var _pressSpr:Sprite;
		private var _disableSpr:Sprite;
		private var _labelTxt:String = "";
		private var _label:StTextField;
		private var _labelBmp:Bitmap;
		private var _styleMap:Object;
		//private var _matrix:Matrix;
		
		/**
		 * 具体按钮类构造函数
		 */
		public function StButton(skinObj:Object = null,x:Number=0,y:Number=0,alpha:Number=1,enabled:Boolean=true) 
		{
			_skinObj = skinObj;
			setLocation(x, y);
			init();
		}
		
		/**
		 * 初始化Button显示对象和绘制，绘制元素建立map
		 */
		override public function init():void 
		{
			_styleMap = new Object();
			
			_defaultSpr = new Sprite();
			_rollOverSpr = new Sprite();
			_pressSpr = new Sprite();
			_disableSpr = new Sprite();
			_labelBmp = new Bitmap();

			if (!this._enabled)
			{
				this.buttonMode = false;
				_defaultSpr.visible = false;
				_disableSpr.visible = true;
				this.enabled = false;
			}
			
			//var tf:TextFormat = new TextFormat();
			//tf.align = TextFormatAlign.CENTER;
			if (_skinObj) _skinObj[SkinStyle.TEXTFIELD_Bg] = new ProtoTypeRect(1,1,true);
			_label = new StTextField(_skinObj);
			//_label.y = 2;
			//_label.mouseEnabled = false;
			//_label.defaultTextFormat = tf;
			//addChild(_label);
			
			// *****************************************        初始化绘制        *********************
			var tempBmp:Bitmap;
			var tempSpr:Sprite;
			var parentType:String;
			var tempObj:*;
			
			// default
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.BUTTON_DEFAULT])
				{
					tempObj = _skinObj[SkinStyle.BUTTON_DEFAULT];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.BUTTON_DEFAULT];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.BUTTON_DEFAULT];
			}
			parentType = getQualifiedSuperclassName(tempObj);

			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.BUTTON_DEFAULT] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.BUTTON_DEFAULT] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.BUTTON_DEFAULT] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StButton, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}

			// rollover
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.BUTTON_ROLLOVER])
				{
					tempObj = _skinObj[SkinStyle.BUTTON_ROLLOVER];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.BUTTON_ROLLOVER];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.BUTTON_ROLLOVER];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.BUTTON_ROLLOVER] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.BUTTON_ROLLOVER] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.BUTTON_ROLLOVER] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StButton, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			
			// press
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.BUTTON_PRESS])
				{
					tempObj = _skinObj[SkinStyle.BUTTON_PRESS];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.BUTTON_PRESS];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.BUTTON_PRESS];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.BUTTON_PRESS] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.BUTTON_PRESS] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.BUTTON_PRESS] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StButton, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			
			// disable
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.BUTTON_DISABLE])
				{
					tempObj = _skinObj[SkinStyle.BUTTON_DISABLE];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.BUTTON_DISABLE];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.BUTTON_DISABLE];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.BUTTON_DISABLE] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.BUTTON_DISABLE] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.BUTTON_DISABLE] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StButton, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			
			// label
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.BUTTON_LABEL]=="" || !_skinObj[SkinStyle.BUTTON_LABEL])
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.BUTTON_LABEL];
				}else
				{
					tempObj = _skinObj[SkinStyle.BUTTON_LABEL];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.BUTTON_LABEL];
			}
			if (tempObj is String)
			{
				_labelTxt = tempObj;
				//_label.text = _labelTxt;
				_styleMap[SkinStyle.BUTTON_LABEL] = tempObj;
			}else
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StButton, "参数应该为string类型");
			}
			
			draw();
			
			//绘制完成后，根据资源显示大小
			//this._width = Math.max(_defaultTexture.width,_rollOverTexture.width);
			//this._height = Math.max(_defaultTexture.height, _rollOverTexture.height);

			// -----------------------------------------        初始化绘制        ---------------------------
			
			addEventListener(MouseEvent.ROLL_OVER, onOver,false,0,true);
			addEventListener(MouseEvent.ROLL_OUT, onOut,false,0,true);
			addEventListener(MouseEvent.MOUSE_DOWN, onDown,false,0,true);
			addEventListener(MouseEvent.MOUSE_UP, onUP,false,0,true);
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
		
		override public function setLocation(x:Number, y:Number):void 
		{
			this.x = x;
			this.y = y;
		}
		
		override public function setSize(w:Number,h:Number):void
		{
			/*if (this._width > 0 && this._height > 0)
			{				
				_matrix.scale(w / this._width, h / this._height);
				if (this._width != w)
				{
					this._width = w;
				}
				if (this._height != h)
				{
					this._height = h;
				}
				
			}*/
			
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
			/*var parentType:String;
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
			}else if (styleObj is String)
			{
				_labelTxt = styleObj as String;
				_styleMap[SkinStyle.BUTTON_LABEL] = _labelTxt;
			}else
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StButton, "图形参数应该继承自[BitmapAsset,BitmapData,SpriteAsset],文本参数应该为String");
			}*/
			
			redraw();
		}
		
		
		override public function draw():void 
		{
			//_label.width = _width;
			//_label.height = _height;

			
			/*GC.clearAllMc(_defaultSpr);
			GC.clearAllMc(_rollOverSpr);
			GC.clearAllMc(_pressSpr);
			GC.clearAllMc(_disableSpr);*/
			
			_defaultSpr = _styleMap[SkinStyle.BUTTON_DEFAULT] as Sprite;
			_rollOverSpr = _styleMap[SkinStyle.BUTTON_ROLLOVER] as Sprite;
			_pressSpr = _styleMap[SkinStyle.BUTTON_PRESS] as Sprite;
			_disableSpr = _styleMap[SkinStyle.BUTTON_DISABLE] as Sprite;
			addChild(_labelBmp);
			
			if (_defaultSpr) 
			{
				//_defaultSpr.x += _defaultSpr.width * .5;
				//_defaultSpr.y += _defaultSpr.height * .5;
				addChildAt(_defaultSpr,0);
			}
			if (_rollOverSpr) {
				//_rollOverSpr.x += _rollOverSpr.width * .5;
				//_rollOverSpr.y += _rollOverSpr.height * .5;
				addChildAt(_rollOverSpr,0);
			}
			if (_pressSpr) {
				//_pressSpr.x += _pressSpr.width * .5;
				//_pressSpr.y += _pressSpr.height * .5;
				addChildAt(_pressSpr,0);
			}
			if (_disableSpr) {
				//_disableSpr.x += _disableSpr.width * .5;
				//_disableSpr.y += _disableSpr.height * .5;
				addChildAt(_disableSpr, 0);
			}
			
			_label.text = _labelTxt;
			_label.width = _defaultSpr.width;
			_label.height = _defaultSpr.height;
			var tempBmpData:BitmapData = new BitmapData(_label.width, _label.height,true,0xffffff);
			tempBmpData.draw(_label,null,null,null,null,true);
			_labelBmp = new Bitmap(tempBmpData);
			_labelBmp.x = _label.x;
			_labelBmp.y = _label.y;
			addChild(_labelBmp);
			_rollOverSpr.visible = false;
			_pressSpr.visible = false;
			_disableSpr.visible = false;

			_label.width = _defaultSpr.width;
			_label.height = _defaultSpr.height;
			this._enabled = enabled;
			
			if (this._enabled)
			{
				this.buttonMode = true;
				this.mouseChildren = true;
			}else
			{
				this.buttonMode = false;
				this.mouseChildren = false;
			}

			//SkinStyle.fill9Grid(_defaultSpr.graphics, _defaultTexture,new Rectangle(5,5,5,5), _defaultTexture.width, _defaultTexture.height);
			//SkinStyle.fill9Grid(_rollOverSpr.graphics,_rollOverTexture,new Rectangle(5,5,5,5), _rollOverTexture.width, _rollOverTexture.height);
			//SkinStyle.fill9Grid(_pressSpr.graphics, _pressTexture,new Rectangle(5,5,5,5), _pressTexture.width, _pressTexture.height);
			//SkinStyle.fill9Grid(_disableSpr.graphics, _disableTexture,new Rectangle(5,5,5,5), _disableTexture.width, _disableTexture.height);

			/*SkinStyle.fillRect2(_defaultSpr.graphics, _defaultTexture,_defaultTexture.width, _defaultTexture.height,_matrix);
			SkinStyle.fillRect2(_rollOverSpr.graphics,_rollOverTexture, _rollOverTexture.width, _rollOverTexture.height,_matrix);
			SkinStyle.fillRect2(_pressSpr.graphics, _pressTexture, _pressTexture.width, _pressTexture.height,_matrix);
			SkinStyle.fillRect2(_disableSpr.graphics, _disableTexture,_disableTexture.width, _disableTexture.height,_matrix);*/
		}
		
		override public function getStyle(styleName:String):Object 
		{
			return _styleMap[styleName];
		}

		private function onUP(e:MouseEvent):void 
		{
			if (this.enabled)
			{
				_defaultSpr.visible = false;
				_pressSpr.visible = false;
				_rollOverSpr.visible = true;
				this.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			}
		}
		
		private function onDown(e:MouseEvent):void 
		{
			if (this.enabled)
			{
				_defaultSpr.visible = false;
				_pressSpr.visible = true;
				_rollOverSpr.visible = false;
			}
		}
		
		private function onOut(e:MouseEvent):void 
		{
			if (this.enabled)
			{
				_defaultSpr.visible = true;
				_rollOverSpr.visible = false;
			}
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if (this.enabled)
			{
				_defaultSpr.visible = false;
				_rollOverSpr.visible = true;
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
				this.buttonMode = false;
				_defaultSpr.visible = false;
				_rollOverSpr.visible = false;
				_pressSpr.visible = false;
				this.enabled = false;
				_disableSpr.visible = true;
			}else
			{
				this.buttonMode = true;
				_disableSpr.visible = false;
				_rollOverSpr.visible = false;
				_pressSpr.visible = false;
				this.enabled = true;
				_defaultSpr.visible = true;
			}
		}
		
		override public function get enabled():Boolean 
		{
			return super.enabled;
		}
		
		override public function set enabled(value:Boolean):void 
		{
			super.enabled = value;
		}
		
		override public function get width():Number 
		{
			return super.width;
		}
		
		
		override public function set width(value:Number):void 
		{
			_defaultSpr.width = value;
			_defaultSpr.scale9Grid = new Rectangle(10, 10, 10, 10);
			_rollOverSpr.width = value;
			_rollOverSpr.scale9Grid = new Rectangle(10, 10, 10, 10);
			_pressSpr.width = value;
			_pressSpr.scale9Grid = new Rectangle(10, 10, 10, 10);
			_disableSpr.width = value;
			_disableSpr.scale9Grid = new Rectangle(10, 10, 10, 10);
			_labelBmp.width = value;
		}
		
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			_defaultSpr.height = value;
			_defaultSpr.scale9Grid = new Rectangle(10, 10, 10, 10);
			_rollOverSpr.height = value;
			_rollOverSpr.scale9Grid = new Rectangle(10, 10, 10, 10);
			_pressSpr.height = value;
			_pressSpr.scale9Grid = new Rectangle(10, 10, 10, 10);
			_disableSpr.height = value;
			_disableSpr.scale9Grid = new Rectangle(10, 10, 10, 10);
			_labelBmp.height = value;
		}
		
		override public function destroy():void 
		{
			/*if (_defaultTexture)
			{
				_defaultTexture.dispose();
				_defaultTexture = null;
			}
			if (_rollOverTexture)
			{
				_rollOverTexture.dispose();
				_rollOverTexture = null;
			}
			if (_pressTexture)
			{
				_pressTexture.dispose();
				_pressTexture = null;
			}
			if (_disableTexture)
			{
				_disableTexture.dispose();
				_disableTexture = null;
			}*/
			removeEventListener(MouseEvent.ROLL_OVER, onOver);
			removeEventListener(MouseEvent.ROLL_OUT, onOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			removeEventListener(MouseEvent.MOUSE_UP, onUP);
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			if (_defaultSpr && _defaultSpr.parent) _defaultSpr.parent.removeChild(_defaultSpr);
			if (_rollOverSpr && _rollOverSpr.parent) _rollOverSpr.parent.removeChild(_rollOverSpr);
			if (_pressSpr && _pressSpr.parent) _pressSpr.parent.removeChild(_pressSpr);
			if (_disableSpr && _disableSpr.parent) _disableSpr.parent.removeChild(_disableSpr);
			_defaultSpr = null;
			_rollOverSpr = null;
			_pressSpr = null;
			_disableSpr = null;
			_label = null;
			_styleMap = null ;
			_labelTxt = null ;
			_labelBmp = null;
			//GC.killMySelf(this);
			delete this;
			GC.Gc();
		}
	}

}
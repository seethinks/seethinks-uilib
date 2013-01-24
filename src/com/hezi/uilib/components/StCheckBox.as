package com.hezi.uilib.components 
{
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.skin.SkinStyle;
	import com.hezi.uilib.event.StUiEvent;
	import com.hezi.uilib.util.GC;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedSuperclassName;
	
	[Event (name = "STCHECK_CHANGESTATUS", type = "com.hezi.uilib.event.StUiEvent")]
	/**
	 * 复选框组件
	 * @author seethinks@gmail.com
	 */
	public class StCheckBox extends AbstractComponentBase 
	{
		private var _skinObj:Object;
		private var _defaultSpr:Sprite;
		private var _selectedSpr:Sprite;
		private var _defaultDisableSpr:Sprite;
		private var _selectedDisableSpr:Sprite;
		private var _styleMap:Object;
		
		private var _curStatues:String;
		public static const CHECKBOX_STATUS_DEFAULT:String = "checkbox_status_default";
		public static const CHECKBOX_STATUS_SELECTED:String = "checkbox_status_selected";
		
		public function StCheckBox(skinObj:Object=null,x:Number = 0, y:Number = 0,curStatues:String=CHECKBOX_STATUS_DEFAULT,enabled:Boolean=true) 
		{
			_skinObj = skinObj;
			_curStatues = curStatues;
			setLocation(x, y);
			init();
		}
		override public function init():void 
		{
			_styleMap = new Object();
			_defaultSpr = new Sprite();
			_selectedSpr = new Sprite();
			_defaultDisableSpr = new Sprite();
			_selectedDisableSpr = new Sprite();

			// *****************************************        初始化绘制        *********************
			var tempBmp:Bitmap;
			var tempSpr:Sprite;
			var parentType:String;
			var tempObj:*;
			
			// default
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.CHECKBOX_DEFAULT])
				{
					tempObj = _skinObj[SkinStyle.CHECKBOX_DEFAULT];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.CHECKBOX_DEFAULT];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.CHECKBOX_DEFAULT];
			}
			parentType = getQualifiedSuperclassName(tempObj);

			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.CHECKBOX_DEFAULT] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.CHECKBOX_DEFAULT] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.CHECKBOX_DEFAULT] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StCheckBox, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}

			// selected
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.CHECKBOX_SELECTED])
				{
					tempObj = _skinObj[SkinStyle.CHECKBOX_SELECTED];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.CHECKBOX_SELECTED];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.CHECKBOX_SELECTED];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.CHECKBOX_SELECTED] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.CHECKBOX_SELECTED] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.CHECKBOX_SELECTED] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StCheckBox, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			
			// defaultDisable
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.CHECKBOX_DEFAULT_DISABLE])
				{
					tempObj = _skinObj[SkinStyle.CHECKBOX_DEFAULT_DISABLE];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.CHECKBOX_DEFAULT_DISABLE];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.CHECKBOX_DEFAULT_DISABLE];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.CHECKBOX_DEFAULT_DISABLE] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.CHECKBOX_DEFAULT_DISABLE] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.CHECKBOX_DEFAULT_DISABLE] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StCheckBox, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			
			// disable
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.CHECKBOX_SELECTED_DISABLE])
				{
					tempObj = _skinObj[SkinStyle.CHECKBOX_SELECTED_DISABLE];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.CHECKBOX_SELECTED_DISABLE];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.CHECKBOX_SELECTED_DISABLE];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.CHECKBOX_SELECTED_DISABLE] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.CHECKBOX_SELECTED_DISABLE] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.CHECKBOX_SELECTED_DISABLE] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StCheckBox, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			
			draw();
			
			this.addEventListener(MouseEvent.CLICK, changeStatus,false,0,true);
		}
		
		private function changeStatus(e:MouseEvent):void 
		{
			if (_curStatues == CHECKBOX_STATUS_DEFAULT)
			{
				_curStatues = CHECKBOX_STATUS_SELECTED;
				_defaultSpr.visible = false;
				_selectedSpr.visible = true;
			}else
			{
				_curStatues = CHECKBOX_STATUS_DEFAULT;
				_defaultSpr.visible = true;
				_selectedSpr.visible = false;
			}
			
			var sue:StUiEvent = new StUiEvent(StUiEvent.STCHECK_CHANGESTATUS);
			sue.StCheckBoxStatus = (_curStatues == CHECKBOX_STATUS_DEFAULT?false:true);
			this.dispatchEvent(sue);
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
			_defaultSpr = _styleMap[SkinStyle.CHECKBOX_DEFAULT] as Sprite;
			_selectedSpr = _styleMap[SkinStyle.CHECKBOX_SELECTED] as Sprite;
			_defaultDisableSpr = _styleMap[SkinStyle.CHECKBOX_DEFAULT_DISABLE] as Sprite;
			_selectedDisableSpr = _styleMap[SkinStyle.CHECKBOX_SELECTED_DISABLE] as Sprite;

			if (_defaultSpr) 
			{
				addChildAt(_defaultSpr,0);
			}
			if (_selectedSpr) {
				addChildAt(_selectedSpr,0);
			}
			if (_defaultDisableSpr) {
				addChildAt(_defaultDisableSpr,0);
			}
			if (_selectedDisableSpr) {
				addChildAt(_selectedDisableSpr, 0);
			}
			
			this.mouseChildren = false;
			this._enabled = enabled;
			
			if (!this._enabled)
			{
				this.buttonMode = false;
				this.mouseChildren = false;
				_defaultSpr.visible = false;
				_selectedSpr.visible = false;
				_defaultDisableSpr.visible = false;
				_selectedDisableSpr.visible = false;
				if (_curStatues == CHECKBOX_STATUS_DEFAULT)
				{
					_defaultDisableSpr.visible = true;
				}else if (_curStatues == CHECKBOX_STATUS_SELECTED)
				{
					_selectedDisableSpr.visible = true;
				}
			}else
			{
				this.buttonMode = true;
				this.mouseChildren = true;
				_defaultSpr.visible = false;
				_selectedSpr.visible = false;
				_defaultDisableSpr.visible = false;
				_selectedDisableSpr.visible = false;
			
				if (_curStatues == CHECKBOX_STATUS_DEFAULT)
				{
					_defaultSpr.visible = true;
				}else if (_curStatues == CHECKBOX_STATUS_SELECTED)
				{
					_selectedSpr.visible = true;
				}
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
				this.enabled = false;
				_defaultSpr.visible = false;
				_selectedSpr.visible = false;
				_defaultDisableSpr.visible = false;
				_selectedDisableSpr.visible = false;
				if (_curStatues == CHECKBOX_STATUS_DEFAULT)
				{
					_defaultDisableSpr.visible = true;
				}else if (_curStatues == CHECKBOX_STATUS_SELECTED)
				{
					_selectedDisableSpr.visible = true;
				}
			}else
			{
				this.buttonMode = true;
				_selectedSpr.visible = false;
				_defaultDisableSpr.visible = false;
				_selectedDisableSpr.visible = false;
				_defaultSpr.visible = true;
				this.enabled = true;
			}
		}
		
		public function getStatus():Boolean
		{
			return (_curStatues == CHECKBOX_STATUS_DEFAULT?false:true);
		}
		
		override public function destroy():void 
		{
			this.removeEventListener(MouseEvent.CLICK, changeStatus);
			_styleMap = null ;
			_skinObj = null ;
			GC.killMySelf(this);
			/*if (_defaultSpr && _defaultSpr.parent) _defaultSpr.parent.removeChild(_defaultSpr);
			if (_selectedSpr && _selectedSpr.parent) _selectedSpr.parent.removeChild(_selectedSpr);
			if (_defaultDisableSpr && _defaultDisableSpr.parent) _defaultDisableSpr.parent.removeChild(_defaultDisableSpr);
			if (_selectedDisableSpr && _selectedDisableSpr.parent) _selectedDisableSpr.parent.removeChild(_selectedDisableSpr);
			_defaultSpr = null;
			_selectedSpr = null;
			_defaultDisableSpr = null;
			_selectedDisableSpr = null;
			GC.killMySelf(this);
			delete this;
			GC.Gc();*/
		}
	}

}
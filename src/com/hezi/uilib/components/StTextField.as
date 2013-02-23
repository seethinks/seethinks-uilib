package com.hezi.uilib.components 
{
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.skin.SkinStyle;
	import com.hezi.uilib.util.GC;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getQualifiedSuperclassName;
	
	/**
	 * 文本组件
	 * @author seethinks@gmail.com
	 */
	public class StTextField extends AbstractComponentBase
	{
		private var _styleMap:Object;
		private var _skinObj:Object;
		private var _backGroundSprite:Sprite;	
		private var _txtMode:String;
		private var _txt:TextField;
		private var _txtFormat:TextFormat;
		private var _tw:int;
		private var _th:int;
		private var _showImg:Boolean;	
		
		public function StTextField(skinObj:Object=null,x:Number = 0, y:Number = 0,tw:int=100,th:int=100,showImg:Boolean=false) 
		{
			_skinObj = skinObj;
			_tw = tw;
			_th = th;
			_showImg = showImg;
			setLocation(x, y);
			init();
		}
		
		public function get txtMode():String
		{
			return _txtMode;
		}

		public function set txtMode(value:String):void
		{
			_txtMode = value;
		}

		override public function init():void 
		{
			_styleMap = new Object();
			_txtMode = "html";
			_backGroundSprite = new Sprite();
			_txtFormat = new TextFormat();
			_txt = new TextField();
			_txt.wordWrap=true;
			_txt.multiline=true;
			_txt.type = TextFieldType.DYNAMIC;
			addChild(_txt);
			//_txt.mouseEnabled = false;
			//_backGroundSprite.mouseChildren = false;
			//this.mouseEnabled = false;
			//this.mouseChildren = false;
			this.mouseEnabled = false;
			// *****************************************        初始化绘制        *********************
			var tempBmp:Bitmap;
			var tempSpr:Sprite;
			var parentType:String;
			var tempObj:*;
			
			// 绘制背景
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.TEXTFIELD_Bg])
				{
					tempObj = _skinObj[SkinStyle.TEXTFIELD_Bg];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_Bg];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_Bg];
			}

			parentType = getQualifiedSuperclassName(tempObj);
			
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.TEXTFIELD_Bg] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.TEXTFIELD_Bg] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.TEXTFIELD_Bg] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StTextField, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			
			/**
			 * 文本类型
			 */
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.TEXTFIELD_TEXT_TYPE])
				{
					tempObj = _skinObj[SkinStyle.TEXTFIELD_TEXT_TYPE];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_TYPE];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_TYPE];
			}
			if (tempObj is String)
			{
				_styleMap[SkinStyle.TEXTFIELD_TEXT_TYPE] = tempObj;
			}else
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StTextField, "参数应该为String类型");
			}
			
			/**
			 * 对齐方式
			 */
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.TEXTFIELD_TEXT_ALIGN])
				{
					tempObj = _skinObj[SkinStyle.TEXTFIELD_TEXT_ALIGN];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_ALIGN];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_ALIGN];
			}
			if (tempObj is String)
			{
				_styleMap[SkinStyle.TEXTFIELD_TEXT_ALIGN] = tempObj;
			}else
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StTextField, "参数应该为String类型");
			}
			
			/**
			 * 是否加粗
			 */
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.TEXTFIELD_TEXT_BOLD])
				{
					tempObj = _skinObj[SkinStyle.TEXTFIELD_TEXT_BOLD];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_BOLD];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_BOLD];
			}
			if (tempObj is Boolean)
			{
				_styleMap[SkinStyle.TEXTFIELD_TEXT_BOLD] = tempObj;
			}else
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StTextField, "参数应该为Boolean类型");
			}
			
			/**
			 * 文本颜色
			 */
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.TEXTFIELD_TEXT_COLOR])
				{
					tempObj = _skinObj[SkinStyle.TEXTFIELD_TEXT_COLOR];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_COLOR];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_COLOR];
			}
			if (tempObj is Number)
			{
				_styleMap[SkinStyle.TEXTFIELD_TEXT_COLOR] = tempObj;
			}else
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StTextField, "参数应该为Number类型");
			}
			
			/**
			 * 文本大小
			 */
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.TEXTFIELD_TEXT_SIZE])
				{
					tempObj = _skinObj[SkinStyle.TEXTFIELD_TEXT_SIZE];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_SIZE];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_SIZE];
			}
			if (tempObj is Number)
			{
				_styleMap[SkinStyle.TEXTFIELD_TEXT_SIZE] = tempObj;
			}else
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StTextField, "参数应该为Number类型");
			}
			
			/**
			 * 是否为htm文本
			 */
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.TEXTFIELD_TEXT_HTML])
				{
					tempObj = _skinObj[SkinStyle.TEXTFIELD_TEXT_HTML];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_HTML];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_HTML];
			}
			if (tempObj is String)
			{
				_styleMap[SkinStyle.TEXTFIELD_TEXT_HTML] = tempObj;
			}else
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StTextField, "参数应该为String类型");
			}
			
			/**
			 * styleSheet
			 */
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.TEXTFIELD_TEXT_STYLESHEET])
				{
					tempObj = _skinObj[SkinStyle.TEXTFIELD_TEXT_STYLESHEET];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_STYLESHEET];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.TEXTFIELD_TEXT_STYLESHEET];
			}
			if (tempObj is String)
			{
				_styleMap[SkinStyle.TEXTFIELD_TEXT_STYLESHEET] = tempObj;
			}else
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StTextField, "参数应该为String类型");
			}
			
			// -----------------------------------------        初始化绘制        ---------------------------
			draw();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler,false,0,true);

		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
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
			_styleMap[styleName] = styleObj;
			redraw();
		}
		
		override public function getStyle(styleName:String):Object 
		{
			return super.getStyle(styleName);
		}
		
		override public function draw():void 
		{
			if (_styleMap[SkinStyle.TEXTFIELD_Bg]) _backGroundSprite = _styleMap[SkinStyle.TEXTFIELD_Bg] as Sprite;
			addChildAt(_backGroundSprite,0);
			if (_backGroundSprite.width > 0)
			{
				_txt.width = _backGroundSprite.width - 4;
				_txt.x = 4;
			}
			if (_backGroundSprite.width > 0) {
				_txt.height = _backGroundSprite.height - 4;
				_txt.y = 4;
			}
			
			if (_styleMap[SkinStyle.TEXTFIELD_TEXT_TYPE])
			{
				_txt.type = _styleMap[SkinStyle.TEXTFIELD_TEXT_TYPE];
				if (_txt.type == TextFieldType.DYNAMIC)
				{
					_txt.selectable = false;
				}else if (_txt.type == TextFieldType.INPUT)
				{
					_txt.selectable = true;
				}
			}
			if (_styleMap[SkinStyle.TEXTFIELD_TEXT_ALIGN])
			{
				_txtFormat.align = _styleMap[SkinStyle.TEXTFIELD_TEXT_ALIGN];
				_txt.setTextFormat(_txtFormat);
			}
			if (_styleMap[SkinStyle.TEXTFIELD_TEXT_BOLD])
			{
				_txtFormat.bold = true;
				_txt.setTextFormat(_txtFormat);
			}
			if (_styleMap[SkinStyle.TEXTFIELD_TEXT_COLOR])
			{
				_txtFormat.color = _styleMap[SkinStyle.TEXTFIELD_TEXT_COLOR];
				_txt.setTextFormat(_txtFormat);
			}
			if (_styleMap[SkinStyle.TEXTFIELD_TEXT_HTML])
			{
				if (_styleMap[SkinStyle.TEXTFIELD_TEXT_HTML] == "text")
				{
					_txtMode = "text";
				}else if (_styleMap[SkinStyle.TEXTFIELD_TEXT_HTML] == "html")
				{
					_txtMode = "html";
				}
			}
			if (_styleMap[SkinStyle.TEXTFIELD_TEXT_SIZE])
			{
				_txtFormat.size = _styleMap[SkinStyle.TEXTFIELD_TEXT_SIZE];
				_txt.setTextFormat(_txtFormat);
			}
			if (_styleMap[SkinStyle.TEXTFIELD_TEXT_COLOR])
			{
				_txtFormat.color = _styleMap[SkinStyle.TEXTFIELD_TEXT_COLOR];
				_txt.setTextFormat(_txtFormat);
			}
		}
		
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			_txt.width = value;
		}
		
		override public function set height(value:Number):void 
		{
			_txt.height = value;
		}
		
		public function set text(str:String):void
		{
			if (_txtMode == "text")
			{
				_txt.text = str;
			}
			else if (_txtMode == "html")
			{
				_txt.htmlText = str;
			}
			_txt.setTextFormat(_txtFormat);
		}
		
		public function get text():String
		{
			return _txt.text;
		}
		
		/**
		 * 设置文本
		 */
		public function setText(str:String=""):void
		{
			if (_txtMode == "text")
			{
				_txt.text = str;
			}else if (_txtMode == "html")
			{
				_txt.htmlText = str;
			}

			if (_showImg)
			{
				_txt.width = _tw;
				_txt.height= _th;
				_txt.htmlText= "<img src='Class_faceMc3'></img>"
			}
			//trace("_txt.width:" + _txt.width, "_txt.height:" + _txt.height);
			//trace("_txt.textWidth:" + _txt.textWidth, "_txt.textHeight:" + _txt.textHeight);

			//_txt.width = _txt.textWidth+4;
			//_txt.height = _txt.textHeight+4;
			_txt.setTextFormat(_txtFormat);
			

		}
		
		public function getText():TextField
		{
			return _txt;
		}
		 
		override public function destroy():void 
		{
		    _styleMap = null;
			_skinObj = null;
			GC.clearAllMc(_backGroundSprite);
			if (_backGroundSprite) GC.killMySelf(_backGroundSprite);
			if (_backGroundSprite && _backGroundSprite.parent) _backGroundSprite.parent.removeChild(_backGroundSprite);
			_backGroundSprite = null;
			_txt = null;
			_txtFormat = null;
			GC.killMySelf(this);
		}
	}

}
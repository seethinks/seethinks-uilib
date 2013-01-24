package com.hezi.uilib.components 
{
	import com.hezi.uilib.core.IbComponentObserver;
	import com.hezi.uilib.core.IbListDataModel;
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.event.StUiEvent;
	import com.hezi.uilib.model.ListDataModel;
	import com.hezi.uilib.skin.SkinStyle;
	import com.hezi.uilib.util.GC;
	import com.hezi.uilib.util.StMotionEffects;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedSuperclassName;
	import flash.display.Sprite;
	
	[Event (name = "STCOMBOBOX_CLICK_CELL", type = "com.hezi.uilib.event.StUiEvent")]

	/**
	 * 下拉组件
	 * @author seethinks@gmail.com
	 */
	
	public class StComboBox extends AbstractComponentBase implements IbComponentObserver
	{
		private var _styleMap:Object;
		private var _stList:StList;
		private var _stTextField:StTextField;
		private var _stListdataList:Array;
		private var _cellSpaceX:Number;
		private var _cellSpaceY:Number;
		private var _targetDecal:Number;
		
		private var _backGroundSprite:Sprite;	
		private var _titleContainer:Sprite;
		private var _titleButtonDefault:Sprite;
		private var _titleButtonClick:Sprite;
		private var _skinObj:Object;
		private var _updataDraw:Boolean;
		private var _defaultTitleShow:Boolean;
		
		/**
		 * 当前选择变量值
		 */
		private var _curObj:Object;
		
		/**
		 * @param	dataList     植入数据
		 * @param	skinObj      皮肤对象
		 * @param	x            
		 * @param	y
		 * @param	cellSpaceX   列表容器的x偏移值
		 * @param	cellSpaceY   列表容器的y偏移值
		 * @param	targetDecal	  滚动条离目标间距 
		 * @param   defaultTitleShow    是否默认显示第一条记录
		 */
		public function StComboBox(dataList:Array, skinObj:Object = null, x:Number = 0, y:Number = 0, cellSpaceX:Number = 4, cellSpaceY:Number = 4, targetDecal:Number = 5, defaultTitleShow:Boolean = false ) 
		{
			if (!dataList) throw new UiLibError(UiLibError.DATA_IS_NOTNULL, StComboBox, "列表数据填充不能为null");
			
			_stListdataList = dataList;
			_skinObj = skinObj;
			_cellSpaceX = cellSpaceX;
			_cellSpaceY = cellSpaceY;
			_targetDecal = targetDecal;
			_defaultTitleShow = defaultTitleShow;
			setLocation(x, y);
			init();
		}
		override public function init():void 
		{
			_styleMap = new Object();
			_backGroundSprite = new Sprite();
			_titleContainer = new Sprite();
			_titleButtonDefault = new Sprite();
			_titleButtonClick = new Sprite();
			_curObj = new Object();
			_updataDraw = false;
			
			// *****************************************        初始化绘制        *********************
			var tempBmp:Bitmap;
			var tempSpr:Sprite;
			var parentType:String;
			var tempObj:*;
			
			// 绘制背景
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.COMBOBOX_TITLE_BG])
				{
					tempObj = _skinObj[SkinStyle.COMBOBOX_TITLE_BG];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.COMBOBOX_TITLE_BG];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.COMBOBOX_TITLE_BG];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.COMBOBOX_TITLE_BG] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.COMBOBOX_TITLE_BG] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.COMBOBOX_TITLE_BG] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StComboBox, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			
			// 绘制 button click
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_CLICK])
				{
					tempObj = _skinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_CLICK];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_CLICK];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_CLICK];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			if (tempObj)
			{
				parentType = getQualifiedSuperclassName(tempObj);
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.COMBOBOX_TITLE_BUTTON_CLICK] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.COMBOBOX_TITLE_BUTTON_CLICK] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.COMBOBOX_TITLE_BUTTON_CLICK] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StComboBox, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			
			
			// 绘制 button default
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_DEFAULT])
				{
					tempObj = _skinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_DEFAULT];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_DEFAULT];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_DEFAULT];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			if (tempObj)
			{

				parentType = getQualifiedSuperclassName(tempObj);
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.COMBOBOX_TITLE_BUTTON_DEFAULT] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.COMBOBOX_TITLE_BUTTON_DEFAULT] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.COMBOBOX_TITLE_BUTTON_DEFAULT] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StComboBox, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}

			// -----------------------------------------        初始化绘制        ---------------------------

			draw();
			
			_stTextField = new StTextField(_skinObj, 2, 2);
			_stTextField.width = _backGroundSprite.width;
			_backGroundSprite.height = _backGroundSprite.height;
			_stTextField.setText("");
			_stTextField.mouseEnabled = false;
			_stTextField.enabled = false;
			addChild(_stTextField);
			_stList = new StList(_stListdataList,_skinObj,0,0,_cellSpaceX,_cellSpaceY,_targetDecal);
			_stList.alpha = 0;
			_stList.visible = false;
			_stList.mouseChildren = false;
			_stList.mouseEnabled = false;
			_stList.enabled = false;
			this.mouseEnabled = false;
			addChild(_stList);
			_stList.y = _backGroundSprite.height;
			_stList.addEventListener(StUiEvent.STLIST_CLICK_CELL, clickListCellHandler);

			if (_stTextField && _defaultTitleShow && _stListdataList[0])
			{
				_stTextField.setText(_stListdataList[0].label);
				_curObj = _stListdataList[0].value;
			}
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
			throw new UiLibError(UiLibError.INTERDICT_CHANGESKIN, StComboBox, "StComboBox组件禁止修改皮肤");
		}
		
		override public function getStyle(styleName:String):Object 
		{
			return super.getStyle(styleName);
		}
		
		override public function draw():void 
		{
			GC.killMySelf(_titleButtonDefault);
			GC.killMySelf(_titleButtonClick);
			GC.clearAllMc(_titleContainer);
			
			_titleButtonDefault = _styleMap[SkinStyle.COMBOBOX_TITLE_BUTTON_DEFAULT] as Sprite;
			_titleButtonClick = _styleMap[SkinStyle.COMBOBOX_TITLE_BUTTON_CLICK] as Sprite;
			if (_titleButtonDefault) _titleContainer.addChild(_titleButtonDefault);
			if (_titleButtonClick) _titleContainer.addChild(_titleButtonClick);
			
			_backGroundSprite = _styleMap[SkinStyle.COMBOBOX_TITLE_BG] as Sprite;
			if (_backGroundSprite) addChild(_backGroundSprite);
			if (_titleContainer) addChild(_titleContainer);
			_titleContainer.x = _backGroundSprite.width;
			_titleContainer.addChild(_titleButtonDefault);
			_titleContainer.addChild(_titleButtonClick);
			
			_titleButtonDefault.buttonMode = true;
			_titleButtonDefault.name = "default";
			_titleButtonClick.buttonMode = true;
			_titleButtonClick.name = "click";
			_titleButtonClick.visible = false;

			_titleButtonDefault.addEventListener(MouseEvent.CLICK, clickTitleHandler,false,0,true);
			_titleButtonClick.addEventListener(MouseEvent.CLICK, clickTitleHandler,false,0,true);
			
			if (!_updataDraw)
			{

			}
		}
		
		/**
		 * 数据更新
		 * @param	obj
		 */
		public function updateDataDraw(obj:IbListDataModel = null):void
		{

			var _obj:ListDataModel = obj as ListDataModel;
			_stListdataList = _obj.ListDataArr;
			_stList.updateDataDraw(_obj);
			
			if (_stTextField && _defaultTitleShow && _stListdataList[0])
			{
				_stTextField.setText(_stListdataList[0].label);
				_curObj = _stListdataList[0].value;
			}else
			{
				_stTextField.text = "";
			}
		}
		
		public function get ComboBoxStList():StList
		{
			return _stList;
		}
		
		/**
		 * 点击标题按钮
		 */
		private function clickTitleHandler(e:MouseEvent):void
		{

			var _curButton:Sprite = e.currentTarget as Sprite;
			if (_curButton.name == "click")
			{
				_titleButtonDefault.visible = true;
				_titleButtonClick.visible = false;
				_stList.alpha = 0;
				_stList.visible = false;
				_stList.mouseChildren = false;
				_stList.mouseEnabled = false;
				_stList.enabled = false;
				this.mouseEnabled = false;
			}else
			{
				_titleButtonDefault.visible = false;
				_titleButtonClick.visible = true;
				_stList.visible = true;
				_stList.mouseChildren = true;
				_stList.mouseEnabled = true;
				_stList.enabled = true;
				this.mouseEnabled = true;
				//_titleButtonDefault.mouseEnabled = true;
				StMotionEffects.to(_stList, .25, { alpha:1} );
			}
			
			if (_stList.visible && stage) stage.addEventListener(MouseEvent.CLICK, hideStListHandler, false, 0, true);
			
			/*this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0, 0, this.width, this.height);
			this.graphics.endFill();*/
		}
		
		private function hideStListHandler(e:MouseEvent):void 
		{
				//trace(this.hitTestPoint(stage.mouseX,stage.mouseY));
				if (this && stage)
				{
					if (!this.hitTestPoint(stage.mouseX,stage.mouseY))
					{
						stage.removeEventListener(MouseEvent.CLICK, hideStListHandler);
						_titleButtonDefault.visible = true;
						_titleButtonClick.visible = false;
						_stList.alpha = 0;
						_stList.visible = false;
						_stList.mouseChildren = false;
						_stList.mouseEnabled = false;
						_stList.enabled = false;
						this.mouseEnabled = false;
					}
				}
		}
		
		/**
		 * 点击List返回数据
		 */
		private function clickListCellHandler(e:StUiEvent):void
		{
			_curObj = e.StListCellValue;
			_stTextField.setText(e.StListCellLabel);
				_titleButtonDefault.visible = true;
				_titleButtonClick.visible = false;
				_stList.alpha = 0;
				_stList.visible = false;
				_stList.mouseChildren = false;
				_stList.mouseEnabled = false;
				_stList.enabled = false;
				this.mouseEnabled = false;
			var sue:StUiEvent = new StUiEvent(StUiEvent.STCOMBOBOX_CLICK_CELL);
			sue.StListCellValue = _curObj;
			dispatchEvent(sue);
		}
		
		public function get CurrentObj():Object
		{
			return _curObj;
		}
		
		override public function destroy():void 
		{
			if (_stListdataList)
			{
				_stListdataList.length = 0;
				_stListdataList = [];
			}
			stage.removeEventListener(MouseEvent.CLICK, hideStListHandler);
			_titleButtonDefault.removeEventListener(MouseEvent.CLICK, clickTitleHandler);
			_titleButtonClick.removeEventListener(MouseEvent.CLICK, clickTitleHandler);
			
			_skinObj = null;
			_styleMap = null;
			GC.killMySelf(this);
			/*GC.clearAllMc(_titleButtonDefault);
			//if (_titleButtonDefault) GC.killMySelf(_titleButtonDefault);
			if (_titleButtonDefault && _titleButtonDefault.parent) _titleButtonDefault.parent.removeChild(_titleButtonDefault);
			_titleButtonDefault = null;
			
			GC.clearAllMc(_titleButtonClick);
			//if (_titleButtonClick) GC.killMySelf(_titleButtonClick);
			if (_titleButtonClick && _titleButtonClick.parent) _titleButtonClick.parent.removeChild(_titleButtonClick);
			_titleButtonClick = null;
			
			GC.clearAllMc(_backGroundSprite);
			//if (_backGroundSprite) GC.killMySelf(_backGroundSprite);
			if (_backGroundSprite && _backGroundSprite.parent) _backGroundSprite.parent.removeChild(_backGroundSprite);
			_backGroundSprite = null;
			
			GC.clearAllMc(_titleContainer);
			//if (_titleContainer) GC.killMySelf(_titleContainer);
			if (_titleContainer && _titleContainer.parent) _titleContainer.parent.removeChild(_titleContainer);
			_titleContainer = null;
			


			if (_stTextField) _stTextField = null;
			if (_stList) _stList = null;
			
			//GC.killMySelf(this);
			delete this;
			GC.Gc();*/
		}
	}

}
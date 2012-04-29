package com.hezi.uilib.components 
{
	import com.hezi.uilib.core.IbComponentObserver;
	import com.hezi.uilib.core.IbListDataModel;
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.event.StUiEvent;
	import com.hezi.uilib.model.ListDataModel;
	import com.hezi.uilib.skin.SkinStyle;
	import com.hezi.uilib.util.GC;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedSuperclassName;
	
	[Event (name="STLIST_CLICK_CELL",type="com.hezi.uilib.event.StUiEvent")]
	/**
	 * 列表组件
	 * @author seethinks@gmail.com
	 */
	public class StList extends AbstractComponentBase implements IbComponentObserver
	{
		private var _scrollBar:StScrollBar;
		private var _backGroundSprite:Sprite;	
		private var _cellContainer:Sprite;
		private var _cellBgList:Vector.<Sprite>;
		private var _cellValueList:Vector.<Object>;
		private var _cellDataList:Array;
		private var _skinObj:Object;
		
		private var _styleMap:Object;
		private var _cellSpaceX:int;
		private var _cellSpaceY:int;
		private var _cellTxtLeftSpace:int;
		private var _txtAlign:String;
		private var _txtSize:int;
		private var _targetDecal:Number;
		
		private var _updataDraw:Boolean;
		
		/**
		 * @param	dataList      植入数据
		 * @param	skinObj       皮肤对象
		 * @param	x
		 * @param	y
		 * @param	cellSpaceX    列表容器的x偏移值
		 * @param	cellSpaceY    列表容器的y偏移值
		 * @param	targetDecal	  滚动条离目标间距 
		 */
		public function StList(dataList:Array, skinObj:Object=null,x:Number = 0, y:Number = 0,cellSpaceX:Number = 4, cellSpaceY:Number = 4,targetDecal:Number=5) 
		{
			if (!dataList) throw new UiLibError(UiLibError.DATA_IS_NOTNULL, StList, "列表数据填充不能为null");
			_skinObj = skinObj;
			_cellBgList = new Vector.<Sprite>;
			_cellValueList = new Vector.<Object>;
			_cellDataList = dataList;
			_cellSpaceX = cellSpaceX;
			_cellSpaceY = cellSpaceY;
			_targetDecal = targetDecal;
			setLocation(x, y);
			init();
		}
		
		override public function init():void 
		{
			_styleMap = new Object();
			_backGroundSprite = new Sprite();
			_cellContainer = new Sprite();
			_cellContainer.x = _cellSpaceX;
			_cellContainer.y = _cellSpaceY;
			_cellTxtLeftSpace = 2;
			_updataDraw = false;
			// *****************************************        初始化绘制        *********************
			var tempBmp:Bitmap;
			var tempSpr:Sprite;
			var parentType:String;
			var tempObj:*;
			
			// 绘制背景
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.LIST_BG])
				{
					tempObj = _skinObj[SkinStyle.LIST_BG];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.LIST_BG];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.LIST_BG];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.LIST_BG] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.LIST_BG] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.LIST_BG] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StList, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			
			// 绘制格子背景
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.LIST_CELL_BG])
				{
					tempObj = _skinObj[SkinStyle.LIST_CELL_BG];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.LIST_CELL_BG];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.LIST_CELL_BG];
			}
			if (tempObj)
			{
				parentType = getQualifiedSuperclassName(tempObj);
				if (parentType.indexOf("Object") !=-1)
				{
					parentType = getQualifiedSuperclassName(tempObj[0]);
					_styleMap[SkinStyle.LIST_CELL_BG] = []; 
				
					if (parentType.indexOf("BitmapAsset") !=-1)
					{
						tempBmp = tempObj[0];
						tempSpr = new Sprite();
						tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
						_styleMap[SkinStyle.LIST_CELL_BG].push(tempSpr);
					}else if (parentType.indexOf("BitmapData") !=-1)
					{
						tempSpr = new Sprite();
						tempSpr.addChild(new Bitmap(BitmapData(tempObj[0]).clone()));
						_styleMap[SkinStyle.LIST_CELL_BG].push(tempSpr);
					}else if (parentType.indexOf("SpriteAsset") !=-1)
					{
						_styleMap[SkinStyle.LIST_CELL_BG].push(SkinStyle.duplicateDisplayObject(tempObj[0]) as Sprite);
					}else
					{
						throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StList, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
					}

					//////////////// two
					parentType = getQualifiedSuperclassName(tempObj[1]);
					if (parentType.indexOf("BitmapAsset") !=-1)
					{
						tempBmp = tempObj[1];
						tempSpr = new Sprite();
						tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
						_styleMap[SkinStyle.LIST_CELL_BG].push(tempSpr);
					}else if (parentType.indexOf("BitmapData") !=-1)
					{
						tempSpr = new Sprite();
						tempSpr.addChild(new Bitmap(BitmapData(tempObj[1]).clone()));
						_styleMap[SkinStyle.LIST_CELL_BG].push(tempSpr);
					}else if (parentType.indexOf("SpriteAsset") !=-1)
					{
						_styleMap[SkinStyle.LIST_CELL_BG].push(SkinStyle.duplicateDisplayObject(tempObj[1]) as Sprite);
					}else
					{
						throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StList, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
					}
				}else
				{
					parentType = getQualifiedSuperclassName(tempObj);
					if (parentType.indexOf("BitmapAsset") !=-1)
					{
						tempBmp = tempObj;
						tempSpr = new Sprite();
						tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
						_styleMap[SkinStyle.LIST_CELL_BG] = tempSpr;
					}else if (parentType.indexOf("BitmapData") !=-1)
					{
						tempSpr = new Sprite();
						tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
						_styleMap[SkinStyle.LIST_CELL_BG] = tempSpr;
					}else if (parentType.indexOf("SpriteAsset") !=-1)
					{
						_styleMap[SkinStyle.LIST_CELL_BG] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
					}else
					{
						throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StList, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
					}
				}

			}

			// -----------------------------------------        初始化绘制        ---------------------------

			draw();
			var scb:StScrollBar = new StScrollBar(_skinObj,this.ListContainer,_targetDecal);
			this.ScrollBar = scb;
			
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
			throw new UiLibError(UiLibError.INTERDICT_CHANGESKIN, StList, "StList组件禁止修改皮肤");
		}
		
		override public function getStyle(styleName:String):Object 
		{
			return super.getStyle(styleName);
		}
		
		override public function draw():void 
		{
			clearCellSpr();
			_backGroundSprite = _styleMap[SkinStyle.LIST_BG] as Sprite;
			
			if (!_updataDraw)
			{
				if (_backGroundSprite) addChild(_backGroundSprite);
				if (_cellContainer) addChild(_cellContainer);
			}
			
			var i:int = 0;
			var l:int = _cellDataList.length;
			var bitMap:Bitmap;
			var bitMapData:BitmapData;
			if (_styleMap[SkinStyle.LIST_CELL_BG])
			{
				var cellSpr:MovieClip;
				var _txt:StTextField;
				if (_styleMap[SkinStyle.LIST_CELL_BG] is Array)
				{
					for (i = 0; i < l; i++)
					{ 
						if (i % 2 == 0)
						{
							cellSpr = SkinStyle.duplicateDisplayObjectWithBitmap(_styleMap[SkinStyle.LIST_CELL_BG][0]) as MovieClip;
						}else
						{
							cellSpr = SkinStyle.duplicateDisplayObjectWithBitmap(_styleMap[SkinStyle.LIST_CELL_BG][1]) as MovieClip;
						}
						cellSpr.y = cellSpr.height * i ;
						_cellContainer.addChild(cellSpr);
						_cellValueList.push(_cellDataList[i].value);
						trace("_cellDataList[i].value:" + _cellDataList[i].value,_cellDataList[i].label);
						
						if (_cellDataList[i].label != "")
						{
							_txt = new StTextField(_skinObj);
							_txt.x = _cellTxtLeftSpace;
							_txt.y = cellSpr.height * i+2 ;
							_txt.width = cellSpr.width-_cellTxtLeftSpace;
							_txt.height = cellSpr.height;
							_txt.text = _cellDataList[i].label;
							//_txt.name = "txt"+i;
							//_txt.enabled = false;
							//_txt.mouseEnabled = false;

							//_cellContainer.addChild(_txt);
							bitMapData = new BitmapData(_txt.width, _txt.height,true,0xffffff);
							bitMapData.draw(_txt,null,null,null,null,true);
							bitMap = new Bitmap(bitMapData);
							bitMap.x = _cellTxtLeftSpace;
							bitMap.y = cellSpr.height * i+2 ;
							_cellContainer.addChild(bitMap);
							cellSpr.name = String(i);
							cellSpr.label = _cellDataList[i].label;
						}
						setBrightness(cellSpr,.3);
						cellSpr.buttonMode = true;
						cellSpr.addEventListener(MouseEvent.CLICK, clickCellHandler,false,0,true);
						cellSpr.addEventListener(MouseEvent.MOUSE_OVER, overCellHandler,false,0,true);
						cellSpr.addEventListener(MouseEvent.MOUSE_OUT, outCellHandler,false,0,true);
						_cellBgList.push(cellSpr);
					}
				}else
				{
					for (i = 0; i < l; i++)
					{ 
						cellSpr = SkinStyle.duplicateDisplayObjectWithBitmap(_styleMap[SkinStyle.LIST_CELL_BG]) as MovieClip;
						cellSpr.y = cellSpr.height * i ;
						_cellContainer.addChild(cellSpr);
						_cellValueList.push(_cellDataList[i].value);
						if (_cellDataList[i].label != "")
						{
							_txt = new StTextField(_skinObj);
							_txt.x = _cellTxtLeftSpace;
							_txt.y = cellSpr.height * i +2;
							_txt.width = cellSpr.width-_cellTxtLeftSpace;
							_txt.height = cellSpr.height;
							_txt.text = _cellDataList[i].label;
							/*_txt.name = "txt"+i;
							_txt.enabled = false;
							_txt.mouseEnabled = false;
							cellSpr.name = String(i);
							_cellContainer.addChild(_txt);*/

							bitMapData = new BitmapData(_txt.width, _txt.height,true,0xffffff);
							bitMapData.draw(_txt,null,null,null,null,true);
							bitMap = new Bitmap(bitMapData);
							bitMap.x = _cellTxtLeftSpace;
							bitMap.y = cellSpr.height * i+2 ;
							_cellContainer.addChild(bitMap);
							cellSpr.name = String(i);
							cellSpr.label = _cellDataList[i].label;
						}
						setBrightness(cellSpr,.3);
						cellSpr.buttonMode = true;
						cellSpr.addEventListener(MouseEvent.CLICK, clickCellHandler,false,0,true);
						cellSpr.addEventListener(MouseEvent.MOUSE_OVER, overCellHandler,false,0,true);
						cellSpr.addEventListener(MouseEvent.MOUSE_OUT, outCellHandler,false,0,true);
						_cellBgList.push(cellSpr);
					}
				}
			}
		}
		
		private function clickCellHandler(e:MouseEvent):void 
		{
			var spr:MovieClip = e.currentTarget as MovieClip;
		
			var index:int = int(spr.name);
			//var txt:StTextField = spr.parent.getChildByName("txt"+index) as StTextField;
			var sue:StUiEvent = new StUiEvent(StUiEvent.STLIST_CLICK_CELL);
			sue.StListCellValue = _cellValueList[index];
			sue.StListCellLabel = spr.label;
			dispatchEvent(sue);
		}
		
		private function outCellHandler(e:MouseEvent):void 
		{
			//e.currentTarget.alpha = 1;
			setBrightness(e.currentTarget as DisplayObject,.3);
		}
		
		private function overCellHandler(e:MouseEvent):void 
		{
			//e.currentTarget.alpha = .6;
			//trace("ddddddddddddd:"+e.currentTarget.numChildren);
			setBrightness(e.currentTarget as DisplayObject,0);
		}
		
		public function setBrightness(obj:DisplayObject,value:Number):void {
			var colorTransformer:ColorTransform = obj.transform.colorTransform;
			var backup_filters:* = obj.filters;
			if (value >= 0) {
				colorTransformer.blueMultiplier = 1 - value;
				colorTransformer.redMultiplier = 1 - value;
				colorTransformer.greenMultiplier = 1 - value;
				colorTransformer.redOffset = 255 * value;
				colorTransformer.greenOffset = 255 * value;
				colorTransformer.blueOffset = 255 * value;
			}else {
				value=Math.abs(value)
				colorTransformer.blueMultiplier = 1 - value;
				colorTransformer.redMultiplier = 1 - value;
				colorTransformer.greenMultiplier = 1 - value;
				colorTransformer.redOffset = 0;
				colorTransformer.greenOffset = 0;
				colorTransformer.blueOffset = 0;
			}
			
			obj.transform.colorTransform = colorTransformer;
			obj.filters = backup_filters;
		}
		
		/**
		 * 数据更新
		 * @param	obj
		 */
		public function updateDataDraw(obj:IbListDataModel = null):void
		{
			var _obj:ListDataModel = obj as ListDataModel;
			//_cellDataList.length = 0;
			_cellDataList = _obj.ListDataArr;
			trace("_cellDataList:" + _cellDataList.length );
			_updataDraw = true;
			redraw();
		}
		
		private function clearCellSpr():void
		{
			for (var str:* in _cellBgList)
			{
				_cellBgList[str].removeEventListener(MouseEvent.CLICK, clickCellHandler);
				_cellBgList[str].removeEventListener(MouseEvent.MOUSE_OVER, overCellHandler);
				_cellBgList[str].removeEventListener(MouseEvent.MOUSE_OUT, outCellHandler);
				_cellBgList[str] = null;
			}
			GC.clearAllMc(_cellContainer);
			_cellBgList.length = 0;
			_cellValueList.length = 0;
		}
		
		/**
		 * 修改item属性
		 * @param	index
		 */
		public function ChangeCellItemObject(index:int,obj:Object):void
		{
			_cellValueList[index] = obj.value;
			if (obj.label != "")
			{
				var _txt:StTextField = _cellBgList[index].getChildByName("txt") as StTextField;
				_txt.text = obj.label;
			}
		}
		
		/**
		 * 返回列表容器
		 */
		public function get ListContainer():Sprite
		{
			return _cellContainer;
		}
		
		/**
		 * 植入滚动条
		 */
		public function set ScrollBar(scrollBar:StScrollBar):void
		{
			_scrollBar = scrollBar;
			addChild(_scrollBar);
		}
		
		/**
		 * 外调滚动条
		 */
		public function get ScrollBar():StScrollBar
		{
			return _scrollBar;
		}
		
		/**
		 * 滚动条复原
		 */
		public function setScrollBarInit():void
		{
			_scrollBar.setScrollBarInit();
		}
		
		override public function destroy():void 
		{
			_skinObj = null;
			_styleMap = null;
			
			/*clearCellSpr();
			GC.clearAllMc(_backGroundSprite);
			
			//if (_backGroundSprite) GC.killMySelf(_backGroundSprite);
			if (_backGroundSprite && _backGroundSprite.parent) _backGroundSprite.parent.removeChild(_backGroundSprite);
			_backGroundSprite = null;
			
			//if (_cellContainer) GC.killMySelf(_cellContainer);
			if (_cellContainer && _cellContainer.parent) _cellContainer.parent.removeChild(_cellContainer);
			_cellContainer = null;
			
			if (_scrollBar)
			{
				if (_scrollBar && _scrollBar.parent) _scrollBar.parent.removeChild(_scrollBar);
			}

			if (_cellDataList)
			{
				_cellDataList.length = 0;
				_cellDataList = null;
			}

			if (_cellBgList) _cellBgList = null;
			if (_cellValueList) _cellValueList = null;	
			//GC.killMySelf(this);
			delete this;
			GC.Gc();*/
		}
	}

}
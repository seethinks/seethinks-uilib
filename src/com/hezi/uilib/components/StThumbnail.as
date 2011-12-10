package com.hezi.uilib.components 
{
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.event.StUiEvent;
	import com.hezi.uilib.skin.SkinStyle;
	import com.hezi.uilib.util.ChangePage;
	import com.hezi.uilib.util.GC;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedSuperclassName;
	
	[Event (name="STTHUMBNAIL_CHANGEPAGE",type="com.hezi.uilib.event.StUiEvent")]
	/**
	 * 缩略图组件
	 * @author seethinks@gmail.com
	 */
	public class StThumbnail extends AbstractComponentBase 
	{
		private var _backGroundSprite:Sprite;
		private var _iconContainer:Sprite;
		private var _thumbNailDataList:Array;
		private var _preButton:StButton;
		private var _nextButton:StButton;
		private var _curPage:int;
		private var _showTotalPage:int;
		private var _totalPage:int;
		private var _skinObj:Object;
		private var _styleMap:Object;
		private var _cellSpaceX:Number;
		private var _cellSpaceY:Number;
		private var _rowSpaceX:Number;
		private var _rowSpaceY:Number;
		private var _curIndex:int;
		private var _row:int;
		private var _cell:int;
		
		/**
		 * @param	dataList    植入数据
		 * @param	skinObj		皮肤对象
		 * @param	x
		 * @param	y
		 */
		public function StThumbnail(skinObj:Object = null, x:Number = 0, y:Number = 0, cellSpaceX:Number = 4, cellSpaceY:Number = 4, rowSpaceX:Number = 4, rowSpaceY:Number = 4,row:int = 4,cell:int = 2 ) 
		{
			_skinObj = skinObj;
			_cellSpaceX = cellSpaceX;
			_cellSpaceY = cellSpaceY;
			_rowSpaceX = rowSpaceX;
			_rowSpaceY = rowSpaceY;
			_row = row;
			_cell = cell;
			_showTotalPage = _row * _cell;
			setLocation(x, y);
			init();
		}
		override public function init():void 
		{
			_backGroundSprite = new Sprite();
			_iconContainer = new Sprite();
			_styleMap = new Object();
			_curPage = 1;
			_curIndex = 0;

			// *****************************************        初始化绘制        *********************
			var tempBmp:Bitmap;
			var tempSpr:Sprite;
			var parentType:String;
			var tempObj:*;
			
			// 绘制背景
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.THUMBNAIL_BG])
				{
					tempObj = _skinObj[SkinStyle.THUMBNAIL_BG];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.THUMBNAIL_BG];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.THUMBNAIL_BG];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.THUMBNAIL_BG] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.THUMBNAIL_BG] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.THUMBNAIL_BG] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StThumbnail, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			
			/**
			 * 绘制往前翻页按钮
			 */
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.THUMBNAIL_PREVBTN])
				{
					tempObj = _skinObj[SkinStyle.THUMBNAIL_PREVBTN];
					_styleMap[SkinStyle.THUMBNAIL_PREVBTNPOSI] = _skinObj[SkinStyle.THUMBNAIL_PREVBTNPOSI];
					//trace("a:"+_styleMap[SkinStyle.THUMBNAIL_PREVBTNPOSI]);
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.THUMBNAIL_PREVBTN];
					_styleMap[SkinStyle.THUMBNAIL_PREVBTNPOSI] = SkinStyle.Skin.SkinObj[SkinStyle.THUMBNAIL_PREVBTNPOSI];
					//trace("b:"+_styleMap[SkinStyle.THUMBNAIL_PREVBTNPOSI]);
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.THUMBNAIL_PREVBTN];
				_styleMap[SkinStyle.THUMBNAIL_PREVBTNPOSI] = SkinStyle.Skin.SkinObj[SkinStyle.THUMBNAIL_PREVBTNPOSI];
				//trace("c:"+_styleMap[SkinStyle.THUMBNAIL_PREVBTNPOSI]);
			}
			if (!tempObj) 
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StThumbnail, "翻页按钮不可为空");
			}else
			{
				_preButton = tempObj;
				//trace("d:"+_styleMap[SkinStyle.THUMBNAIL_PREVBTNPOSI]);
			}
			
			/**
			 * 绘制往后翻页按钮
			 */
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.THUMBNAIL_NEXTBTN])
				{
					tempObj = _skinObj[SkinStyle.THUMBNAIL_NEXTBTN];
					_styleMap[SkinStyle.THUMBNAIL_NEXTBTNPOSI] = _skinObj[SkinStyle.THUMBNAIL_NEXTBTNPOSI];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.THUMBNAIL_NEXTBTN];
					_styleMap[SkinStyle.THUMBNAIL_NEXTBTNPOSI] = SkinStyle.Skin.SkinObj[SkinStyle.THUMBNAIL_NEXTBTNPOSI];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.THUMBNAIL_NEXTBTN];
			}
			if (!tempObj)
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StThumbnail, "翻页按钮不可为空");
			}else
			{
				_nextButton = tempObj;
			}

			/**
			 * 绘制
			 */
			draw();
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler,false,0,true);
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
			_backGroundSprite = _styleMap[SkinStyle.THUMBNAIL_BG] as Sprite;
			if (_backGroundSprite) addChild(_backGroundSprite);
			_preButton.x = _styleMap[SkinStyle.THUMBNAIL_PREVBTNPOSI].x;
			_preButton.y = _styleMap[SkinStyle.THUMBNAIL_PREVBTNPOSI].y;
			addChild(_preButton);
			
			_nextButton.x = _styleMap[SkinStyle.THUMBNAIL_NEXTBTNPOSI].x;
			_nextButton.y = _styleMap[SkinStyle.THUMBNAIL_NEXTBTNPOSI].y;
			addChild(_nextButton);
			
			addChild(_iconContainer);
		}
		
		/**
		 * 当前索引存储器
		 */
		public function set CurIndex(i:int):void
		{
			_curIndex = i;
		}
		public function get CurIndex():int
		{
			return _curIndex;
		}
		
		/**
		 * 绘制Icon
		 * @param	dataList  显示对象列表
		 * @param	offX	  X偏移值
		 * @param	offY	  Y偏移值
		 */
		private var _offX:Number = 0;
		private var _offY:Number = 0;
		public function drawIcon(dataList:Array,offX:Number,offY:Number):void
		{
			if (!dataList) throw new UiLibError(UiLibError.DATA_IS_NOTNULL, StThumbnail, "缩略图数据填充不能为null");
			_thumbNailDataList = dataList;
			_totalPage = Math.ceil(_thumbNailDataList.length / _showTotalPage);

			if (!_preButton.hasEventListener(MouseEvent.CLICK))
			{
				_preButton.addEventListener(MouseEvent.CLICK, prevPage);
			}
			if (!_nextButton.hasEventListener(MouseEvent.CLICK))
			{
				_nextButton.addEventListener(MouseEvent.CLICK, nextPage);
			}
			_offX = offX;
			_offY = offY;
			showPage();
		}
		
		public function addIcon(spr:*):void
		{
			_thumbNailDataList.unshift(spr);
			_totalPage = Math.ceil(_thumbNailDataList.length / _showTotalPage);
			showPage();
		}
		
		private function hideCellAll():void
		{
			for (var i:int = 0; i < _iconContainer.numChildren; i++)
			{
				_iconContainer.getChildAt(i).visible = false;
			}
		}
		private function showPage():void
		{
			hideCellAll();
			var i:int = 0;
			var tempList:Array = ChangePage.showRight(_thumbNailDataList, _showTotalPage, _curPage);
			var cellId:int=0;
			for (i = 0; i < tempList.length; i++) 
			{
				var tempSpr:* = _thumbNailDataList[tempList[cellId]];
				tempSpr.x =	cellId % _row * (_cellSpaceX+tempSpr.width)+_offX;
				tempSpr.y =  Math.floor(cellId / _row) * (_cellSpaceY + tempSpr.height) + _offY;
				tempSpr.visible = true;
				_iconContainer.addChild(tempSpr);
				cellId++;
			}
			this.dispatchEvent(new StUiEvent(StUiEvent.STTHUMBNAIL_CHANGEPAGE));
			
			//trace("_curPage:"+_curPage,_totalPage);
			if (_curPage<=1) {
				_preButton.setDisable(false);
			} else {
				_preButton.setDisable(true);
			}

			if (_curPage>=_totalPage) {
				_nextButton.setDisable(false);
			} else {
				_nextButton.setDisable(true);
			}
		}
		
		private function nextPage(e:MouseEvent):void 
		{
			if (_curPage<_totalPage) {
				_curPage++;
				showPage();
			}
		}
		
		private function prevPage(e:MouseEvent):void 
		{
			if (_curPage>1) {
				_curPage--;
				showPage();
			}
		}
		
		public function get TotalPage():int
		{
			if (_totalPage == 0) _totalPage = 1;
			return _totalPage;
		}
		
		public function get CurPage():int
		{
			return _curPage;
		}
		
		override public function destroy():void 
		{
			_skinObj = null;
			_styleMap = null;	
			_thumbNailDataList = null;
			
			/*GC.clearAllMc(_backGroundSprite);
			//if (_backGroundSprite) GC.killMySelf(_backGroundSprite);
			if (_backGroundSprite && _backGroundSprite.parent) _backGroundSprite.parent.removeChild(_backGroundSprite);
			_backGroundSprite = null;
			
			//GC.killMySelf(this);
			delete this;
			GC.Gc();*/
		}
	}

}
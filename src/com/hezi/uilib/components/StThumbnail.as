package com.hezi.uilib.components 
{
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.skin.SkinStyle;
	import com.hezi.uilib.util.GC;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.utils.getQualifiedSuperclassName;
	/**
	 * 缩略图组件
	 * @author seethinks@gmail.com
	 */
	public class StThumbnail extends AbstractComponentBase 
	{
		private var _backGroundSprite:Sprite;
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
		private var _curIndex:int;
		
		/**
		 * @param	dataList    植入数据
		 * @param	skinObj		皮肤对象
		 * @param	x
		 * @param	y
		 */
		public function StThumbnail(dataList:Array, skinObj:Object = null, x:Number = 0, y:Number = 0, cellSpaceX:Number = 4, cellSpaceY:Number = 4, showTotalPage:int = 4 ) 
		{
			if (!dataList) throw new UiLibError(UiLibError.DATA_IS_NOTNULL, StThumbnail, "缩略图数据填充不能为null");
			_thumbNailDataList = dataList;
			_skinObj = skinObj;
			_cellSpaceX = cellSpaceX;
			_cellSpaceY = cellSpaceY;
			_showTotalPage = showTotalPage;
			setLocation(x, y);
			init();
		}
		override public function init():void 
		{
			_backGroundSprite = new Sprite();
			_styleMap = new Object();
			_curPage = 1;
			_totalPage = Math.ceil(_thumbNailDataList.length / _showTotalPage);
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
			
			draw();
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
		
		override public function destroy():void 
		{
			_skinObj = null;
			_styleMap = null;	
			
			GC.clearAllMc(_backGroundSprite);
			if (_backGroundSprite) GC.killMySelf(_backGroundSprite);
			if (_backGroundSprite && _backGroundSprite.parent) _backGroundSprite.parent.removeChild(_backGroundSprite);
			_backGroundSprite = null;
			
			GC.killMySelf(this);
			delete this;
			GC.Gc();
		}
	}

}
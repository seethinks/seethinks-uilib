package com.hezi.uilib.components 
{
	import com.hezi.uilib.Error.UiLibError;
	/**
	 * 缩略图组件
	 * @author seethinks@gmail.com
	 */
	public class StThumbnail extends AbstractComponentBase 
	{
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
			_styleMap = new Object();
			_curPage = 1;
			_totalPage = Math.ceil(_thumbNailDataList.length / _showTotalPage);
			trace(_totalPage);
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

		}
		
		override public function destroy():void 
		{
			_skinObj = null;
			_styleMap = null;	
		}
	}

}
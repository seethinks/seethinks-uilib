package com.hezi.uilib.components 
{
	import com.hezi.uilib.core.IbComponentObserver;
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.skin.SkinStyle;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getQualifiedSuperclassName;
	
	[Event (name = "CHANGE_SIZE", type = "com.hezi.uilib.event.StUiEvent")]
	
	/**
	 * 风琴面板组件
	 * @author seethinks@gmail.com
	 */
	public class StAccordion extends AbstractComponentBase implements IbComponentObserver
	{
		private var _titleSprList:Array;
		private var _styleMap:Object;
		private var _titleNum:int;
		private var _space:int;
		
		private var _cellSprList:Array;
		
		public function StAccordion(x:Number = 0, y:Number = 0, space:int = 5) 
		{
			setLocation(x, y);
			_space = space;
			init();
		}
		
		override public function init():void 
		{
			_styleMap = new Object();
			_titleSprList = [];
			_cellSprList = [];
			_titleNum = 0;
			
			// *****************************************        初始化绘制        *********************
			var i:int = 0;
			var l:int = SkinStyle.Skin.SkinObj[SkinStyle.ACCORDION_TITLE_LIST].length;
			_titleNum = l;
			var parentType:String;
			for (i = 0; i < l; i++)
			{
				parentType = getQualifiedSuperclassName(SkinStyle.Skin.SkinObj[SkinStyle.ACCORDION_TITLE_LIST][i]);
				if (parentType.indexOf("SpriteAsset") !=-1 || parentType.indexOf("MovieClipAsset"))
				{
					_styleMap[SkinStyle.Skin.SkinObj[SkinStyle.ACCORDION_TITLE_LIST][i]] = SkinStyle.duplicateDisplayObject(SkinStyle.Skin.SkinObj[SkinStyle.ACCORDION_TITLE_LIST][i]);
					var tempSpr:Sprite = new Sprite();
					_titleSprList.push(tempSpr);
					addChild(tempSpr);
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StAccordion, "参数应该为图类型,应继承自[MovieClipAsset,SpriteAsset]");
				}
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
			// throw new UiLibError(UiLibError.INTERDICT_CHANGESKIN, StAccordion, "StAccordion组件禁止修改皮肤");
		}
		
		override public function getStyle(styleName:String):Object 
		{
			return super.getStyle(styleName);
		}
		
		override public function draw():void 
		{
			var i:int = 0;
			for (i = 0; i < _titleNum; i++)
			{
				_titleSprList[i].addChild(_styleMap[SkinStyle.Skin.SkinObj[SkinStyle.ACCORDION_TITLE_LIST][i]]);
			}
			setTitleLocation();
		}
		
		/**
		 * 设置标题位置
		 */
		private function setTitleLocation():void 
		{
			var i:int = 0;
			var h:Number = 0;
			for (i = 0; i < _titleNum; i++)
			{
				h += _titleSprList[i].height;
			}
			h /= _titleNum;
			h += _space;
			for (i = 0; i < _titleNum; i++)
			{
				_titleSprList[i].y = i * h;
			}
		}
			
		public function updateDataDraw(obj:Object = null):void
		{
			trace("obj:"+obj.testNum);
		}
		
		override public function destroy():void 
		{
			_titleSprList = [];
			_cellSprList = [];
			_styleMap = [];
			
		}
	}

}
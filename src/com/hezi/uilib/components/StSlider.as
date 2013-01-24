package com.hezi.uilib.components 
{
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.event.StUiEvent;
	import com.hezi.uilib.skin.SkinStyle;
	import com.hezi.uilib.util.GC;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getQualifiedSuperclassName;

	[Event (name="StUiEvent.STSLIDER_CHANGE_VALUE",type="com.hezi.uilib.event.StUiEvent")]
	/**
	 * 滑块组件
	 * @author seethinks@gmail.com
	 */
	public class StSlider extends AbstractComponentBase 
	{
		public static const VERTICAL:String = "vertical";
		public static const HORIZONTAL:String 	= "horizontal";
		private var _trackSpr:Sprite;
		private var _trackSubSpr:Sprite;
		private var _thumbSpr:Sprite;
		private var _thumbSubSpr:Sprite;
		private var _skinObj:Object;
		private var _scrollDir:String;
		private var _scrollSpeed:Number;
		private var _trackHeight:Number;
		private var _styleMap:Object;
		private var _wheelSpeed:Number;
		private var _wheelStrenght:Number;
		private var _posPercent:Number;
		private var _newPosTarget:Number;
		private var _minNum:Number;
		private var _maxNum:Number;
		private var _curNum:Number;
		private var _stepNum:Number;
		private var _valueEvent:StUiEvent;
		
		public function StSlider(skinObj:Object = null, x:Number = 0, y:Number = 0, direction:String = VERTICAL, scrollSpeed:Number = .5, trackHeight:Number = 100, minNum:Number = 0, maxNum:Number = 100, stepNum:Number = 0 ) 
		{
			_skinObj = skinObj;
			_scrollDir = direction;
			_scrollSpeed = scrollSpeed;
			_trackHeight = trackHeight;
			_minNum = minNum;
			_maxNum = maxNum;
			_stepNum = stepNum;
			setLocation(x, y);
			init();
		}
		override public function init():void 
		{
			_styleMap = new Object();
			_wheelSpeed = 3;
			_wheelStrenght = 3;
			_scrollSpeed = 1 - _scrollSpeed;
			_curNum = _minNum;

			_trackSpr = new Sprite();
			_thumbSpr = new Sprite();
			_trackSubSpr = new Sprite();
			_thumbSubSpr = new Sprite();
			addChild(_trackSpr);
			addChild(_thumbSpr);
			_thumbSpr.buttonMode = true;
			_valueEvent = new StUiEvent(StUiEvent.STSLIDER_CHANGE_VALUE);
			
			// *****************************************        初始化绘制        *********************
			var tempBmp:Bitmap;
			var tempSpr:Sprite;
			var parentType:String;
			var tempObj:*;
			
			// track
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.SLIDER_TRACK])
				{
					tempObj = _skinObj[SkinStyle.SLIDER_TRACK];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.SLIDER_TRACK];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.SLIDER_TRACK];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.SCROLLBAR_TRACK] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.SCROLLBAR_TRACK] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.SCROLLBAR_TRACK] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StSlider, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}	
			}
			
			// _thumbSpr
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.SLIDER_THUMB])
				{
					tempObj = _skinObj[SkinStyle.SLIDER_THUMB];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.SLIDER_THUMB];
				}			
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.SLIDER_THUMB];
			}
			parentType = getQualifiedSuperclassName(tempObj);
			
			if (tempObj)
			{
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = tempObj;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[SkinStyle.SCROLLBAR_THUMB] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(tempObj).clone()));
					_styleMap[SkinStyle.SCROLLBAR_THUMB] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[SkinStyle.SCROLLBAR_THUMB] = SkinStyle.duplicateDisplayObject(tempObj) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StSlider, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			// -----------------------------------------        初始化绘制        ---------------------------
			
			draw();
			
			_thumbSpr.addEventListener(MouseEvent.MOUSE_DOWN, startDragThumb);
			_trackSpr.addEventListener(MouseEvent.CLICK, clickTrackHandler);
			this.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
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
		}
		
		override public function getStyle(styleName:String):Object 
		{
			return super.getStyle(styleName);
		}
		
		override public function draw():void 
		{
			GC.killMySelf(_trackSubSpr);
			GC.killMySelf(_thumbSubSpr);
			GC.clearAllMc(_trackSpr);
			GC.clearAllMc(_thumbSpr);
			_trackSubSpr = _styleMap[SkinStyle.SCROLLBAR_TRACK] as Sprite;
			_thumbSubSpr = _styleMap[SkinStyle.SCROLLBAR_THUMB] as Sprite;
			if (_trackSubSpr) _trackSpr.addChild(_trackSubSpr);
			if (_thumbSubSpr) _thumbSpr.addChild(_thumbSubSpr);
			setupDirLocation();
		}
		
		/**
		 * 设置Slider的方向
		*/
		private function setupDirLocation():void 
		{
			if (_scrollDir == VERTICAL)
			{
				_trackSpr.x = 0;
				_trackSpr.y = 0;
				if (_trackSpr.height >0) _trackHeight = _trackSpr.height;
				_thumbSpr.x = _trackSpr.width/2-_thumbSpr.width/2;
				_thumbSpr.y =0;
			}
			else if (_scrollDir == HORIZONTAL)
			{
				_trackSpr.x = 0;
				_trackSpr.y = 0;
				if (_trackSpr.height >0) _trackHeight = _trackSpr.height;
				_thumbSpr.x = _trackSpr.width/2-_thumbSpr.width/2;
				_thumbSpr.y = -(_trackSpr.width/2-_thumbSpr.width/2);
				
				_trackSpr.rotation = 270;
				_thumbSpr.rotation = 270;
			}
		}
		
		/**
		 * 内部渲染逻辑
		 */
		
		/**
		 * 点击Slider
		 * @param	evt
		 */
		private function clickTrackHandler(evt:MouseEvent):void
		{
				var trackClicPos:Number;
				if (_scrollDir == VERTICAL)
				{
					trackClicPos = evt.stageY-this.y-this.parent.y;
				}
				else if (_scrollDir == HORIZONTAL)
				{
					trackClicPos = evt.stageX-this.x-this.parent.x;
				}
				moveThumb(trackClicPos);
		}

		/**
		 * 鼠标滚动
		 * @param	evt
		 */
		private function mouseWheelHandler(evt:MouseEvent):void
		{
			var thumbWheelPos:Number;
			if (_scrollDir == VERTICAL)
			{
				thumbWheelPos = _thumbSpr.y-evt.delta*_wheelStrenght;
			}
			else if (_scrollDir == HORIZONTAL)
			{
				thumbWheelPos = _thumbSpr.x-evt.delta*_wheelStrenght;
			}
			moveThumb(thumbWheelPos);
		}
		 
		private var _offNum:Number; // 偏移存储值
		private function startDragThumb(evt:MouseEvent):void
		{
			_offNum = evt.localY; 
			_thumbSpr.removeEventListener(MouseEvent.MOUSE_DOWN, startDragThumb);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopDragThumb);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function mouseMoveHandler(evt:MouseEvent):void
		{
			var thumbNewPos:Number;
			var tp:Point = this.localToGlobal(new Point(stage.x, stage.y));
			if (_scrollDir == VERTICAL)
			{
				thumbNewPos = evt.stageY - tp.y - _offNum;
			}
			else if (_scrollDir == HORIZONTAL)
			{
				thumbNewPos = evt.stageX - tp.x - _offNum;
			}
			moveThumb(thumbNewPos);
		}
		
		private function moveThumb(pThumbNewPos:Number):void
		{
			if (_scrollDir == VERTICAL)
			{
				if (pThumbNewPos<0)
				{
					_thumbSpr.y = 0;
				}
				else if (pThumbNewPos >_trackHeight-_thumbSpr.height)
				{
					_thumbSpr.y = _trackHeight-_thumbSpr.height;
				}
				else
				{
					_thumbSpr.y = pThumbNewPos;
				}
				moveTargetVerticaly(_thumbSpr.y);
			}
			else if (_scrollDir == HORIZONTAL)
			{
				if (pThumbNewPos<0)
				{
					_thumbSpr.x = 0;
				}
				else if (pThumbNewPos >_trackHeight-_thumbSpr.width)
				{
					_thumbSpr.x = _trackHeight-_thumbSpr.width;
				}
				else
				{
					_thumbSpr.x = pThumbNewPos;
				}
				moveTargetHorizontaly(_thumbSpr.x);
			}
		}
				
		private function moveTargetHorizontaly(thumbX:Number):void
		{
			var tn:Number = _maxNum - _minNum;
			_posPercent = (tn * thumbX) / (_trackHeight - _thumbSpr.width - 1);
			_curNum = int(_posPercent + _minNum);
			this.dispatchEvent(_valueEvent);
			//_newPosTarget = (_target.width - _trackHeight) * _posPercent * 0.01;
		}
		
		private function moveTargetVerticaly(thumbY:Number):void
		{
			var tn:Number = _maxNum - _minNum;
			_posPercent = (tn * thumbY) / (_trackHeight - _thumbSpr.height);
			_curNum = int(_posPercent + _minNum);
			this.dispatchEvent(_valueEvent);
			/*if (_haveVisibleModeNum == -1)
			{
				_newPosTarget = (_target.height - _trackHeight) * _posPercent * 0.01;
			}else
			{
				_newPosTarget = (_haveVisibleModeNum - _trackHeight) * _posPercent * 0.01;
			}*/
		}
		
		private function stopDragThumb(evt:MouseEvent):void
		{
			_thumbSpr.addEventListener(MouseEvent.MOUSE_DOWN, startDragThumb);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragThumb);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		/**
		 * get/set
		 */
		public function set Value(num:Number):void
		{
			_curNum = num ;
		}
		public function get Value():Number
		{
			return _curNum;
		}
		 
		override public function destroy():void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragThumb);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			_thumbSpr.removeEventListener(MouseEvent.MOUSE_DOWN, startDragThumb);
			_trackSpr.removeEventListener(MouseEvent.CLICK, clickTrackHandler);
			this.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);

			GC.killMySelf(_trackSubSpr);
			GC.killMySelf(_thumbSubSpr);
			GC.killMySelf(_trackSpr);
			GC.killMySelf(_thumbSpr);
			if (_trackSubSpr && _trackSubSpr.parent) _trackSubSpr.parent.removeChild(_trackSubSpr);
			if (_thumbSubSpr && _thumbSubSpr.parent) _thumbSubSpr.parent.removeChild(_thumbSubSpr);
			if (_trackSpr && _trackSpr.parent) _trackSpr.parent.removeChild(_trackSpr);
			if (_thumbSpr && _thumbSpr.parent) _thumbSpr.parent.removeChild(_thumbSpr);
			_trackSubSpr = null;
			_thumbSubSpr = null;
			_trackSpr = null;
			_thumbSpr = null;
			_styleMap = null ;
			_valueEvent = null;
			GC.killMySelf(this);
		}
	}

}
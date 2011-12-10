package com.hezi.uilib.components 
{
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.event.StUiEvent;
	import com.hezi.uilib.skin.SkinStyle;
	import com.hezi.uilib.util.GC;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.registerClassAlias;
	import flash.utils.getQualifiedSuperclassName;
	
	/**
	 * 滚动条组件
	 * @author seethinks@gmail.com
	 */
	public class StScrollBar extends AbstractComponentBase 
	{
		public static const VERTICAL:String = "vertical";
		public static const HORIZONTAL:String 	= "horizontal";
		
		private var _skinObj:Object;
		private var _target:Sprite;
		private var _trackSpr:Sprite;
		private var _trackSubSpr:Sprite;
		private var _thumbSpr:Sprite;
		private var _thumbSubSpr:Sprite;
		private var _scrollMask:Sprite; 
		private var _maskShape:Shape;
		
		private var _scrollDir:String;
		private var _scrollSpeed:Number;
		private var _trackHeight:Number;
		private var _styleMap:Object;
		private var _stageDecalX:Number;
		private var _stageDecalY:Number;
		private var _decal:Number;
		private var _wheelSpeed:Number;
		private var _wheelStrenght:Number;
		private var _posPercent:Number;
		private var _newPosTarget:Number;
		
		private var _haveVisibleModeHeigth:Number; // 特殊变量，有些目标对象可能会有隐藏对象，此值不为0，就按此值滚动
		private var _cacheAsBitmap:Boolean;
		private var _exceedHeightNoShow:Boolean; // 超出高度不显示滚动按钮
		private var _stageScroll:Boolean;
		
		/**
		 * 具体滚动条类构造函数
		 * @param   skinObj						    皮肤对象
		 * @param	target                          目标对象
		 * @param	targetDecal						离目标最右的偏移值	
		 * @param	haveVisibleModeHeigth           特殊变量，有些目标对象可能会有隐藏对象，此值不为0，就按此值滚动
		 * @param	direction                       方向
		 * @param	scrollSpeed                     滚动速度
		 * @param	trackHeight                     轨迹高度
		 * @param	cacheBitmap                     目标对象是否转cacheBitmap
		 * @param	exceedHeightNoShow              是否在对象不足滚动条高度时候，滚动按钮进行隐藏
		 * @param   stageScroll						是否在整个舞台滚动
		 */
		public function StScrollBar(skinObj:Object=null,target:Sprite = null,targetDecal:Number=5, haveVisibleModeHeigth:Number = -1 , direction:String = VERTICAL, scrollSpeed:Number = .5, trackHeight:Number = 100, cacheBitmap:Boolean = false, exceedHeightNoShow:Boolean = false,stageScroll:Boolean = false ) 
		{
			_skinObj = skinObj;
			_target = target;
			_scrollDir = direction;
			_scrollSpeed = scrollSpeed;
			_trackHeight = trackHeight;
			_haveVisibleModeHeigth = haveVisibleModeHeigth;
			_cacheAsBitmap = cacheBitmap;
			_exceedHeightNoShow = exceedHeightNoShow;
			_decal = targetDecal;
			_stageScroll = stageScroll;
			init();
		}
		
		override public function init():void 
		{
			_styleMap = new Object();
			_wheelSpeed = 3;
			_wheelStrenght = 3;
			_scrollSpeed = 1 - _scrollSpeed;
			if (!_target) 
			{
				throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StScrollBar, "滚动条的目标对象不能为null");
			}

			_target.cacheAsBitmap = _cacheAsBitmap;
			_target.addEventListener(StUiEvent.CHANGE_SIZE, targetChangeSizeHandler);
			var origine:Point = this.globalToLocal(new Point(_target.x,_target.y));
			var decal:Point = localToGlobal(origine);
			_stageDecalX = decal.x - origine.x;
			_stageDecalY = decal.y - origine.y; 
			if (_scrollDir == VERTICAL)
			{
				this.x = _target.x + _target.width + _decal;
				this.y = _target.y;
			}
			else if (_scrollDir == HORIZONTAL)
			{
				this.x = _target.x; 
				this.y = _target.y+_target.height+_decal;
			}

			_trackSpr = new Sprite();
			_thumbSpr = new Sprite();
			_trackSubSpr = new Sprite();
			_thumbSubSpr = new Sprite();

			addChild(_trackSpr);
			addChild(_thumbSpr);
			_thumbSpr.buttonMode = true;
			
			// *****************************************        初始化绘制        *********************
			var tempBmp:Bitmap;
			var tempSpr:Sprite;
			var parentType:String;
			var tempObj:*;
			// track
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.SCROLLBAR_TRACK])
				{
					tempObj = _skinObj[SkinStyle.SCROLLBAR_TRACK];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.SCROLLBAR_TRACK];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.SCROLLBAR_TRACK];
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
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StScrollBar, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}	
			}
			
			// _thumbSpr
			if (_skinObj)
			{
				if (_skinObj[SkinStyle.SCROLLBAR_THUMB])
				{
					tempObj = _skinObj[SkinStyle.SCROLLBAR_THUMB];
				}else
				{
					tempObj = SkinStyle.Skin.SkinObj[SkinStyle.SCROLLBAR_THUMB];
				}
			}else
			{
				tempObj = SkinStyle.Skin.SkinObj[SkinStyle.SCROLLBAR_THUMB];
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
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StScrollBar, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
			}
			// -----------------------------------------        初始化绘制        ---------------------------
			
			/************************************************************************************************
			 * 设置mask
			 */
			_scrollMask = new Sprite();
			this.addChild(_scrollMask);
			_maskShape = new Shape();
			_scrollMask.addChild(_maskShape);
			/************************************************************************************************
			 * 设置mask
			 ************************************************************************************************/

			draw();
			_target.addEventListener(StUiEvent.STSCROLLBAR_CHANGE_POSITION, changePostionHandler,false,0,true);
			_thumbSpr.addEventListener(MouseEvent.MOUSE_DOWN, startDragThumb,false,0,true);
			_trackSpr.addEventListener(MouseEvent.CLICK, clickTrackHandler,false,0,true);
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler,false,0,true);
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			setupDirLocation();
			setTargetMask();
			_thumbSpr.visible = checkTargetHedight();
			moveTargetVerticaly(_thumbSpr.y);
			if (_stageScroll)
			{
				stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			}else
			{
				this.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
				_target.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			}
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
			if (styleObj)
			{
				var tempBmp:Bitmap;
				var tempSpr:Sprite;
				var parentType:String;

				parentType = getQualifiedSuperclassName(styleObj);
				if (parentType.indexOf("BitmapAsset") !=-1)
				{
					tempBmp = styleObj as Bitmap;
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(tempBmp.bitmapData.clone()));
					_styleMap[styleName] = tempSpr;
				}else if (parentType.indexOf("BitmapData") !=-1)
				{
					tempSpr = new Sprite();
					tempSpr.addChild(new Bitmap(BitmapData(styleObj).clone()));
					_styleMap[styleName] = tempSpr;
				}else if (parentType.indexOf("SpriteAsset") !=-1)
				{
					_styleMap[styleName] = SkinStyle.duplicateDisplayObject(Sprite(styleObj)) as Sprite;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StScrollBar, "参数应该为图类型,应继承自[BitmapAsset,BitmapData,SpriteAsset]");
				}
				redraw();
			}
		}
		
		override public function getStyle(styleName:String):Object 
		{
			return _styleMap[styleName];
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
			_thumbSpr.visible = checkTargetHedight();
			//setTargetMask();
		}
		
		/**
		 * 设置滚动条的方向
		*/
		private function setupDirLocation():void 
		{
			if (_scrollDir == VERTICAL)
			{
				_trackSpr.x = -_trackSpr.width * 0.5 + _decal;
				_trackSpr.y = 0;
				if (_trackSpr.height >0) _trackHeight = _trackSpr.height;
				_thumbSpr.x = -_thumbSpr.width * 0.5+_decal;
				_thumbSpr.y =0;
			}
			else if (_scrollDir == HORIZONTAL)
			{
				_trackSpr.x = 0;
				_trackSpr.y = _trackSpr.width*0.5+_decal;
				_trackHeight = _trackSpr.height;
				_trackSpr.rotation = 270;

				_thumbSpr.x = 0;
				_thumbSpr.rotation = 270;
				_thumbSpr.y = _trackSpr.y+_trackSpr.height*0.5-_thumbSpr.height*0.5;
				
			}
		}

		/**
		 * 鼠标滚动
		 * @param	evt
		 */
		private function mouseWheelHandler(evt:MouseEvent):void
		{
			if (_thumbSpr.visible)
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
		}
		
		/**
		 * 点击滚动条
		 * @param	evt
		 */
		private function clickTrackHandler(evt:MouseEvent):void
		{
			if (checkTargetHedight())
			{
				var trackClicPos:Number;
				if (_scrollDir == VERTICAL)
				{
					trackClicPos = evt.stageY-this.y-this.parent.y-_stageDecalY;
				}
				else if (_scrollDir == HORIZONTAL)
				{
					trackClicPos = evt.stageX-this.x-this.parent.x-_stageDecalX;
				}
				moveThumb(trackClicPos);
			}
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
				thumbNewPos = evt.stageY -tp.y-_stageDecalY-_offNum;
			}
			else if (_scrollDir == HORIZONTAL)
			{
				thumbNewPos = evt.stageX - tp.x - _stageDecalX - _offNum;
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
			_posPercent = (100*thumbX)/(_trackHeight-_thumbSpr.width-1);
			_newPosTarget = (_target.width - _trackHeight) * _posPercent * 0.01;
			_target.x = this.x - _newPosTarget;
		}
		
		private function moveTargetVerticaly(thumbY:Number):void
		{
			_posPercent = (100 * thumbY) / (_trackHeight - _thumbSpr.height - 1);
			if (_haveVisibleModeHeigth == -1)
			{
				_newPosTarget = (_target.height - _trackHeight) * _posPercent * 0.01;
			}else
			{
				_newPosTarget = (_haveVisibleModeHeigth - _trackHeight) * _posPercent * 0.01;
			}
			_target.y = this.y - _newPosTarget; 
		}
		
		private function stopDragThumb(evt:MouseEvent):void
		{
			_thumbSpr.addEventListener(MouseEvent.MOUSE_DOWN, startDragThumb);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragThumb);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		/**
		 * 设置遮罩逻辑
		 */
		private function setTargetMask():void
		{
			var t1:Point = _target.localToGlobal(new Point(0,0));  // 转换目标的全局坐标
			var t2:Point = this.globalToLocal(t1);				   // 转换目标的全局坐标为局部坐标
			_maskShape.graphics.clear();
			_maskShape.graphics.beginFill(0xcccccc);
			if (_scrollDir == VERTICAL)
			{
				_maskShape.graphics.drawRect(t2.x-5,t2.y, _target.width+5, _trackHeight);
			}
			else if (_scrollDir == HORIZONTAL)
			{
				_maskShape.graphics.drawRect(t2.x-5,t2.y, _trackHeight+5, _target.height);
			}
			_target.mask = _scrollMask;
		}
		
		private function targetChangeSizeHandler(e:StUiEvent):void
		{
			//setTargetMask();
			moveTargetVerticaly(_thumbSpr.y);
			_thumbSpr.visible = checkTargetHedight();
		}
		
		/**
		 * 有隐藏子对象时，重新获取隐藏模式高度值
		 */
		public function set HaveVisibleModeNum(num:Number):void
		{
			_haveVisibleModeHeigth = num;
		}
		
		private function checkTargetHedight():Boolean
		{
			var b:Boolean = true;
			if (_exceedHeightNoShow)
			{
				//trace("_trackHeight:",_target.height,_trackHeight);
				if (_haveVisibleModeHeigth < _trackHeight)
				{
					b = false;
					moveThumb(0);
				}else
				{
					b = true;
				}
				
			}
			return b;
		}
		
		/**
		 * 高度不到滚动条高度，不显示滑动按钮
		 */
		public function set UnExceedHeightNoShow(b:Boolean):void
		{
			_exceedHeightNoShow =b;
		}
		public function get UnExceedHeightNoShow():Boolean
		{
			return _exceedHeightNoShow;
		}
		
		private function changePostionHandler(e:Event):void
		{
			var npy:Number = _target.y - this.y;
			var ty:Number = (npy/0.01/(_target.height - _trackHeight)) * (_trackHeight - _thumbSpr.height - 1) / 100;
			_thumbSpr.y = -ty;
			if (_thumbSpr.y < 0) _thumbSpr.y = 0;
		}
		
		public function get GetTarget():Sprite
		{
			return _target;
		}
		
		public function setScrollBarInit():void
		{
			moveTargetVerticaly(0);
		}
		
		override public function destroy():void 
		{ 
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragThumb);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			
			_thumbSpr.removeEventListener(MouseEvent.MOUSE_DOWN, startDragThumb);
			_trackSpr.removeEventListener(MouseEvent.CLICK, clickTrackHandler);
			this.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			_target.removeEventListener(StUiEvent.STSCROLLBAR_CHANGE_POSITION, changePostionHandler);
			_target.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);

			
			_styleMap = null ;
			_skinObj = null ;
			
			/*GC.killMySelf(_trackSubSpr);  seetinks
			GC.killMySelf(_thumbSubSpr);
			GC.killMySelf(_target);
			GC.killMySelf(_trackSpr);
			GC.killMySelf(_thumbSpr);
			GC.killMySelf(_scrollMask);*/
			
			/*if (_trackSubSpr && _trackSubSpr.parent) _trackSubSpr.parent.removeChild(_trackSubSpr);
			if (_thumbSubSpr && _thumbSubSpr.parent) _thumbSubSpr.parent.removeChild(_thumbSubSpr);
			if (_target && _target.parent) _target.parent.removeChild(_target);
			if (_trackSpr && _trackSpr.parent) _trackSpr.parent.removeChild(_trackSpr);
			if (_thumbSpr && _thumbSpr.parent) _thumbSpr.parent.removeChild(_thumbSpr);
			if (_scrollMask && _scrollMask.parent) _scrollMask.parent.removeChild(_scrollMask);
			
			if (_maskShape && _maskShape.parent) _maskShape.parent.removeChild(_maskShape);
			
			_trackSubSpr = null;
			_thumbSubSpr = null;
			_target = null;
			_trackSpr = null;
			_thumbSpr = null;
			_scrollMask = null ;
			_maskShape = null ;
			
			//GC.killMySelf(this);
			delete this;
			GC.Gc();*/
		}
	}

}
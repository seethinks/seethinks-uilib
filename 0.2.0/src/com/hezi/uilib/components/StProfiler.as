package com.hezi.uilib.components 
{
	import com.hezi.uilib.Error.UiLibError;
	import com.hezi.uilib.skin.SkinStyle;
	import com.hezi.uilib.util.GC;
	
	import flash.utils.getQualifiedSuperclassName;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * 运行时详细信息,fps,内存占用组件
	 * @author seethinks@gmail.com
	 */
	public class StProfiler extends AbstractComponentBase 
	{
		private var _lastFrameTime:Number;
		private var _fps:Number;
		private var _ram:Number;
		private var _ramMax:Number;
		
		private var _memPoints:Array;
		private var _memGraph:Shape;
		private var _memUpdates:int;
		
		private var _timer:Timer;
		
		private var _backGround:StPanel; 
		private var _fpsTxt:TextField;
		private var _ramTxt:TextField;
		private var _tf:TextFormat;

		private var _lineColor:Number;
		private var _textColor:Number;
		private var _styleMap:Object;
		
		/**
		 * 
		 * @param	x x坐标
		 * @param	y y坐标
		 * @param	alpha	透明度
		 * @param	enabled	是否激活
		 * @param	draged	是否能够拖动
		 * @param	dragedInStage 是否在舞台内拖动
		 */
		public function StProfiler(x:Number=0,y:Number=0,alpha:Number=1,enabled:Boolean=true,draged:Boolean=false,dragedInStage:Boolean=false) 
		{
			_fps = 0;
			_ram = 0;
			_ramMax = 0;
			_memPoints = new Array();
			_memUpdates = 0;
			this._dragedInStage = dragedInStage;
			this._lineColor = 0xffffff;
			this._textColor = 0xffffff;
			this._enabled = enabled;
			this._draged = draged;
			setLocation(x, y);
			init();
		}
		
		/**
		 * 初始化
		 */
		override public function init():void 
		{
			_styleMap = new Object();
			_backGround = new StPanel();
			_backGround.setSize(100, 50);
			addChild(_backGround);
			initCast();
			draw();
			initTime();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler,false,0,true);
		}
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			destroy();
		}
		
		/**
		 * 初始化各种显示对象
		 */
		private function initCast():void 
		{			
			this._width = _backGround.width;
			this._height = _backGround.height;
			setSize(this._width, this._height);
			
			_tf = new TextFormat('_sans', 9,null, false);
			_tf.color = _textColor;
			_fpsTxt = new TextField();
			_fpsTxt.defaultTextFormat = _tf;
			_fpsTxt.autoSize = TextFieldAutoSize.LEFT; 
			_fpsTxt.text = '帧频:';
			_fpsTxt.x = 2;
			_fpsTxt.y = 2;
			_fpsTxt.selectable = false;
			this.addChild(_fpsTxt);
			
			_ramTxt = new TextField();
			_ramTxt.defaultTextFormat = _tf;
			_ramTxt.autoSize = TextFieldAutoSize.LEFT; 
			_ramTxt.text = '内存:';
			_ramTxt.x = 2;
			_ramTxt.y = _fpsTxt.height;
			_ramTxt.selectable = false;
			this.addChild(_ramTxt);

			_memGraph = new Shape();
			_memGraph.x = 2;
			_memGraph.y = _height;
			this.addChild(_memGraph);
			
			var i:int = 0;
			for (i=0; i<this._width/5; i++) {
				_memPoints[i]=0;
			}
			
			this.scrollRect = new Rectangle(0, 0, this._width, this._height);
			if (this._draged)
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler,false,0,true);
			}
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			if (!this._dragedInStage)
			{
				this.startDrag();
			}else
			{
				this.startDrag(false,new Rectangle(0,0,stage.stageWidth-this._width,stage.stageHeight-this._height));
			}
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler,false,0,true);
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			this.stopDrag();
		}
		
		/**
		 * 初始化计时
		 */
		private function initTime():void 
		{
			_timer = new Timer(200);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler, false, 0, true);
		}
		
		private function timerHandler(e:TimerEvent):void 
		{
			_ram = System.totalMemory;
			if (_ram > _ramMax)
			{
				_ramMax = _ram;
			}
			if (_memUpdates % 5 == 0) {
				_memPoints.unshift(_ram/1024);
				_memPoints.pop();
			}
			updateDataDraw();
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			_timer.start();
			addEventListener(Event.ENTER_FRAME, enterFrameHandler,false,0,true);
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			var time : Number = getTimer() - _lastFrameTime;
			_fps = Math.floor(1000/time);			
			_lastFrameTime = getTimer();
		}
		
		/**
		 * 格式化内存显示
		 * @param	ram  内存值
		 * @return
		 */
		private function formatRam(ram : Number) : String
		{
			var ram_unit : String = 'B';
			if (ram > 1048576) {
				ram /= 1048576;
				ram_unit = 'M'; 
			}
			else if (ram > 1024) {
				ram /= 1024;
				ram_unit = 'K'; 
			}
			return ram.toFixed(2) + ram_unit;
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
		
		/**
		 * 根据数据重绘
		 */
		private function updateDataDraw():void 
		{
			_fpsTxt.text = '帧频:' + _fps.toString().concat('/', stage.frameRate);
			_ramTxt.text = '内存:' + formatRam(_ram).concat(' / ', formatRam(_ramMax));

			if (_memUpdates % 5 == 0) {
					var i : int;
					var max_val : Number = 0;
					_memGraph.scaleY = 1;
					var g : Graphics;				
					g = _memGraph.graphics;
					g.clear();
					g.lineStyle(1, _lineColor, 1, true, LineScaleMode.NONE);
					g.moveTo(5 * (_memPoints.length - 1), -_memPoints[_memPoints.length - 1]);
					for (i=_memPoints.length-1; i>=0; --i) {
						if (_memPoints[i+1]==0 ||_memPoints[i]==0) {
							g.moveTo(i*5, -_memPoints[i]);
							continue;
						}
						g.lineTo(i*5, -_memPoints[i]);
						
						if (_memPoints[i] > max_val)
							max_val = _memPoints[i];
					}
					
					var _h:Number =  _height / 3;
					_memGraph.scaleY = _h / max_val ;
			}
			_memGraph.x = _memUpdates % 5;
			_memUpdates++;
		}
		
		override public function draw():void 
		{
			_tf.color = _textColor;
			_fpsTxt.defaultTextFormat = _tf;
			_ramTxt.defaultTextFormat = _tf;
		}
		
		/**
		 * 返回fps信息
		 */
		public function get FpsInfo():Number
		{
			return _fps;
		}
		
		/**
		 * 返回内存使用信息
		 */
		public function get RamInfo():Number
		{
			return _ram;
		}
					
		override public function setStyle(styleName:String = "", styleObj:Object = null):void 
		{
			if (styleName == SkinStyle.PROFILER_LINECOLOR)
			{
				if (typeof(styleObj) == "number")
				{
					_lineColor = styleObj as Number;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StProfiler, "参数应该为Number类型");
				}
				_styleMap[styleName] = styleObj;
			}
			if (styleName == SkinStyle.PROFILER_TEXTCOLOR)
			{
				if (typeof(styleObj) == "number")
				{
					_textColor = styleObj as Number;
				}else
				{
					throw new UiLibError(UiLibError.VALUE_TYPEERROR_MSG, StProfiler, "参数应该为Number类型");
				}
				_styleMap[styleName] = styleObj;
			}
			redraw();
		}
		
		override public function getStyle(styleName:String):Object 
		{
			return _styleMap[styleName];
		}
		
		override public function destroy():void 
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			if (this._draged)
			{
				this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			if (_timer)
			{
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
				_timer = null;
			}	
			if (_backGround && _backGround.parent) _backGround.parent.removeChild(_backGround);
			if (_memGraph && _memGraph.parent) _memGraph.parent.removeChild(_memGraph);
			_fpsTxt = null;
			_ramTxt = null;
			_tf = null;
			_memGraph = null;
			_memPoints = null;
			_styleMap = null;
			GC.killMySelf(this);
			delete this;
			GC.Gc();
		}
	}

}
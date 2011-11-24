package com.hezi.uilib.components 
{
	import com.hezi.uilib.core.IbComponent;
	import com.hezi.uilib.Error.UiLibError;
	
	import flash.events.Event;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import flash.errors.IllegalOperationError;
	import flash.display.Sprite;

	/**
	* 组件的抽象基类，对于组件的基本绘制，渲染做出抽象定义，所有组件必须继承此基类
	* @author seethinks@gmail.com
	*/
	public class AbstractComponentBase extends Sprite implements IbComponent 
	{
	    protected var _styleObj:Object;
		protected var _width:Number;
		protected var _height:Number;
		protected var _enabled:Boolean;
		protected var _draged:Boolean;
		protected var _dragedInStage:Boolean;
		protected var _styleName:String;
		
		public function AbstractComponentBase() 
		{
			if (Object(this).constructor == AbstractComponentBase)
			{
				throw new UiLibError(UiLibError.ABSTRACTCLASS_UNINSTANCE_MSG,AbstractComponentBase);
			}
			
			var unimplemented:Array = [destroy,draw,init,setLocation,setSize,setStyle,getStyle];   // 抽象方法数组
			var abstractTypeName:String = getQualifiedClassName(AbstractComponentBase); 
			var selfDescription:XML = describeType(this); 
			var methods:XMLList = selfDescription.method.(@declaredBy == abstractTypeName && unimplemented.indexOf(this[@name])>= 0); 
			if(methods.length()> 0) 
			{ 
				throw new UiLibError(UiLibError.UNEXTEND_ABSTRACTFUNCTION_MSG,AbstractComponentBase,"["+methods[0].@name+"]");  
			} 
			
			_styleObj = new Object();
			_width = 0;
			_height = 0;
			_enabled = true;
			_draged = false;
			_dragedInStage = false;
		}
		
		/**
		 * 抽象方法，初始化
		 */
		public function init():void
		{
			
		}
		
		/**
		 * 抽象方法，销毁操作
		 */
		public function destroy():void
		{

		}
		
		/**
		 * 抽象方法，设置组件位置
		 */
		public function setLocation(x:Number,y:Number):void
		{
			
		}
		
		/**
		 * 抽象方法，设置组件大小
		 */
		public function setSize(w:Number,h:Number):void
		{
			
		}
		
		/**
		 * 设置皮肤风格
		 * @param	styleName
		 * @param	styleObj
		 */
		public function setStyle(styleName:String = "", styleObj:Object = null ):void
		{
			_styleObj[styleName] = styleObj;
		}
		
		/**
		 * 返回皮肤风格
		 * @param	styleName
		 * @return
		 */
		public function getStyle(styleName:String):Object
		{
			return _styleObj[styleName];
		}
		
		/**
		 * 设置宽度
		 */
		/*override public function set width(w:Number):void
		{
			_width = w;
			redraw();
		}*/
		
		/**
		 * 返回宽度
		 */
		/*override public function get width():Number
		{
			return _width;
		}*/
		
		/**
		 * 设置高度
		 */
		/*override public function set height(h:Number):void
		{
			_height = h;
			redraw();
		}*/
		
		/**
		 * 返回高度
		 */
		/*override public function get height():Number
		{
			return _height;
		}*/
		
		/**
		 * 设置是否激活组件
		 */
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			mouseEnabled = _enabled;
			mouseChildren = _enabled;
			tabEnabled = _enabled;
		}
		
		/**
		 * 返回是否激活
		 */
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		/**
		 * 设置是否能够拖动组件
		 */
		public function set draged(value:Boolean):void
		{
			_draged = value;
		}
		
		/**
		 * 返回是否能被拖动
		 */
		public function get draged():Boolean
		{
			return _draged;
		}
		
		/**
		 * 进行下一帧渲染时重绘
		 */
		protected function redraw():void
		{
			addEventListener(Event.ENTER_FRAME, onRedraw);
		}
		
		protected function onRedraw(e:Event):void 
		{
			removeEventListener(Event.ENTER_FRAME, onRedraw);
			draw();
		}
		
		/**
		 * 抽象方法，绘制组件
		 */
		public function draw():void
		{
			
		}
	}

}
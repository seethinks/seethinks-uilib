package com.hezi.uilib.components 
{
	/**
	 * 模板组件
	 * @author seethinks@gmail.com
	 */
	public class StComponentTemplet extends AbstractComponentBase 
	{
		
		public function StComponentTemplet(x:Number = 0, y:Number = 0) 
		{
			setLocation(x, y);
			init();
		}
		override public function init():void 
		{
			
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

		}
	}

}
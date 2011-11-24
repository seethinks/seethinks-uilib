package com.hezi.uilib.core 
{
	/**
	 * 组件接口
	 * @author seethinks@gmail.com
	 */
	public interface IbComponent 
	{
		/**
		 * 销毁函数，所有事件监听，内存释放统一在此函数内销毁
		 */
		function destroy():void;
		
		/**
		 * 组件初始化
		 */
		function init():void;
		
		/**
		 * 绘制方法
		 */
		function draw():void;
		
		/**
		 * 组件位置设置
		 */
		function setLocation(x:Number,y:Number):void;
	}
	
}
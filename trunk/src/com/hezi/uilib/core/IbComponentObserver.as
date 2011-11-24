package com.hezi.uilib.core 
{
	
	/**
	 * 组件观察者接口
	 * @author seethinks@gmail.com
	 */
	public interface IbComponentObserver 
	{
		/**
		 * 完整数据更新
		 * @param	obj
		 */
		function updateDataDraw(obj:IbListDataModel = null):void;
	}
	
}
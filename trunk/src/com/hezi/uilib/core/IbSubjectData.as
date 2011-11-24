package com.hezi.uilib.core 
{
	
	/**
	 * 数据主题接口
	 * @author seethinks@gmail.com
	 */
	public interface IbSubjectData 
	{
		function addObserver(observer:IbComponentObserver):void;
		function removeObserver(observer:IbComponentObserver):void;
		function notify():void;
	}
	
}
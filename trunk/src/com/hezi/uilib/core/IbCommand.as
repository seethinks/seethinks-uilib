package com.hezi.uilib.core 
{
	/**
	 * 命令接口
	 * @author seethinks@gmail.com
	 */
	public interface IbCommand 
	{
		/**
		 * 命令执行方法
		 * @param	...arg 不定参数
		 */
		function execute(...arg):void;
	}
	
}
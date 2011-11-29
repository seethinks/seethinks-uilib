package com.hezi.uilib.util 
{
	/**
	 * 单位转换工具类
	 * @author seethinks@gmail.com
	 */
	public class UnitConversion 
	{
		public static function GetFileSize(n:Number):String
		{
			return ((n > 1024 * 1024)?Math.round(n * 10 / (1024*1024))/10 + "MB":Math.round(n * 10 / 1024)/10 + "KB");
		}
	}

}
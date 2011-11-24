package com.hezi.uilib.model 
{
	import com.hezi.uilib.core.IbListDataModel;
	
	/**
	 * 定义数据规范
	 * @author seethinks@gmail.com
	 */
	public class ListDataModel extends Object implements IbListDataModel
	{
		/**
		 * 列表数据
		 */
		private var _listDataArr:Array;  
		
		public function ListDataModel() 
		{
			_listDataArr = new Array();
		}
		
		public function set ListDataArr(arr:Array):void
		{
			_listDataArr = arr;
		}
		/**
		 * 填充列表数据
		 */
		public function get ListDataArr():Array
		{
			return _listDataArr;
		}
		
	}

}
package com.hezi.uilib.util 
{
	/**
	 * 获得翻页索引
	 * @author seethinks@gmail.com
	 */
	public class ChangePage 
	{
		public static function showRight(_showCurrentList:Array,_showTotal:int,_currentPage:int):Array   //// 物品的数组,当前页面的总数,当前页索引  
	    {
	    	var i:int=0;
            var _totalPages:int=0;
			var _totalJJ:int=0;
		    _totalJJ=_showCurrentList.length;
		    _totalPages=Math.ceil(_totalJJ/_showTotal);

            var tempNum:int=_currentPage*_showTotal-_showTotal;
		    var tempNumMAX:int=_currentPage*_showTotal;
		    var tempInt:int=0;

		    if (_currentPage==_totalPages)
		    {
		    	tempNumMAX=_showCurrentList.length;
		    }
            var resultList:Array=[];
			for(i=tempNum;i<tempNumMAX;i++)
			{
				if (_showCurrentList[i])
				{
					tempInt++;
					resultList.push(i);
				}
			}
			return resultList;
		}
	}

}
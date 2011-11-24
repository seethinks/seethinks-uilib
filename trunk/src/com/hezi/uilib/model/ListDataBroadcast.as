package com.hezi.uilib.model 
{
	import com.hezi.uilib.core.IbComponentObserver;
	import com.hezi.uilib.core.IbListDataModel;
	import com.hezi.uilib.core.IbSubjectData;
	
	/**
	 * List数据广播主题类
	 * @author seethinks@gmail.com
	 */
	public class ListDataBroadcast implements IbSubjectData 
	{
			private var _componetList:Array;
			private var _dataList:IbListDataModel;

			public function ListDataBroadcast()
			{
				_componetList = new Array();
			}
			
			/**
			 * 注册组件观察者进入列表
			 * @param	componentObserver
			 */
			public function addObserver(componentObserver:IbComponentObserver):void
			{
				if (_componetList.indexOf(componentObserver) < 0)
				{
					_componetList.push(componentObserver);
				}
			}
			
			/**
			 * 从列表删除组件观察者
			 * @param	componentObserver
			 */
			public function removeObserver(componentObserver:IbComponentObserver):void
			{
				var i:int = 0;
				var l:int = _componetList.length;
				for (i = 0; i < l; i++)
				{
					if (_componetList[i] == componentObserver)
					{
						_componetList.splice(i, 1);
						break;
					}
				}
			}
			
			/**
			 * 通知所有组件根据数据改变状态绘制
			 */
			public function notify():void
			{
				var i:int = 0;
				var l:int = _componetList.length;
				for (i = 0; i < l; i++)
				{
					if (_componetList[i]) _componetList[i].updateDataDraw(_dataList);
				}
			}
			
			/**
			 * 设置同步数据
			 * @param	data
			 */
			public function setDataList(data:IbListDataModel):void
			{
				_dataList = data;
				notify();
			}	
			
			/**
			 * 返回观察对象数量
			 * @return 
			 */
			public function getObserverNum():int
			{
				return _componetList.length;
			}
	}

}
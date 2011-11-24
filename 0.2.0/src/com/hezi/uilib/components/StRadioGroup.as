package com.hezi.uilib.components 
{
	import com.hezi.uilib.event.StUiEvent;
	import flash.events.EventDispatcher;
	
	[Event (name = "STRADIOGROUP_RADIO_SELECTEDINDEX", type = "com.hezi.uilib.event.StUiEvent")]
	/**
	 * radio组件群组
	 * @author seethinks@gmail.com
	 */
	public class StRadioGroup extends EventDispatcher
	{
		private var _radioList:Vector.<StRadio>;
		private var _curRadio:StRadio;
		
		public function StRadioGroup() 
		{
			_radioList = new Vector.<StRadio>;
			_curRadio = null;
		}
		
		/**
		 * 返回radio群组
		 * @param	...radio
		 * @return
		 */
		public static function groupRadios(...radios):StRadioGroup{
			var g:StRadioGroup = new StRadioGroup();
			for each(var i:AbstractComponentBase in radios)
			{
				g.appendRadio(i);
			}
			return g;
		}
		
		/**
		 * 添加radio进群组
		 * @param	r
		 */
		public function appendRadio(r:AbstractComponentBase):void {
			if(r == null) {
				return;
			}
			r.addEventListener(StUiEvent.STRADIO_CHANGESTATUS, setSelectedHandler);
			_radioList.push(r);
		}
		
		/**
		 * 监听raido选择事件
		 * @param	e
		 */
		private function setSelectedHandler(e:StUiEvent):void 
		{
			for (var i:int = 0; i < _radioList.length;i++ )
			{
				_radioList[i].setStatus(StRadio.RADIO_STATUS_DEFAULT);
			}
			_curRadio = e.currentTarget as StRadio;
			_curRadio.setStatus(StRadio.RADIO_STATUS_SELECTED);
			var sue:StUiEvent = new StUiEvent(StUiEvent.STRADIOGROUP_RADIO_SELECTEDINDEX);
			sue.StRadioGroupSelectIndex = _radioList.indexOf(_curRadio);
			this.dispatchEvent(sue);
		}
		
		/**
		 * 删除radio
		 * @param	r
		 */
		public function removeRadio(r:AbstractComponentBase):void {
			var index:int = _radioList.indexOf(r);
			if (index!=-1)
			{
				_radioList.splice(index, 1);
			}
		}
		
		/**
		 * 返回radio数量
		 * @return
		 */
		public function RadioNum():int
		{
			return _radioList.length;
		}
		
		public function getCurSelectedIndex():int
		{
			var index:int = -1;
			for (var i:int = 0; i < _radioList.length;i++ )
			{
				if (_radioList[i].getStatus()) 
				{
					index = i;
					return index;
				}
			}
			return index;
		}
		
		/**
		 * 释放
		 */
		public function destory():void
		{
			for (var i:int = 0; i < _radioList.length;i++ )
			{
				_radioList[i].removeEventListener(StUiEvent.STRADIO_CHANGESTATUS, setSelectedHandler);
			}
			_radioList.length = 0;
			_radioList = null;
			if (_curRadio) _curRadio = null;
		}
	}

}
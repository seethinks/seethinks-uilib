package com.hezi.uilib.event 
{
	import flash.events.Event;
	
	/**
	 * ui事件类
	 * @author seethinks@gmail.com
	 */
	public class StUiEvent extends Event 
	{
		
		public static const CHANGE_SIZE:String = "CHANGE_SIZE";
		
		public static const STLIST_CLICK_CELL:String = "STLIST_CLICK_CELL";
		private var _stListCellValue:Object;
		private var _stListCellLabel:String;
		
		public static const STCOMBOBOX_CLICK_CELL:String = "STCOMBOBOX_CLICK_CELL";
		private var _stComboBoxCurObj:Object;
		
		public static const STSLIDER_CHANGE_VALUE:String = "STSLIDER_CHANGE_VALUE";
		private var _curNum:Number;
		
		public static const STSCROLLBAR_CHANGE_POSITION:String = "STSCROLLBAR_CHANGE_POSITION";
		
		public static const STCHECK_CHANGESTATUS:String = "STCHECK_CHANGESTATUS";
		private var _checkBoxStatus:Boolean;
		
		public static const STRADIO_CHANGESTATUS:String = "STRADIO_CHANGESTATUS";
		private var _radioStatus:Boolean;
		
		public static const STRADIOGROUP_RADIO_SELECTEDINDEX:String = "STRADIOGROUP_RADIO_SELECTEDINDEX";
		private var _curRadioSelectIndex:int;
		
		/**
		 * Create a StUiEvent.
		 */
		public function StUiEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new StUiEvent(type, bubbles, cancelable);
		}
		
		/**
		 * list组件cell标签数据
		 */
		public function set StListCellLabel(str:String):void
		{
			_stListCellLabel = str;
		}
		public function get StListCellLabel():String
		{
			return _stListCellLabel;
		}
		
		/**
		 * List组件cellvalue数据
		 */
		public function set StListCellValue(obj:Object):void
		{
			_stListCellValue = obj;
		}
		public function get StListCellValue():Object
		{
			return _stListCellValue;
		}
		
		/**
		 * ComboBox组件当前object数据
		 */
		public function set StComboBoxCurObj(obj:Object):void
		{
			_stComboBoxCurObj = obj;
		}
		public function get StComboBoxCurObj():Object
		{
			return _stComboBoxCurObj;
		}
		
		/**
		 * Slider组件value
		 */
		public function set StSliderValue(num:Number):void
		{
			_curNum = num;
		}
		public function get StSliderValue():Number
		{
			return _curNum;
		}
		
		/**
		 * CheckBox组件状态
		 */
		public function set StCheckBoxStatus(b:Boolean):void
		{
			_checkBoxStatus = b;
		}
		public function get StCheckBoxStatus():Boolean
		{
			return _checkBoxStatus;
		}
		
		/**
		 * Radio组件状态
		 */
		public function set StRadioStatus(b:Boolean):void
		{
			_radioStatus = b;
		}
		public function get StRadioStatus():Boolean
		{
			return _radioStatus;
		}
		
		/**
		 * RadioGroup radio选中索引
		 */
		public function set StRadioGroupSelectIndex(i:int):void
		{
			_curRadioSelectIndex = i;
		}
		public function get StRadioGroupSelectIndex():int
		{
			return _curRadioSelectIndex;
		}
		
	}

}
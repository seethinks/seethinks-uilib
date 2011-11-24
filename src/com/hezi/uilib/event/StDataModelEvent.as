package com.hezi.uilib.event 
{
	import flash.events.Event;
	
	/**
	 * dataModel事件类
	 * @author seethinks@gmail.com
	 */
	public class StDataModelEvent extends Event 
	{
		
		public function StDataModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new StDataModelEvent(type, bubbles, cancelable);
		}
	}

}
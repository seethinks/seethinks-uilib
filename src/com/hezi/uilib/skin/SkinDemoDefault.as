package com.hezi.uilib.skin 
{
	/**
	 * 默认没有外在素材测试类
	 * @author seethinks@gmail.com
	 */
	public class SkinDemoDefault extends SkinBase 
	{
		private var _bgColor:uint = 0x0dd1ff;
		
		public function SkinDemoDefault() 
		{
			SkinObj[SkinStyle.BUTTON_DEFAULT] = new ProtoTypeRect(88,31,_bgColor);
			SkinObj[SkinStyle.BUTTON_ROLLOVER] = new ProtoTypeRect(88, 31, 0xff3300);
			SkinObj[SkinStyle.BUTTON_PRESS] = new ProtoTypeRect(88, 31, 0xffffff);
			SkinObj[SkinStyle.BUTTON_DISABLE] = new ProtoTypeRect(88, 31, 0xcccccc);
			SkinObj[SkinStyle.BUTTON_LABEL] = "Test Button";
			
			SkinObj[SkinStyle.PANEL_DEFAULT] = new ProtoTypeRect(200, 200, _bgColor);
			SkinObj[SkinStyle.PANEL_DISABLE] = new ProtoTypeRect(200, 200, 0xcccccc);
			
			SkinObj[SkinStyle.PROFILER_LINECOLOR] = null;
			SkinObj[SkinStyle.PROFILER_TEXTCOLOR] = null;
			
			SkinObj[SkinStyle.SCROLLBAR_TRACK] = new ProtoTypeRect(5,80,_bgColor);
			SkinObj[SkinStyle.SCROLLBAR_THUMB] = new ProtoTypeRect(8, 8, _bgColor);
			
			SkinObj[SkinStyle.ACCORDION_TITLE_LIST] = [];
			
			SkinObj[SkinStyle.LIST_BG] = new ProtoTypeRect(150,100,_bgColor);
			SkinObj[SkinStyle.LIST_CELL_BG] =  new ProtoTypeRect(140,20,0xcccccc);
		}
		
	}

}
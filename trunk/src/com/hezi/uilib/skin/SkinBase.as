package com.hezi.uilib.skin 
{
	/**
	 * 皮肤基类
	 * @author seethinks@gmail.com
	 */
	public class SkinBase 
	{
		private var _skinObj:Object;
		
		public function SkinBase()
		{
			_skinObj = { };
			_skinObj[SkinStyle.BUTTON_DEFAULT] = null;
			_skinObj[SkinStyle.BUTTON_ROLLOVER] = null;
			_skinObj[SkinStyle.BUTTON_PRESS] = null;
			_skinObj[SkinStyle.BUTTON_DISABLE] = null;
			_skinObj[SkinStyle.BUTTON_LABEL] = null;
			
			_skinObj[SkinStyle.PANEL_DEFAULT] = null;
			
			_skinObj[SkinStyle.PROFILER_LINECOLOR] = null;
			
			_skinObj[SkinStyle.SCROLLBAR_TRACK] = null;
			_skinObj[SkinStyle.SCROLLBAR_THUMB] = null;
			
			_skinObj[SkinStyle.ACCORDION_TITLE_LIST] = [];
			
			_skinObj[SkinStyle.LIST_BG] = null;
			_skinObj[SkinStyle.LIST_CELL_BG] = null;
			
			_skinObj[SkinStyle.COMBOBOX_TITLE_BG] = null;
			_skinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_DEFAULT] = null;
			_skinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_CLICK] = null;
			
			_skinObj[SkinStyle.TEXTFIELD_Bg] = null;
			_skinObj[SkinStyle.TEXTFIELD_TEXT_TYPE] = null;
			_skinObj[SkinStyle.TEXTFIELD_TEXT_SIZE] = 14;
			_skinObj[SkinStyle.TEXTFIELD_TEXT_COLOR] = 0x000000;
			_skinObj[SkinStyle.TEXTFIELD_TEXT_ALIGN] = "center";
			_skinObj[SkinStyle.TEXTFIELD_TEXT_BOLD] = false;
			_skinObj[SkinStyle.TEXTFIELD_TEXT_HTML] = "text";
			_skinObj[SkinStyle.TEXTFIELD_TEXT_STYLESHEET] = "";
			
			_skinObj[SkinStyle.SLIDER_TRACK] = null;
			_skinObj[SkinStyle.SLIDER_THUMB] = null;
			
			_skinObj[SkinStyle.TOOLTIP_BG] = null;
			_skinObj[SkinStyle.TOOLTIP_TAIL] = null;
			
			_skinObj[SkinStyle.BUBBLEBOX_BG] = null;
			_skinObj[SkinStyle.BUBBLEBOX_TAIL] = null;
			
			_skinObj[SkinStyle.CHECKBOX_DEFAULT] = null;
			_skinObj[SkinStyle.CHECKBOX_SELECTED] = null;
			_skinObj[SkinStyle.CHECKBOX_DEFAULT_DISABLE] = null;
			_skinObj[SkinStyle.CHECKBOX_SELECTED_DISABLE] = null;
			
			_skinObj[SkinStyle.RADIO_DEFAULT] = null;
			_skinObj[SkinStyle.RADIO_SELECTED] = null;
			_skinObj[SkinStyle.RADIO_DEFAULT_DISABLE] = null;
			_skinObj[SkinStyle.RADIO_SELECTED_DISABLE] = null;
	}
		
		public function get SkinObj():Object
		{
			return _skinObj;
		}
	}
	
}
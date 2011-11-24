package com.hezi.uilib.skin 
{ // 马哈哈哈&mainUrl="devel.hezi.com"&googleUrl=
	import flash.display.Sprite;
	import flash.text.TextFieldType;
	
	/**
	 * 测试swf皮肤类
	 * @author seethinks@gmail.com
	 */
	public class SkinDemoSwf extends SkinBase 
	{
		[Embed(source = "../../../../../embed/asset.swf", symbol="ButtonDefault")] private var ButtonDefault:Class;
		[Embed(source = "../../../../../embed/asset.swf", symbol="ButtonOver")] private var ButtonOver:Class;
		[Embed(source = "../../../../../embed/asset.swf", symbol="ButtonPress")] private var ButtonPress:Class;
		[Embed(source = "../../../../../embed/asset.swf", symbol = "ButtonDisable")] private var ButtonDisable:Class;
		
		[Embed(source = "../../../../../embed/asset.swf", symbol = "PanelDefault")] private var PanelDefault:Class;
		
		[Embed(source = "../../../../../embed/asset.swf", symbol = "ScrollBarTrack")] private var ScrollBarTrack:Class;
		[Embed(source = "../../../../../embed/asset.swf", symbol = "ScrollBarThumb")] private var ScrollBarThumb:Class;
		
		[Embed(source = "../../../../../embed/TaskAsset.swf", symbol = "ListBg")] private var ListBg:Class;
		[Embed(source = "../../../../../embed/TaskAsset.swf", symbol = "McTitle1Class")] private var McTitle1Class:Class;
		
		[Embed(source = "../../../../../embed/ToolTipTail.png")] private var ToolTipTail:Class;
		
		public function SkinDemoSwf() 
		{
			SkinObj[SkinStyle.BUTTON_DEFAULT] = new ButtonDefault();
			SkinObj[SkinStyle.BUTTON_ROLLOVER] = new ButtonOver();
			SkinObj[SkinStyle.BUTTON_PRESS] = new ButtonPress();
			SkinObj[SkinStyle.BUTTON_DISABLE] = new ButtonDisable();
			SkinObj[SkinStyle.BUTTON_LABEL] = "Test Swf";
			
			SkinObj[SkinStyle.PANEL_DEFAULT] = new PanelDefault();
			SkinObj[SkinStyle.PANEL_DISABLE] = new PanelDefault();
			
			SkinObj[SkinStyle.PROFILER_LINECOLOR] = null;
			SkinObj[SkinStyle.PROFILER_TEXTCOLOR] = null;
			
			SkinObj[SkinStyle.SCROLLBAR_TRACK] = new ScrollBarTrack();
			SkinObj[SkinStyle.SCROLLBAR_THUMB] = new ScrollBarThumb();
			
			SkinObj[SkinStyle.ACCORDION_TITLE_LIST] = [];
			
			SkinObj[SkinStyle.LIST_BG] = new ListBg();
			SkinObj[SkinStyle.LIST_CELL_BG] =  new McTitle1Class();
			
			SkinObj[SkinStyle.COMBOBOX_TITLE_BG] = null;
			SkinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_DEFAULT] = null;
			SkinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_CLICK] = null;
			
			SkinObj[SkinStyle.TEXTFIELD_Bg] = null;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_TYPE] = TextFieldType.DYNAMIC;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_SIZE] = 14;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_COLOR] = 0x000000;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_ALIGN] = "center";
			SkinObj[SkinStyle.TEXTFIELD_TEXT_BOLD] = false;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_HTML] = "text";
			SkinObj[SkinStyle.TEXTFIELD_TEXT_STYLESHEET] = "";
			
			SkinObj[SkinStyle.SLIDER_TRACK] = null;
			SkinObj[SkinStyle.SLIDER_THUMB] = null;
			
			SkinObj[SkinStyle.TOOLTIP_BG] = null;
			SkinObj[SkinStyle.TOOLTIP_TAIL] = new ToolTipTail;
		}
		
	}

}
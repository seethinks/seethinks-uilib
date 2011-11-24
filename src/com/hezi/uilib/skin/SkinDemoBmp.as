package com.hezi.uilib.skin 
{	
	import flash.display.Bitmap;
	import flash.text.TextFieldType;

	/**
	 * 测试位图swf皮肤类
	 * @author seethinks@gmail.com
	 */
	public class SkinDemoBmp extends  SkinBase
	{
		[Embed(source = "../../../../../embed/ButtonDefault.png")] private var ButtonDefault:Class;
		[Embed(source = "../../../../../embed/ButtonOver.png")] private var ButtonOver:Class;
		[Embed(source = "../../../../../embed/ButtonPress.png")] private var ButtonPress:Class;
		[Embed(source = "../../../../../embed/ButtonDisable.png")] private var ButtonDisable:Class;
		
		[Embed(source = "../../../../../embed/PanelDefault.png")] private var PanelDefault:Class;
		
		[Embed(source = "../../../../../embed/ScrollBarTrack.png")] 
		private var ScrollBarTrack:Class;
		
		[Embed(source = "../../../../../embed/ScrollBarThumb.png")] private var ScrollBarThumb:Class;
		
		[Embed(source = "../../../../../embed/ListBg.png")] private var ListBg:Class;
		[Embed(source = "../../../../../embed/ListCellBg.png")] private var ListCellBg:Class;
																//scaleGridTop="6", scaleGridLeft="5", scaleGridRight="58", scaleGridBottom="16"	
		[Embed(source = "../../../../../embed/ToolTipBg.png", scaleGridTop = "6", scaleGridLeft = "5" , scaleGridRight = "38" ,scaleGridBottom = "17")] private var ToolTipBg:Class;
		[Embed(source = "../../../../../embed/ToolTipTail.png")] private var ToolTipTail:Class;
		
		public function SkinDemoBmp()
		{
			SkinObj[SkinStyle.BUTTON_DEFAULT] = new ButtonDefault();
			SkinObj[SkinStyle.BUTTON_ROLLOVER] = new ButtonOver();
			SkinObj[SkinStyle.BUTTON_PRESS] = new ButtonPress();
			SkinObj[SkinStyle.BUTTON_DISABLE] = new ButtonDisable();
			SkinObj[SkinStyle.BUTTON_LABEL] = "";
			
			SkinObj[SkinStyle.PANEL_DEFAULT] = new PanelDefault();
			SkinObj[SkinStyle.PANEL_DISABLE] = new PanelDefault();
			
			
			SkinObj[SkinStyle.PROFILER_LINECOLOR] = null;
			SkinObj[SkinStyle.PROFILER_TEXTCOLOR] = null;
			
			SkinObj[SkinStyle.SCROLLBAR_TRACK] = new ScrollBarTrack;
			SkinObj[SkinStyle.SCROLLBAR_THUMB] = new ScrollBarThumb;
			
			SkinObj[SkinStyle.ACCORDION_TITLE_LIST] = [];

			SkinObj[SkinStyle.LIST_BG] = new ListBg;
			SkinObj[SkinStyle.LIST_CELL_BG] =  new ListCellBg;
			
			SkinObj[SkinStyle.COMBOBOX_TITLE_BG] = null;
			SkinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_DEFAULT] = null;
			SkinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_CLICK] = null;
			
			SkinObj[SkinStyle.TEXTFIELD_Bg] = null;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_TYPE] = TextFieldType.DYNAMIC;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_SIZE] = 14;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_COLOR] = 0xFFFFFF;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_ALIGN] = "center";
			SkinObj[SkinStyle.TEXTFIELD_TEXT_BOLD] = false;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_HTML] = "text";
			SkinObj[SkinStyle.TEXTFIELD_TEXT_STYLESHEET] = "";
			
			SkinObj[SkinStyle.SLIDER_TRACK] = null;
			SkinObj[SkinStyle.SLIDER_THUMB] = null;
			
			SkinObj[SkinStyle.TOOLTIP_BG] = null;
			SkinObj[SkinStyle.TOOLTIP_TAIL] = new ToolTipTail;
			
			SkinObj[SkinStyle.BUBBLEBOX_BG] = null;
			SkinObj[SkinStyle.BUBBLEBOX_TAIL] = null;
		}
	}

}
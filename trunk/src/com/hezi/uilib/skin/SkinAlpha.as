package com.hezi.uilib.skin 
{ // 马哈哈哈&mainUrl="devel.hezi.com"&googleUrl=
	import flash.display.Sprite;
	import flash.text.TextFieldType;
	
	/**
	 * 测试swf皮肤类
	 * @author seethinks@gmail.com
	 */
	public class SkinAlpha extends SkinBase 
	{
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol="MoreThxLogo")] public static var MoreThxLogo:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ButtonDefault")] private var ButtonDefault:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ButtonOver")] private var ButtonOver:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ButtonPress")] private var ButtonPress:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ButtonDisable")] private var ButtonDisable:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "PanelDefault")] private var PanelDefault:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ScrollBarTrack")] private var ScrollBarTrack:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ScrollBarThumb")] private var ScrollBarThumb:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "SliderTrack")] private var SliderTrack:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "SliderThumb")] private var SliderThumb:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ListBg")] private var ListBg:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ListCellBg")] private var ListCellBg:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ComboBoxTitleBg")] private var ComboBoxTitleBg:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ComboBoxTitleButtonDefault")] private var ComboBoxTitleButtonDefault:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ComboBoxTitleButtonClick")] private var ComboBoxTitleButtonClick:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ComboBoxListBg")] public static var ComboBoxListBg:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ComboBoxListCellBg")] public static var ComboBoxListCellBg:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ComboBoxScrollBarTrack")] public static var ComboBoxScrollBarTrack:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ComboBoxScrollBarThumb")] public static var ComboBoxScrollBarThumb:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ToolTipBg")] private var ToolTipBg:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ToolTipTail")] private var ToolTipTail:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "BubbleBoxBg")] private var BubbleBoxBg:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "BubbleBoxTail")] private var BubbleBoxTail:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "CheckBoxDefault")] private var CheckBoxDefault:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "CheckBoxSelected")] private var CheckBoxSelected:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "CheckBoxDefaultDisable")] private var CheckBoxDefaultDisable:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "CheckBoxSelectedDisable")] private var CheckBoxSelectedDisable:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "RadioDefault")] private var RadioDefault:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "RadioSelected")] private var RadioSelected:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "RadioDefaultDisable")] private var RadioDefaultDisable:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "RadioSelectedDisable")] private var RadioSelectedDisable:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "TextFieldBg")] public static var TextFieldBg:Class;

		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ToggleButtonDefault")] private var ToggleButtonDefault:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ToggleButtonOver")] private var ToggleButtonOver:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ToggleButtonPress")] private var ToggleButtonPress:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ToggleButtonDisable")] private var ToggleButtonDisable:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ThumbnailBg")] private var ThumbnailBg:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ThumbnailPrevBtn")] public static var ThumbnailPrevBtn:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "ThumbnailNextBtn")] public static var ThumbnailNextBtn:Class;
		
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "TestBall")] public static var TestBall:Class;
		[Embed(source = "../../../../../embed/alpha_skin/alphaSkin.swf", symbol = "renyimen")] public static var body_mc:Class;
																				// renyimen
		
		public function SkinAlpha() 
		{
			SkinObj[SkinStyle.BUTTON_DEFAULT] = new ButtonDefault();
			SkinObj[SkinStyle.BUTTON_ROLLOVER] = new ButtonOver();
			SkinObj[SkinStyle.BUTTON_PRESS] = new ButtonPress();
			SkinObj[SkinStyle.BUTTON_DISABLE] = new ButtonDisable();
			SkinObj[SkinStyle.BUTTON_LABEL] = "Alpha Version";
			
			SkinObj[SkinStyle.PANEL_DEFAULT] = new PanelDefault();
			SkinObj[SkinStyle.PANEL_DISABLE] = new PanelDefault();
			
			SkinObj[SkinStyle.PROFILER_LINECOLOR] = null;
			SkinObj[SkinStyle.PROFILER_TEXTCOLOR] = null;
			
			SkinObj[SkinStyle.SCROLLBAR_TRACK] = new ScrollBarTrack();
			SkinObj[SkinStyle.SCROLLBAR_THUMB] = new ScrollBarThumb();
			
			SkinObj[SkinStyle.ACCORDION_TITLE_LIST] = [];
			
			SkinObj[SkinStyle.LIST_BG] = new ListBg();
			SkinObj[SkinStyle.LIST_CELL_BG] =  new ListCellBg();
			
			SkinObj[SkinStyle.COMBOBOX_TITLE_BG] = new ComboBoxTitleBg();
			SkinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_DEFAULT] = new ComboBoxTitleButtonDefault();
			SkinObj[SkinStyle.COMBOBOX_TITLE_BUTTON_CLICK] = new ComboBoxTitleButtonClick();
			
			SkinObj[SkinStyle.TEXTFIELD_Bg] = null;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_TYPE] = TextFieldType.DYNAMIC;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_SIZE] = 16;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_COLOR] = 0xFFFFFF;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_ALIGN] = "center";
			SkinObj[SkinStyle.TEXTFIELD_TEXT_BOLD] = false;
			SkinObj[SkinStyle.TEXTFIELD_TEXT_HTML] = "text";
			SkinObj[SkinStyle.TEXTFIELD_TEXT_STYLESHEET] = "";
			
			SkinObj[SkinStyle.SLIDER_TRACK] = new SliderTrack();
			SkinObj[SkinStyle.SLIDER_THUMB] = new SliderThumb();
			
			SkinObj[SkinStyle.TOOLTIP_BG] = new ToolTipBg();
			SkinObj[SkinStyle.TOOLTIP_TAIL] = new ToolTipTail();
			
			SkinObj[SkinStyle.BUBBLEBOX_BG] = new BubbleBoxBg();
			SkinObj[SkinStyle.BUBBLEBOX_TAIL] = new BubbleBoxTail();
			
			SkinObj[SkinStyle.CHECKBOX_DEFAULT] = new CheckBoxDefault();
			SkinObj[SkinStyle.CHECKBOX_SELECTED] = new CheckBoxSelected();
			SkinObj[SkinStyle.CHECKBOX_DEFAULT_DISABLE] = new CheckBoxDefaultDisable();
			SkinObj[SkinStyle.CHECKBOX_SELECTED_DISABLE] = new CheckBoxSelectedDisable();
			
			SkinObj[SkinStyle.RADIO_DEFAULT] = new RadioDefault();
			SkinObj[SkinStyle.RADIO_SELECTED] = new RadioSelected();
			SkinObj[SkinStyle.RADIO_DEFAULT_DISABLE] = new RadioDefaultDisable();
			SkinObj[SkinStyle.RADIO_SELECTED_DISABLE] = new RadioSelectedDisable();
			
			SkinObj[SkinStyle.TOGGLEBUTTON_DEFAULT] = new ToggleButtonDefault();
			SkinObj[SkinStyle.TOGGLEBUTTON_ROLLOVER] = new ToggleButtonOver();
			SkinObj[SkinStyle.TOGGLEBUTTON_PRESS] = new ToggleButtonPress();
			SkinObj[SkinStyle.TOGGLEBUTTON_DISABLE] = new ToggleButtonDisable();
			SkinObj[SkinStyle.TOGGLEBUTTON_LABEL] = "Toggle Button";
			
			SkinObj[SkinStyle.THUMBNAIL_BG] = new ThumbnailBg(); 
			SkinObj[SkinStyle.THUMBNAIL_PREVBTN] = null; 
			SkinObj[SkinStyle.THUMBNAIL_NEXTBTN] = null; 
		}
		
	}

}
package com.hezi.uilib.skin 
{
	import flash.display.Sprite;
	
	/**
	 * 测试swf皮肤类
	 * @author seethinks@gmail.com
	 */
	public class SkinDemoTaskSkin extends SkinBase 
	{
		[Embed(source = "../../../../../embed/asset.swf", symbol="ButtonDefault")] private var ButtonDefault:Class;
		[Embed(source = "../../../../../embed/asset.swf", symbol="ButtonOver")] private var ButtonOver:Class;
		[Embed(source = "../../../../../embed/asset.swf", symbol="ButtonPress")] private var ButtonPress:Class;
		[Embed(source = "../../../../../embed/asset.swf", symbol = "ButtonDisable")] private var ButtonDisable:Class;
		
		[Embed(source = "../../../../../embed/asset.swf", symbol = "PanelDefault")] private var PanelDefault:Class;
		
		[Embed(source = "../../../../../embed/asset.swf", symbol = "ScrollBarTrack")] private var ScrollBarTrack:Class;
		[Embed(source = "../../../../../embed/asset.swf", symbol = "ScrollBarThumb")] private var ScrollBarThumb:Class;
		
		[Embed(source = "../../../../../embed/TaskAsset.swf", symbol = "McTitle1Class")] private var McTitle1Class:Class;
		[Embed(source = "../../../../../embed/TaskAsset.swf", symbol = "McTitle2Class")] private var McTitle2Class:Class;
		[Embed(source = "../../../../../embed/TaskAsset.swf", symbol = "McTitle3Class")] private var McTitle3Class:Class;
		
		public function SkinDemoTaskSkin() 
		{
			SkinObj[SkinStyle.BUTTON_DEFAULT] = new ButtonDefault();
			SkinObj[SkinStyle.BUTTON_ROLLOVER] = new ButtonOver();
			SkinObj[SkinStyle.BUTTON_PRESS] = new ButtonPress();
			SkinObj[SkinStyle.BUTTON_DISABLE] = new ButtonDisable();
			SkinObj[SkinStyle.BUTTON_LABEL] = "Test Button";
			
			SkinObj[SkinStyle.PANEL_DEFAULT] = new PanelDefault();
			SkinObj[SkinStyle.PANEL_DISABLE] = new PanelDefault();
			
			SkinObj[SkinStyle.PROFILER_LINECOLOR] = null;
			SkinObj[SkinStyle.PROFILER_TEXTCOLOR] = null;
			
			SkinObj[SkinStyle.SCROLLBAR_TRACK] = new ScrollBarTrack();
			SkinObj[SkinStyle.SCROLLBAR_THUMB] = new ScrollBarThumb();
			
			SkinObj[SkinStyle.ACCORDION_TITLE_LIST] = [new McTitle1Class(),new McTitle2Class,new McTitle3Class()];
		}
		
	}

}
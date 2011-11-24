package com.hezi.uilib
{
	import com.hezi.uilib.components.StButton;
	import com.hezi.uilib.components.StPanel;
	import com.hezi.uilib.components.StProfiler;
	import com.hezi.uilib.components.StList;
	import com.hezi.uilib.components.StScrollBar;
	import com.hezi.uilib.components.StAccordion;
	import com.hezi.uilib.event.StUiEvent;
	import com.hezi.uilib.model.ListDataBroadcast;
	//import com.hezi.uilib.skin.ProtoTypeRect;
	import com.hezi.uilib.skin.SkinDemoBmp;
	//import com.hezi.uilib.skin.SkinDemoDefault;
	//import com.hezi.uilib.skin.SkinDemoSwf;
	//import com.hezi.uilib.skin.SkinDemoTaskSkin;
	import com.hezi.uilib.skin.SkinStyle;
		
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	/**
	 * Box World Gui Lib - Copyright(c) 2011
	 * DebugDemo 入口程序
	 * @author seethinks@gmail.com
	 */
	public class DebugDemoMain extends Sprite 
	{
		private var _buttonNum:int = 0 ;
		private var _panelNum:int = 0 ;
		private var _scrollBarNum:int = 0;
		private var _testProfiler:StProfiler;
		private var _stPanel:StPanel;
		private var _stStretchPanel:StList;
		private var _getPhpData:ListDataBroadcast;

		[Embed(source = "../../../../embed/PanelDefault.png")] private var bgPanelClass:Class;
		
		[Embed(source = "../../../../embed/buyButtonDefault.png")] private var ButtonDefault2:Class;
		
		[Embed(source = "../../../../embed/asset.swf", symbol="ButtonDefault")] private var ButtonDefault:Class;
		[Embed(source = "../../../../embed/asset.swf", symbol="ButtonOver")] private var ButtonOver:Class;
		[Embed(source = "../../../../embed/asset.swf", symbol="ButtonPress")] private var ButtonPress:Class;
		[Embed(source = "../../../../embed/asset.swf", symbol="ButtonDisable")] private var ButtonDisable:Class;
		
		[Embed(source = "../../../../embed/ScrollBarTrack.png", scaleGridTop = "6", scaleGridBottom = "7", scaleGridLeft = "2" , scaleGridRight = "3" )] 
		private var ScrollBarTrack:Class;
		
		[Embed(source = "../../../../embed/ScrollBarThumb.png")] private var ScrollBarThumb:Class;
		
		
		[Embed(source = "../../../../embed/Demo2_List_scroll_track.png", scaleGridTop = "6", scaleGridBottom = "7", scaleGridLeft = "2" , scaleGridRight = "3" )] 
		private var ScrollBarTrack2:Class;
		
		[Embed(source = "../../../../embed/ScrollBarThumb.png")] private var ScrollBarThumb2:Class;
	
		
		public function DebugDemoMain():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			SkinStyle.SetSkinStyle(new SkinDemoBmp);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_testProfiler = new StProfiler(stage.stageWidth - 100, 0, 1, true, true, true);
			_testProfiler.addEventListener(MouseEvent.CLICK, addButton,false,0,true);
			addChild(_testProfiler);

			var addPanel:StButton = new StButton(100, 0);
			addPanel.setStyle(SkinStyle.BUTTON_LABEL, "添加StPanel");
			addPanel.addEventListener(MouseEvent.CLICK, addPanelHandler);
			addChild(addPanel);
			
			_stStretchPanel = new StList([{label:"dd",value:"ssss"},{label:"dd",value:"ssss"},{label:"dd",value:"ssss"},{label:"dd",value:"ssss"},{label:"dd",value:"ssss"},{label:"dd",value:"ssss"},{label:"dd",value:"ssss"},{label:"dd",value:"ssss"},{label:"cc",value:"szzz"}],100, 100);
			//_stStretchPanel.addEventListener(MouseEvent.CLICK, changeTestDataHandler);
			addChild(_stStretchPanel);
			
			SkinStyle.Skin.SkinObj[SkinStyle.SCROLLBAR_TRACK] = new ScrollBarTrack2();
			SkinStyle.Skin.SkinObj[SkinStyle.SCROLLBAR_THUMB] = new ScrollBarThumb2();
			var _stScrollBal:StScrollBar = new StScrollBar(_stStretchPanel.ListContainer,5,-1,StScrollBar.VERTICAL,.5,100,false,true);
			//_stScrollBal.setStyle(SkinStyle.SCROLLBAR_TRACK, new ScrollBarTrack());
			//_stScrollBal.setStyle(SkinStyle.SCROLLBAR_THUMB, new ScrollBarThumb());
			_stStretchPanel.ScrollBar = _stScrollBal;

			var addScrollBar:StButton = new StButton(180);
			addScrollBar.setStyle(SkinStyle.BUTTON_LABEL, "添加StScrollBar");
			addScrollBar.addEventListener(MouseEvent.CLICK, addScrollBarHandler);
			addChild(addScrollBar);
			
			/**
			 * 测试ListData
			 */
			_getPhpData = new ListDataBroadcast();
			var tobj:Object = { testNum:"111" };
			_getPhpData.addObserver(_stStretchPanel);
			_getPhpData.setDataList(tobj);
			
			//createList();

		}
		
		private function createList():void 
		{
			var _list:StList = new StList([],10, 50);
			//trace(_list.x);
			addChild(_list);
		}
		
		/**
		 * 测试主题数据改变，观察者组件接收状态
		 * @param	e
		 */
		private function changeTestDataHandler(e:MouseEvent):void 
		{
			var tobj:Object = { testNum:"dd:" + Math.random() * 999 };
			_getPhpData.setDataList(tobj);
			e.currentTarget.scaleY = Math.random() * 2;
			e.currentTarget.dispatchEvent(new StUiEvent(StUiEvent.CHANGE_SIZE));
		}
		
		private function addScrollBarHandler(e:MouseEvent):void 
		{
			_scrollBarNum++;
			var _panel:StPanel = new StPanel(200, 0);;
			_panel.x = _scrollBarNum * 50 + 330;
			_panel.y = _scrollBarNum * 50 + 30;
			addChild(_panel); 
			_panel.addEventListener(MouseEvent.CLICK, changeMySize);

			SkinStyle.Skin.SkinObj[SkinStyle.SCROLLBAR_TRACK] = new ScrollBarTrack();
			SkinStyle.Skin.SkinObj[SkinStyle.SCROLLBAR_THUMB] = new ScrollBarThumb();
			var _stScrollBal:StScrollBar = new StScrollBar(_panel);
			addChild(_stScrollBal);
			//_stScrollBal.addEventListener(MouseEvent.CLICK, removeScrollBar);
		}
		
		private function changeMySize(e:MouseEvent):void 
		{
			e.currentTarget.setSize(200, Math.random()*800);
		}
		
		private function removeScrollBar(e:MouseEvent):void 
		{
			_scrollBarNum--;
			var _panel:StScrollBar = e.currentTarget as StScrollBar;
			_panel.removeEventListener(MouseEvent.CLICK, removeScrollBar);
			removeChild(_panel);
		}
		
		private function addPanelHandler(e:MouseEvent):void 
		{
			_panelNum++;
			var _panel:StPanel;
			_panel = new StPanel(0,0,1,true,true);
			_panel.x = _panelNum * 50 + 230;
			_panel.y = _panelNum * 50 + 30;
			if (_panelNum % 4 == 0)
			{
				//_panel.setStyle(SkinStyle.PANEL_DEFAULT, new bgClass());
				
			}else if (_panelNum % 4 == 1)
			{
				//_panel.setStyle(SkinStyle.PANEL_DEFAULT,new ButtonDefault());
				//_panel.setSize(200, 200);
				//_button.setStyle(SkinStyle.BUTTON_DEFAULT, new ProtoTypeRect(88, 31, 0x0000ff));
			}else if (_panelNum % 4 == 2)
			{
				//_panel.setStyle(SkinStyle.PANEL_DEFAULT, new bgPanelClass());
				//_panel.setSize(50, 100);
			}
			_panel.addEventListener(MouseEvent.CLICK, removePanel,false,0,true);
			addChild(_panel);
		}
		
		private function addButton(e:MouseEvent):void 
		{
			_buttonNum++;
			var _button:StButton;
			_button = new StButton();
			_button.x = _buttonNum * 30 + 30;
			_button.y = _buttonNum * 30 + 30;
			_button.addEventListener(MouseEvent.CLICK, removeTest,false,0,true);
			addChild(_button);
			/*var _button:StProfiler;
			_button = new  StProfiler();
			_button.x = _buttonNum * 30 + 30;
			_button.y = _buttonNum * 30 + 30;*/
			//_testProfiler.setStyle(SkinStyle.PROFILER_LINECOLOR, Math.random() * 0xffffff);
			//_testProfiler.setStyle(SkinStyle.PROFILER_TEXTCOLOR, Math.random()* 0xffffff);
			//_button.setSize(Math.random()*100+20, Math.random()*100+20);
			if (_buttonNum % 4 == 0)
			{
				//_stPanel.setStyle(SkinStyle.PANEL_DEFAULT, new bgPanelClass());
				//_button.setStyle(SkinStyle.BUTTON_DEFAULT, new ButtonDefault2());
				//_button.setSize(180, 150);
				//_button.setStyle(SkinStyle.BUTTON_LABEL, "test 222:"+Math.random()*1000);
				//_button.setDisable(false);
			}else if (_buttonNum % 4 == 1)
			{
				//_button.setSize(180, 50);
				//_button.setStyle(SkinStyle.BUTTON_DEFAULT, new ProtoTypeRect(88, 31, 0x0000ff));
			}else if (_buttonNum % 4 == 2)
			{
				/*_button.setStyle(SkinStyle.BUTTON_DEFAULT, new ButtonDefault());
				_button.setStyle(SkinStyle.BUTTON_ROLLOVER, new ButtonOver());
				_button.setStyle(SkinStyle.BUTTON_PRESS, new ButtonPress());
				_button.setStyle(SkinStyle.BUTTON_DISABLE, new ButtonDisable());
				_button.setStyle(SkinStyle.BUTTON_LABEL,"");*/
				//_button.setDisable(false);
				//_button.setSize(200, 200);
			}
			
			//_button.setStyle(SkinStyle.STYLE_DEMO, _sd);
			_button.addEventListener(MouseEvent.CLICK, removeTest,false,0,true);
			addChild(_button);
			
			//_sd.BACKGROUND_COLOR = Math.random()*0xffffff;
			//_testProfiler.setStyle(SkinStyle.STYLE_DEMO, _sd);
			//trace(_testProfiler.getStyle(SkinStyle.STYLE_DEMO).BACKGROUND_COLOR);
		}
		
		private function removeTest(e:MouseEvent):void 
		{
			//_stPanel.setSize(200, 200);
			_buttonNum--;
			var _button:StButton = e.currentTarget as StButton;
			_button.removeEventListener(MouseEvent.CLICK, removeTest);
			removeChild(_button);
		}
		private function removePanel(e:MouseEvent):void 
		{
			//_stPanel.setSize(200, 200);
			_panelNum--;
			var _panel:StPanel = e.currentTarget as StPanel;
			//_button.setSize(Math.random() * 100 + 20, Math.random() * 100 + 20);
			//var _button:StPanel = e.currentTarget as StPanel;
			_panel.removeEventListener(MouseEvent.CLICK, removePanel);
			removeChild(_panel);
		}
	}
	
}
package com.hezi.uilib 
{
	import com.hezi.uilib.components.StBubbleBox;
	import com.hezi.uilib.components.StButton;
	import com.hezi.uilib.components.StCheckBox;
	import com.hezi.uilib.components.StComboBox;
	import com.hezi.uilib.components.StList;
	import com.hezi.uilib.components.StPanel;
	import com.hezi.uilib.components.StProfiler;
	import com.hezi.uilib.components.StRadio;
	import com.hezi.uilib.components.StRadioGroup;
	import com.hezi.uilib.components.StScrollBar;
	import com.hezi.uilib.components.StSlider;
	import com.hezi.uilib.components.StTextField;
	import com.hezi.uilib.components.StThumbnail;
	import com.hezi.uilib.components.StToggleButton;
	import com.hezi.uilib.components.StToolTip;
	import com.hezi.uilib.event.StUiEvent;
	import com.hezi.uilib.model.ListDataBroadcast;
	import com.hezi.uilib.model.ListDataModel;
	import com.hezi.uilib.skin.SkinAlpha;
	import com.hezi.uilib.skin.SkinDemoBmp;
	import com.hezi.uilib.skin.SkinDemoSwf;
	import com.hezi.uilib.skin.SkinStyle;
	import flash.geom.Point;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author seethinks@gmail.com
	 */
	public class AlphaDemo extends Sprite 
	{
		[Embed(source = "../../../../TestImg/car2.jpg")] private var carImg:Class;
		
		private var _getPhpData:ListDataBroadcast;
		private var skinObj:Object = {};
		private var ttip:StToolTip;
		private var _panel:StPanel;
		private var _sttext:StTextField;
		private var _radioMsg:Array = ["raido button 1", "raido button 2", "raido button 3"];
		
		private var sitObj:ListDataModel;
		private var numObj:ListDataModel;
		
		public function AlphaDemo() 
		{
			SkinStyle.SetSkinStyle(new SkinAlpha);
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
			var _button:StButton = new StButton(null,10,10);
			addChild(_button);
			
			var _tbutton:StToggleButton = new StToggleButton(null, 10, 50);
			_tbutton.addEventListener(MouseEvent.CLICK, testListDataHandler);
			addChild(_tbutton);
			
			_panel = new StPanel(150, 10);
			_panel.setStyle(SkinStyle.PANEL_DEFAULT, new carImg());
			addChild(_panel);
			var scrollBar:StScrollBar = new StScrollBar(null,_panel);
			addChild(scrollBar);
			

			var _ctlImg:StSlider = new StSlider(null, 150, _panel.y+_panel.height+30, StSlider.HORIZONTAL);
			_ctlImg.addEventListener(StUiEvent.STSLIDER_CHANGE_VALUE, showImg);
			addChild(_ctlImg);
			
			var _ctlImg2:StSlider = new StSlider(null, 150, _panel.y+_panel.height+50, StSlider.HORIZONTAL);
			_ctlImg2.addEventListener(StUiEvent.STSLIDER_CHANGE_VALUE, showImg2);
			_ctlImg2.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			_ctlImg2.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			addChild(_ctlImg2);
			
			
			var _stCheckBox:StCheckBox = new StCheckBox(null, 390, 240,StCheckBox.CHECKBOX_STATUS_SELECTED);
			_stCheckBox.addEventListener(StUiEvent.STCHECK_CHANGESTATUS, showPP);
			addChild(_stCheckBox);
			
			var _stRadio1:StRadio = new StRadio(null, 150, 380,StRadio.RADIO_STATUS_DEFAULT);
			addChild(_stRadio1);
			var _txt1:StTextField = new StTextField(null, _stRadio1.x + _stRadio1.width, 376);
			_txt1.setStyle(SkinStyle.TEXTFIELD_TEXT_ALIGN, "left");
			_txt1.setText("Radio 1");
			addChild(_txt1);
			
			var _stRadio2:StRadio = new StRadio(null, 260, 380);
			addChild(_stRadio2);
			var _txt2:StTextField = new StTextField(null, _stRadio2.x + _stRadio2.width, 376);
			_txt2.setStyle(SkinStyle.TEXTFIELD_TEXT_ALIGN, "left");
			_txt2.setText("Radio 2");
			addChild(_txt2);
			
			var _stRadio3:StRadio = new StRadio(null, 370, 380,StRadio.RADIO_STATUS_SELECTED);
			addChild(_stRadio3);
			var _txt3:StTextField = new StTextField(null, _stRadio3.x + _stRadio3.width, 376);
			_txt3.setStyle(SkinStyle.TEXTFIELD_TEXT_ALIGN, "left");
			_txt3.setText("Radio 3");
			addChild(_txt3);
			
			var _stRadioGroup:StRadioGroup = StRadioGroup.groupRadios(_stRadio1, _stRadio2,_stRadio3);
			_stRadioGroup.addEventListener(StUiEvent.STRADIOGROUP_RADIO_SELECTEDINDEX, showRadioSelect);

			var skinTf:Object = { };
			skinTf[SkinStyle.TEXTFIELD_Bg]= new SkinAlpha.TextFieldBg;
			_sttext = new StTextField(skinTf, 150, 400);
			_sttext.setStyle(SkinStyle.TEXTFIELD_TEXT_TYPE, TextFieldType.INPUT);
			_sttext.setStyle(SkinStyle.TEXTFIELD_TEXT_ALIGN, "left");
			_sttext.text = "dllllljjj";
			stage.focus = _sttext.getText();
			addChild(_sttext);
			
			ttip = StToolTip.getInstance(null);
			this.addChild(ttip);

			sitObj = new ListDataModel();
			var arr:Array = [ { label:"www.google.com", value: { str:"ssss", age:12, msg:"sljflsdfjlsdfjdssfddf" }},
							  { label:"www.baidu.com", value: { str:"ssss", age:12, msg:"sljflsdfjlsdfjdssfddf" }},
							  { label:"www.bing.com", value: { str:"ssss", age:12, msg:"sljflsdfjlsdfjdssfddf" }},
							  { label:"www.morethx.com", value: { str:"ssss", age:12, msg:"sljflsdfjlsdfjdssfddf" }},
							  { label:"www.hezi.com", value: { str:"ssss", age:12, msg:"sljflsdfjlsdfjdssfddf" }},
							  { label:"www.21cn.com", value: { str:"ssss", age:12, msg:"sljflsdfjlsdfjdssfddf" }},
							  { label:"www.test.com", value: { str:"ssss", age:12, msg:"sljflsdfjlsdfjdssfddf" }}
							];
			sitObj.ListDataArr = arr;
			var _list:StList = new StList(arr, null, 550, 100);
			_list.addEventListener(StUiEvent.STLIST_CLICK_CELL, showListValue);
			addChild(_list);
			
			var skinComboBox:Object = { };
			skinComboBox[SkinStyle.LIST_BG] =  new SkinAlpha.ComboBoxListBg;
			skinComboBox[SkinStyle.LIST_CELL_BG] = new SkinAlpha.ComboBoxListCellBg;
			skinComboBox[SkinStyle.SCROLLBAR_TRACK] = new SkinAlpha.ComboBoxScrollBarTrack;
			skinComboBox[SkinStyle.SCROLLBAR_THUMB] = new SkinAlpha.ComboBoxScrollBarThumb;
			skinComboBox[SkinStyle.TEXTFIELD_TEXT_COLOR] = 0x333333;
			var _combox:StComboBox = new StComboBox(arr,skinComboBox,550,340,4,14,4);
			addChild(_combox);
			
			var bb:StBubbleBox = new StBubbleBox(null,20,"BubbleBox is me",new Point(150,500));
			addChild(bb);
			
			var skinThumbnail:Object = { };
			skinThumbnail[SkinStyle.BUTTON_DEFAULT];
			
			
			var _stThumbnail:StThumbnail = new StThumbnail(arr,skinThumbnail,550,400);
			addChild(_stThumbnail);
			
			/**
			 * 测试ListData
			 */
			var testListData:Array = [ { label:"111111111111", value: { str:"ssss", age:12, msg:"sljflsdfjlsdfjdssfddf" }},
							  { label:"2222222222", value: { str:"ssss", age:12, msg:"sljflsdfjlsdfjdssfddf" }},
							  { label:"33333333", value: { str:"ssss", age:12, msg:"sljflsdfjlsdfjdssfddf" }},
							];
							
			_getPhpData = new ListDataBroadcast();
			numObj = new ListDataModel();
			numObj.ListDataArr = testListData;
			_getPhpData.addObserver(_combox);
			_getPhpData.addObserver(_list);

		}
		
		private function testListDataHandler(e:MouseEvent):void 
		{
			var testToggleButton:StToggleButton = e.currentTarget as StToggleButton;
			if (testToggleButton.getStatus())
			{
				_getPhpData.setDataList(numObj);
			}else
			{
				_getPhpData.setDataList(sitObj);
			}
		}
		
		private function showListValue(e:StUiEvent):void 
		{
			var bb:StBubbleBox = new StBubbleBox(null,10,e.StListCellLabel,new Point(Math.random()*stage.stageWidth,Math.random()*stage.stageHeight));
			addChild(bb);
		}
		
		private function showPP(e:StUiEvent):void 
		{
			_panel.visible=e.StCheckBoxStatus;
		}
		
		private function showRadioSelect(e:StUiEvent):void 
		{
			_sttext.setText(_radioMsg[e.StRadioGroupSelectIndex]);
		}
		
		private function showImg2(e:StUiEvent):void 
		{
			var _sl:StSlider = e.currentTarget as StSlider;
			_panel.y = 40 - _sl.Value;
			_panel.dispatchEvent(new  StUiEvent(StUiEvent.STSCROLLBAR_CHANGE_POSITION));
			ttip.show(_sl.Value + "%");

		}
		
		private function onOver(e:MouseEvent):void 
		{
			var _sl:StSlider = e.currentTarget as StSlider;
			ttip.show(_sl.Value + "%");
			stage.addEventListener(MouseEvent.MOUSE_UP, stageUpHandler);
		}
		private function onOut(e:MouseEvent):void
		{
			ttip.hide();
		}
		private function stageUpHandler(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, stageUpHandler);
			ttip.hide();
		}
		
		private function showImg(e:StUiEvent):void 
		{
			var _sl:StSlider = e.currentTarget as StSlider;
			_panel.y = 40 + _sl.Value;
			_panel.dispatchEvent(new  StUiEvent(StUiEvent.STSCROLLBAR_CHANGE_POSITION));
		}
		
		private function init(e:Event = null):void 
		{
			this.graphics.beginFill(0x102121);
			this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			this.graphics.endFill();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var _logo:Sprite = new SkinAlpha.MoreThxLogo as Sprite;
			_logo.x = stage.stageWidth - _logo.width - 10;
			_logo.y = stage.stageHeight - _logo.height - 10;
			addChild(_logo);
			

			var _testProfiler:StProfiler = new StProfiler(stage.stageWidth - 100, 0, 1, true, true, true);
			addChild(_testProfiler);
		}
		

	}

}
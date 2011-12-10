package com.hezi.uilib.skin
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * 皮肤设置核心类,皮肤统一语言的静态声明
	 * @author seethinks@gmail.com
	 */
	public final class SkinStyle
	{
		/**
		 * Button皮肤设定
		 */
		public static const BUTTON_DEFAULT:String = "Button.Default";
		public static const BUTTON_ROLLOVER:String = "Button.RollOver";
		public static const BUTTON_PRESS:String = "Button.Press";
		public static const BUTTON_DISABLE:String = "Button.Disable";
		public static const BUTTON_LABEL:String = "Button.Label";
		
		/**
		 * Panel皮肤设定
		 */
		public static const PANEL_DEFAULT:String = "Panel.Default";
		public static const PANEL_DISABLE:String = "Panel.Disable";
		
		/**
		 * Profiler皮肤设定
		 */
		public static const PROFILER_LINECOLOR:String = "Profiler.LineColor";
		public static const PROFILER_TEXTCOLOR:String = "Profiler.TextColor";
		
		/**
		 * ScrollBar皮肤设定
		 */
		public static const SCROLLBAR_TRACK:String = "ScrollBar.Track";
		public static const SCROLLBAR_THUMB:String = "ScrollBar.Thumb";
		
		/**
		 * Accordion皮肤设定
		 */
		public static const ACCORDION_TITLE_LIST:String = "Accordion.Title.List";
		
		/**
		 * List皮肤设定
		 */
		public static const LIST_BG:String = "List.Bg";
		public static const LIST_CELL_BG:String = "List.Cell.Bg";
		
		/**
		 * ComboBox皮肤设定
		 */
		public static const COMBOBOX_TITLE_BG:String = "ComboBox.Title.Bg";
		public static const COMBOBOX_TITLE_BUTTON_DEFAULT:String = "ComboBox.Title.Button.Default";
		public static const COMBOBOX_TITLE_BUTTON_CLICK:String = "ComboBox.Title.Button.Click";
		 
		/**
		 * TextField风格设定
		 */
		public static const TEXTFIELD_Bg:String = "TextField.Bg";
		public static const TEXTFIELD_TEXT_TYPE:String = "TextField.Type";
		public static const TEXTFIELD_TEXT_SIZE:String = "TextField.Size";
		public static const TEXTFIELD_TEXT_COLOR:String = "TextField.Color";
		public static const TEXTFIELD_TEXT_ALIGN:String = "TextField.Align";
		public static const TEXTFIELD_TEXT_BOLD:String = "TextField.Bold";
		public static const TEXTFIELD_TEXT_HTML:String = "TextField.HTML";
		public static const TEXTFIELD_TEXT_STYLESHEET:String = "TextField.StyleSheet";
		 
		/**
		 * Slider皮肤设定
		 */
		public static const SLIDER_TRACK:String = "Slider.Track";
		public static const SLIDER_THUMB:String = "Slider.Thumb";
		
		/**
		 * ToolTip皮肤设定
		 */
		public static const TOOLTIP_BG:String = "ToolTip.Bg";
		public static const TOOLTIP_TAIL:String = "ToolTip.Tail";
		
		/**
		 * BubbleBox皮肤设定
		 */
		public static const BUBBLEBOX_BG:String = "BubbleBox.Bg";
		public static const BUBBLEBOX_TAIL:String = "BubbleBox.Tail";
		
		/**
		 * CheckBox皮肤设定
		 */
		public static const CHECKBOX_DEFAULT:String = "CheckBox.Default";
		public static const CHECKBOX_SELECTED:String = "CheckBox.Selected";
		public static const CHECKBOX_DEFAULT_DISABLE:String = "CheckBox.Default.Disable";
		public static const CHECKBOX_SELECTED_DISABLE:String = "CheckBox.Selected.Disable";
		
		/**
		 * Radio皮肤设定
		 */
		public static const RADIO_DEFAULT:String = "Radio.Default";
		public static const RADIO_SELECTED:String = "Radio.Selected";
		public static const RADIO_DEFAULT_DISABLE:String = "Radio.Default.Disable";
		public static const RADIO_SELECTED_DISABLE:String = "Radio.Selected.Disable";
		
		/**
		 * ToggleButton皮肤设定
		 */
		public static const TOGGLEBUTTON_DEFAULT:String = "ToggleButton.Default";
		public static const TOGGLEBUTTON_ROLLOVER:String = "ToggleButton.RollOver";
		public static const TOGGLEBUTTON_PRESS:String = "ToggleButton.Press";
		public static const TOGGLEBUTTON_DISABLE:String = "ToggleButton.Disable";
		public static const TOGGLEBUTTON_LABEL:String = "ToggleButton.Label";
		
		/**
		 * Thumbnail皮肤设定
		 */
		public static const THUMBNAIL_BG:String = "Thumbnail.Bg";
		public static const THUMBNAIL_PREVBTN:String = "Thumbnail.PrevBtn";
		public static const THUMBNAIL_NEXTBTN:String = "Thumbnail.NextBtn";
		public static const THUMBNAIL_PREVBTNPOSI:String = "Thumbnail.PrevBtnPosi";
		public static const THUMBNAIL_NEXTBTNPOSI:String = "Thumbnail.NextBtnPosi";
	
		/**
		 * 皮肤基类
		 */
		public static var Skin:SkinBase;
		
		/**
		 * 静态类，设定全局皮肤风格
		 * @param	skin 皮肤基类
		 */
		public static function SetSkinStyle(skin:SkinBase):void
		{
			Skin = skin;
		}
		
		public static function GetSkinStyle():SkinBase
		{
			return Skin;
		}
		
		/**
		 * 普通绘制
		 * @param bitmapData 源数据
		 * @param w 宽度
		 * @param h 高度
		 * @param smooth 是否平滑处理
		 */		
		public static function fillRect(graphics:Graphics, bitmapData:BitmapData, w:Number, h:Number, smooth:Boolean=false):void
		{
			graphics.beginBitmapFill(bitmapData, null, true, smooth);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}
		
		public static function fillRect2(graphics:Graphics, bitmapData:BitmapData, w:Number, h:Number,  mat:Matrix,smooth:Boolean = true):void 
		{
			graphics.beginBitmapFill(bitmapData, mat, true, smooth);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}
		
		/**
		 * 九宫格绘制
		 * @param bitmapData 源数据
		 * @param scale9Grid 九宫格
		 * @param w 宽度
		 * @param h 高度
		 * @param smooth 是否平滑处理
		 */		
		public static function fill9Grid(graphics:Graphics, bitmapData:BitmapData, scale9Grid:Rectangle, w:Number, h:Number, smooth:Boolean=false):void
		{
			var widths:Array = [scale9Grid.left + 1, scale9Grid.width - 2, bitmapData.width - scale9Grid.right + 1];
			var heights:Array = [scale9Grid.top + 1, scale9Grid.height - 2, bitmapData.height - scale9Grid.bottom + 1];
			
			var mw:Number = w - widths[0] - widths[2];
			var mh:Number = h - heights[0] - heights[2];
			
			var left:Number = 0;
			var top:Number = 0;
			
			var j:int, i:int;
			var ox:Number=0, oy:Number=0;
			var dx:Number=0, dy:Number=0;
			var ow:Number, oh:Number;
			var dw:Number, dh:Number;
			var mtx:Matrix = new Matrix();
			
			for(j=0; j < 3; ++j)
			{
				ow = widths[j];					
				dw = (j==1)? mw : ow;
				
				dy = oy = 0;
				mtx.a = dw / ow;
				
				for(i=0; i < 3; ++i)
				{
					oh = heights[i];
					dh = (i==1)? mh : oh;
					
					if (dw > 0 && dh > 0)
					{
						mtx.d = dh / oh;
						mtx.tx = -ox * mtx.a + dx;
						mtx.ty = -oy * mtx.d + dy;
						graphics.beginBitmapFill(bitmapData, mtx, false, smooth);
						graphics.drawRect(dx + left, dy + top, dw, dh);
						graphics.endFill();
					}
					oy += oh;
					dy += dh;
				}
				ox += ow;
				dx += dw;
			}
		}
		
		/**
		 * Draw 画线框图
		 * @param graphics
		 * @param w
		 * @param h
		 */		
		public static function drawDemoBackGround(graphics:Graphics, w:Number, h:Number,color:uint):void
		{
			graphics.lineStyle(0, 0x0);
			graphics.beginFill(color);
			graphics.drawRect(0, 0, w -1, h -1);
			graphics.endFill();
		}
		
		/**
		 * 复制显示对象
		 * @param	target 复制目标
		 * @param	autoAdd 是否自动添加
		 * @return  返回复制后对象
		 */
		public static function duplicateDisplayObject(target:DisplayObject, autoAdd:Boolean = false):DisplayObject
		 {
			var targetClass:Class = Object(target).constructor;
            var duplicate:DisplayObject = new targetClass();
			duplicate.transform = target.transform;
			duplicate.filters = target.filters;
			duplicate.cacheAsBitmap = target.cacheAsBitmap;
			duplicate.opaqueBackground = target.opaqueBackground;
			if (target.scale9Grid) {
				var rect:Rectangle = target.scale9Grid;
				rect.x /= 20, rect.y /= 20, rect.width /= 20, rect.height /= 20;
				duplicate.scale9Grid = rect;
			}
			if (autoAdd && target.parent) {
				target.parent.addChild(duplicate);
			}
			return duplicate;
        }
		
		/**
		 * 复制显示对象以位图返回
		 * @param	target 复制目标
		 * @param	autoAdd 是否自动添加
		 * @return  返回复制后对象
		 */
		public static function duplicateDisplayObjectWithBitmap(target:DisplayObject):DisplayObject
		 {
			var bitmapData:BitmapData = new BitmapData(target.width, target.height, true, 0xffffff);
			bitmapData.draw(target);
            var bmp:Bitmap = new Bitmap(bitmapData);
			var duplicate:MovieClip = new MovieClip();
			duplicate.addChild(bmp);
			return duplicate;
        }
	}
}
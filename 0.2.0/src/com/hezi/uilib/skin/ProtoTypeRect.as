package com.hezi.uilib.skin 
{
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;

	
	/**
	 * 针对demo的基本矩形构造
	 * @author seethinks@gmail.com
	 */
	public class ProtoTypeRect extends BitmapData 
	{

		public function ProtoTypeRect(w:Number=60,h:Number=20,transparent:Boolean=false,color:uint=0x000000,lineColor:uint=0x000000,lineSize:uint=1) 
		{
			super(w, h, transparent,lineColor);
			var _max:Matrix = new Matrix();
			var _offInt:uint = 2;
			var _offRateW:Number = 1 - _offInt * 2 / w;
			var _offRateH:Number = 1 - _offInt * 2 / h;
			_max.translate(_offInt, _offInt);
			_max.scale(_offRateW, _offRateH);
			var ct:ColorTransform = new ColorTransform();
			ct.color = color;
			this.draw(this, _max, ct);
		}
	}
}
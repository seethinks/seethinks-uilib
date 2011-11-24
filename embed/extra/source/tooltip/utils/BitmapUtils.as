package tooltip.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;

	public final class BitmapUtils
	{
		public function BitmapUtils() 
		{
			throw new Error("BitmapUtils must not be instantiated");
		}
		/**
		 * Create a snapshot of an IBitmapDrawable instance
		 * @param	source IBitmapDrawable instance to be used as source
		 * @param	width Final width
		 * @param	height Final height
		 * @param	matrix Matrix instance to manipulate the part of source that will be drawed
		 * @param	smoothing Smooth the result
		 * @param	cacheAsBitmap Store the bitmap in memory
		 * @return The snapshot
		 */
		public static function snapShot(source:IBitmapDrawable, width:int, height:int, matrix:Matrix = null, smoothing:Boolean = false, cacheAsBitmap:Boolean = false):Bitmap
		{
			var b:Bitmap;
			var bd:BitmapData = new BitmapData(width, height, true, 0x000000);
			bd.draw(source, matrix, null, null, null, smoothing);
			b = new Bitmap(bd, PixelSnapping.ALWAYS, smoothing);
			b.cacheAsBitmap = cacheAsBitmap;
			return b;
		}
	}
}
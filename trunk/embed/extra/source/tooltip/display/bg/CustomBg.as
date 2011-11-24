package tooltip.display.bg 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.utils.getDefinitionByName;
	import tooltip.utils.BitmapUtils;
	
	public final class CustomBg extends Sprite
	{
		private var _parts:Vector.<Bitmap>;
		private var _boundaries:int;
		/**
		 * Create a resizable Background
		 * @param	linkage Linkage of a Sprite to be drawed
		 * @param	parent Parent of Background
		 * @param	width Initial width
		 * @param	height Initial height
		 * @param	boundaries Boundaries to slice the image
		 * @param	smoothing Smooth the Background
		 * @param	cacheAsBitmap Store the Background in memory
		 */
		public function CustomBg(linkage:String, parent:DisplayObjectContainer, width:Number = NaN, height:Number = NaN, boundaries:int = 10, smoothing:Boolean = true, cacheAsBitmap:Boolean = false) 
		{
			var Instance:Class = getDefinitionByName(linkage) as Class; 
			var source:Sprite =  new Instance() as Sprite;
			var parts:Vector.<Bitmap> = new Vector.<Bitmap> ();
			var m:Matrix = source.transform.matrix;
			
			parts[0] = BitmapUtils.snapShot(source, boundaries, boundaries, null, smoothing);
			
			m.translate( -boundaries, 0);
			parts[1] = BitmapUtils.snapShot(source, source.width - boundaries * 2, boundaries, m, smoothing);
			
			m.identity();
			m.translate( -source.width + boundaries, 0);
			parts[2] = BitmapUtils.snapShot(source, boundaries, boundaries, m, smoothing);
			
			m.identity();
			m.translate( 0, -boundaries);
			parts[3] = BitmapUtils.snapShot(source, boundaries, source.height - boundaries * 2, m, smoothing);
			
			m.identity();
			m.translate( -boundaries, -boundaries);
			parts[4] = BitmapUtils.snapShot(source, source.width - boundaries * 2, source.height - boundaries * 2, m, smoothing);
			
			m.identity();
			m.translate( -source.width + boundaries, -boundaries);
			parts[5] = BitmapUtils.snapShot(source, boundaries, source.height - boundaries * 2, m, smoothing);
			
			m.identity();
			m.translate(0, -source.height + boundaries);
			parts[6] = BitmapUtils.snapShot(source, boundaries, boundaries, m, smoothing);	
			
			m.identity();
			m.translate(-boundaries, -source.height + boundaries);
			parts[7] = BitmapUtils.snapShot(source, source.width - boundaries * 2, boundaries, m, smoothing);	
			
			m.identity();
			m.translate(-source.width + boundaries, -source.height + boundaries);
			parts[8] = BitmapUtils.snapShot(source, boundaries, boundaries, m, smoothing);

			this.addChild(parts[0]);
			this.addChild(parts[1]);
			this.addChild(parts[2]);
			this.addChild(parts[3]);
			this.addChild(parts[4]);
			this.addChild(parts[5]);
			this.addChild(parts[6]);
			this.addChild(parts[7]);
			this.addChild(parts[8]);
			
			this._parts = parts;
			this._boundaries = boundaries;
			
			this.width = (isNaN(width)) ? source.width : width;
			this.height = (isNaN(height)) ? source.height : height;
			
			parent.addChild(this);
		}
		
		private function arrange():void
		{
			var parts:Vector.<Bitmap> = this._parts;
			var boundaries:int = this._boundaries;
			
			parts[0].x = 0;
			parts[0].y = 0;
			
			parts[1].x = boundaries;
			parts[1].y = 0;
			
			parts[2].x = parts[0].width + parts[1].width;
			parts[2].y = 0;
			
			parts[3].x = 0;
			parts[3].y = boundaries;
			
			parts[4].x = boundaries;
			parts[4].y = boundaries;
			
			parts[5].x = parts[3].width + parts[4].width;
			parts[5].y = boundaries;
			
			parts[6].x = 0;
			parts[6].y = parts[0].height + parts[3].height;
			
			parts[7].x = boundaries;
			parts[7].y = parts[6].y;
			
			parts[8].x = parts[6].width + parts[7].width;
			parts[8].y = parts[6].y;
		}
		public override function set width(v:Number):void
		{
			var parts:Vector.<Bitmap> = this._parts;
			var boundaries:int = this._boundaries;
			
			parts[1].width = v - boundaries * 2;
			parts[4].width = v - boundaries * 2;
			parts[7].width = v - boundaries * 2;
			
			this.arrange();
		}
		public override function set height(v:Number):void
		{
			var parts:Vector.<Bitmap> = this._parts;
			var boundaries:int = this._boundaries;
			
			parts[3].height = v - boundaries * 2;
			parts[4].height = v - boundaries * 2;
			parts[5].height = v - boundaries * 2;			
			
			this.arrange();
		}
	}
}
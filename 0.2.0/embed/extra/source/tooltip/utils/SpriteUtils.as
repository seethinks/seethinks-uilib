package tooltip.utils 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public final class SpriteUtils
	{
		
		public function SpriteUtils() 
		{
			throw new Error("SpriteUtils must not be instantiated");
		}
		/**
		 * Attach a Sprite instance into a DisplayObjectContainer instance
		 * @param	linkage The linkage of Sprite that will be attached
		 * @param	parent The parent of Sprite that will be attached
		 * @return
		 */
		public static function attachSprite(linkage:String, parent:DisplayObjectContainer):Sprite
		{
			var s:Object = parent.loaderInfo.applicationDomain.getDefinition(linkage);
			return parent.addChild(new s()) as Sprite;
		}
	}
}
package {
	import flash.events.*;
	import flash.display.*;

	public class Box extends MovieClip
	{
		private var targetTopY:Number; // the top y-position for the mask to move to
		private var targetBottomY:Number; // the bottom y-position for the mask to move to
		private var easing:Number = 0.3;
		private var isDown:Boolean = false; // true if the mask is down (if the mask is down the content is visible)
		private var subBox:Box; // instance of Box class which is placed below this instance
		
		public function Box()
		{
			targetTopY = content.y - mask1.height;
			targetBottomY = content.y;
			hdr.buttonMode = true;
			hdr.mouseChildren = false;
			//hdr.addEventListener(MouseEvent.CLICK, hdrClick);
			hdr.addEventListener(MouseEvent.MOUSE_OVER, hdrClick);
		}
		
		/**
		  * The subBox is another instance of the Box class placed below this current box.
		  * When current box expands it changes the y-position of the subBox to create the
		  * accordion effect.
		  */
		public function setSubBox(sBox:Box):void
		{
			subBox = sBox;
		}
		
		/**
		  * The user has clicked the header.
		  * Slide mask up or down, depending on current location.
		  */
		private function hdrClick(event:MouseEvent):void
		{
			if(isDown) // slide up (hide content)
			{
				removeEventListener(Event.ENTER_FRAME, slideDown);
				addEventListener(Event.ENTER_FRAME, slideUp);
			}
			else // slide down (show content)
			{
				removeEventListener(Event.ENTER_FRAME, slideUp);
				addEventListener(Event.ENTER_FRAME, slideDown);
			}
			isDown = !isDown;
		}
		
		/**
		  * Slide up the mask to hide content
		  */
		private function slideUp(event:Event):void
		{
			var dy:Number = targetTopY - mask1.y;
			if(Math.abs(dy) < 1)
			{
				//var difference:Number =  targetTopY - mask1.y;
				//if(subBox != null) subBox.moveY(difference);
				mask1.y = targetTopY;
				removeEventListener(Event.ENTER_FRAME, slideUp);
				//this.y = Math.round(this.y);
			}
			else
			{
				var vy:Number = dy * easing;
				mask1.y += vy;
				if(subBox != null) subBox.moveY(vy);
			}
		}
		
		/**
		  * Slide down the mask to reveal content
		  */
		private function slideDown(event:Event):void
		{
			var dy:Number = targetBottomY - mask1.y;
			if(Math.abs(dy) < 1)
			{
				//var difference:Number =  targetBottomY - mask1.y;
				//if(subBox != null) subBox.moveY(difference);
				mask1.y = targetBottomY;				
				removeEventListener(Event.ENTER_FRAME, slideDown);
				//this.y = Math.round(this.y);
			}
			else
			{
				var vy:Number = dy * easing;
				mask1.y += vy;
				if(subBox != null) subBox.moveY(vy);
			}
		}
		
		/**
		  * Add to this instance's y-position and
		  * also adds to the sub-instance (if there is one),
		  * by calling the same with that instance.
		  */
		private function moveY(_vy:Number):void
		{
			this.y += _vy;
			if(subBox != null) subBox.moveY(_vy);
		}
	}
}
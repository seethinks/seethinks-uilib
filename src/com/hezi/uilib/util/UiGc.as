package com.hezi.uilib.util 
{

    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class UiGc extends Object
    {
        public static var mc:MovieClip;

        public function UiGc()
        {
            
        }// end function

       

        public static function clearAllChildren(param1) : void
        {
            var num:uint;
            var j:int;
            var temp:*;
            var mc:* = param1;
          //  try
           // {
                num = mc.numChildren;
                j = (num - 1);
                while (j >= 0)
                {
                    
                    temp = mc.getChildAt(j);
                   // try
                    //{
                        clearAll(temp);
                   // }
                   // catch (e)
                   // {
                       // ;
                   // }
                    j = (j - 1);
                }
           // }
          ///  catch (e:TypeError)
          //  {
          //  }
           // return;
        }// end function

        public static function clearAll(param1, param2:Boolean = true) : void
        {
            var tempBool:Boolean;
            var num:uint;
            var j:int;
            var temp:*;
            var mc:* = param1;
            var allBool:* = param2;
			//trace("aaaaaaaa");
          //  try
           // {
				try{
                if (mc.parent) mc.parent[mc["name"]] = null;
				//trace("bbbbbbbb");
				}catch(e:Error){}
           // }
           // catch (e)
           // {
               // try
               // {
               // }
			   if (mc is Sprite || mc is MovieClip || mc is DisplayObjectContainer)
			   {
                tempBool = mc.hasOwnProperty("numChildren");
				//trace("cccccc");
                if (tempBool)
                {
					//trace("dddddddddd");
                    num = mc.numChildren;
                    j = (num - 1);
					//trace("eeeeeeeee");
                    while (j >= 0)
                    {
                       // trace("fffffffffff");
                        temp = mc.getChildAt(j);
                       // try
                       // {
					   //trace("gggggggg");
                            clearAll(temp, false);
                       // }
                        //catch (e)
                       // {
                           
                       // }
					  // trace("hhhhhhhhhhh");
                        j = (j - 1);
                    }
                }
			   }
           // }
          //  catch (e)
           // {
               // try
               /// {
             // }
			// trace("iiiiiiiii");
             stopAllMC(mc);
           // }
           // catch (e)
           // {
           // }
		  // trace("jjjjjjjjj");
            if (allBool)
            {
              //  try
               // {
			   //trace("kkkkkkkkkkk");
                    mc.parent.removeChild(mc);
               // }
              //  catch (e)
               // {
               // }
            }
           // return;
        }// end function

		public static function stopAllMC(param1) : void
        {
            var temp:*;
            var mc:* = param1;
            //try
           // {
              if (mc is MovieClip) mc.stop();
           // }
            //catch (e)
           // {
           // }
            var num:* = mc.numChildren;
            var j:* = (num - 1);
            while (j >= 0)
            {
                
                temp = mc.getChildAt(j);
                if (temp is MovieClip)
                {
                    stopAllMC(temp);
                }
                j = (j - 1);
            }
           
        }
    }
}

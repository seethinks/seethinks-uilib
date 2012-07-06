package com.hezi.uilib.util {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;	
	import flash.display.DisplayObject;	
	import flash.display.DisplayObjectContainer;    
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.net.LocalConnection; 
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.system.System;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;

	public class GC {
		private static var GC_arr : Array = [];

		/**
		 * 添加需要转场景GC的类容
		 */
		public static function addClearUi(d : DisplayObject) : void
		{
			GC_arr.push(d);
		}
		
		
          public static function Gc():void 
          { 
                        try
                        {
                                new LocalConnection().connect("mt");
                                new LocalConnection().connect("mt");
                        }
                        catch (e:Error)
                        {
                                
                        }
						//trace("::::::::: GC 来啦！！！ ::::::::::::::::::::: ");
        } 
		
          public static function clear():void 
          { 
                        try
                        {
                                new LocalConnection().connect("mt");
                                new LocalConnection().connect("mt");
                        }
                        catch (e:Error)
                        {
                                
                        }
        }
		
		//private static var num:int = 0;
        public static function killMySelf(cont:*):void
		{
			//num ++;
			var child:DisplayObject;
			for (var i:Number = cont.numChildren - 1; i >= 0; i--) {
					
					//trace("cont.numChildren ============:"+i,cont.numChildren,"  cont:"+cont);
					if (i<cont.numChildren)  // 判断索引值
					{
						//try
						{
							child = cont.getChildAt(i);
							if (child is DisplayObjectContainer) 
							{
									killMySelf(DisplayObjectContainer(child));
							}
							if (child is SimpleButton)
							{
								child.parent.removeChild(child);
								//child = null;
							}else if (child is Shape ) 
							{
								Shape(child).graphics.clear();
								//child = null;
							}else if (child is Bitmap ) 
							{
								Bitmap(child).bitmapData.dispose();
								//child = null;
							}else if (child is Loader ) 
							{
								//trace("Loader Loader Loader Loader Loader Loader 111 ");
									Loader(child).unloadAndStop();
									Loader(child).unload();
								//trace("Loader Loader Loader Loader Loader Loader 222");
									//child = null;
							}else if (cont is MovieClip)
							{
								GC.stopAllMc(cont);
							}else
							{
								//trace("cont 44 sprite:"+child);
								cont.removeChild(child);
							}
						//}catch(E:Error){}
					}
				}
			}
        }
        
       public static function stopAllMc(_con : DisplayObject) : void {
		   
		  var child:DisplayObject;	
		  
		  if(_con is DisplayObjectContainer){
		  	 var con:DisplayObjectContainer=_con as DisplayObjectContainer;
		     var i:int=con.numChildren;
			 if(con is MovieClip){
				 var m:MovieClip=con as MovieClip;
				 m.stop();
			 }		      	
		     while((i--)>0){		  
		        child = con.getChildAt(i); 
		        stopAllMc(child);              
             }
		 }
	   }
	  public static function clearAllMc(_con : DisplayObject) : void 
		{
			var child : DisplayObject;	
			if(_con is DisplayObjectContainer) 
			{
				var con : DisplayObjectContainer = _con as DisplayObjectContainer;
				var i : int = con.numChildren;

				if(con is MovieClip) 
				{
					var m : MovieClip = con as MovieClip;
					m.stop();
				}		
				
				while((i--) > 0) 
				{		  
					child = con.getChildAt(i); 
					//trace("child child child child child:"+child);
					clearAllMc(child);
					//try 
					//{
					if (con is Loader)
					{
						//trace("LoaderLoaderLoaderLoaderLoader Loader:"+con);
						Loader(con).unload();
						Loader(con).unloadAndStop();
					}else if (con is URLLoader)
					{
						URLLoader(con).close();
					}else
					{
						con.removeChild(child);
						child = null;
					}
					//}catch(e : Error) 
					//{
					//}     
				}
			}else
			{
				//trace("_con _con _con _con _con 22222222:" + _con);
				
				if(_con is Bitmap)
				{
					try
					{
						Bitmap(_con).bitmapData.dispose();
					}catch (e:Error){}
				}
				if(_con is Shape)
				{
					Shape(_con).graphics.clear();
				}
				_con = null;
			}
		} 
	   

		/**
		 * 清除弹出POP
		 */
		public static function clearPopContainer() : void
		{
			var i : int = GC_arr.length;
			while(i--)
			{
				var d : DisplayObject = GC_arr[i] as DisplayObject;
				if(d)
				{
					GC.stopAllMc(d);
					GC.clearAllMc(d);
				}
			}
		}
		
		public static function clear2() : void {
                        var time : int = 2;
                        var interval : int = setInterval(loop, 50);
                        function loop() : void {
                                if(!(time--)) {
                                        clearInterval(interval);
                                        return;
                                }
                                SharedObject.getLocal("cypl", "/");
                        }
                }
	}
}
 


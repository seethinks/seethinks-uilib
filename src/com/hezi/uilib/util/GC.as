package com.hezi.uilib.util {
	import flash.display.Loader;
	import flash.display.MovieClip;	
	import flash.display.DisplayObject;	
	import flash.display.DisplayObjectContainer;    
	import flash.net.LocalConnection; 

	public class GC {
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
        } 
		
        public static function killMySelf(cont:DisplayObjectContainer):void {

			var child:DisplayObject;
			for (var i:Number = cont.numChildren - 1; i >= 0; i--) {
					
					if (i<cont.numChildren)  // 判断索引值
					{
						try
						{
							child = cont.getChildAt(i);
							if (child is DisplayObjectContainer) 
							{
									killMySelf(DisplayObjectContainer(child));
							}
							if (cont is Loader ) 
							{
									var loader:Loader = cont as Loader;
									loader.unloadAndStop();
							}else
							{
								cont.removeChild(child);
							}
						}catch(E:Error){}
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
	   public static function clearAllMc(_con:DisplayObject):void{
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
		        clearAllMc(child); 		
				try{
		        	con.removeChild(child); 
		        }catch(e:*){
		        }     
			 
             }
			 
		 }
	   
	   } 
	}
}
 


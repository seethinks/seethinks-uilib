package com.hezi.uilib.Error 
{
	import com.hezi.uilib.core.UiLibVersion;
	import flash.utils.getQualifiedClassName;

	/**
	 * Ui Lib Error class
	 * @author seethinks@gmail.com
	 */
	public class UiLibError extends Error 
	{
		public static const ABSTRACTCLASS_UNINSTANCE_MSG:String = "抽象类，无法被实例化";
		public static const UNEXTEND_ABSTRACTFUNCTION_MSG:String = "没有继承抽象类的抽象方法";
		public static const SINGLETON_CREATECLASS_MSG:String = "此单例类的对象已经被创建";
		public static const VALUE_TYPEERROR_MSG:String = "参数类型错误";
		public static const INTERDICT_CHANGESKIN:String = "禁止修改皮肤";
		public static const DATA_IS_NOTNULL:String = "数据不允许为空";
		
		/**
		 * UiLibError类构造函数
		 * @param	msg 错误信息
		 * @param	curClass 错误发生的类
		 * @param	...param 不定参数
		 */
		public function UiLibError(msg:String = "", curClass:Class = null, ... param) 
		{
			super(formatErrorMsg("UiLib Error #", msg, curClass, param));
		}
		
		/**
		 * 信息格式化
		 * @param	type
		 * @param	msg
		 * @param	curClass
		 * @param	...param
		 * @return 
		 */
		public static function formatErrorMsg(type:String = "", msg:String = "", curClass:Class = null, ... param ):String
		{
			var showMsg:String = "Ui Lib Verson:" + UiLibVersion.VERSION + " 更新日期:" + UiLibVersion.UPDATE_DATE + "\n";
			if (curClass)
			{
				var _className:String = getQualifiedClassName(curClass);
				showMsg += type + " [" + _className + "]出现错误," + msg + param.toString();
			}else
			{
				showMsg += type + msg + param.toString();
			}
			return showMsg;
		}
		
	}

}
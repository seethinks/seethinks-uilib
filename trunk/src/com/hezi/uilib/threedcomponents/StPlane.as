package com.hezi.uilib.threedcomponents
{
	import flare.basic.Scene3D;
	import flare.core.Camera3D;
	import flare.core.Pivot3D;
	import flare.core.Texture3D;
	import flare.primitives.Plane;
	import flare.materials.filters.TextureFilter;
	import flare.materials.Shader3D;
	import flare.primitives.Plane;
	import gs.TweenMax;
	/**
	 * ...
	 * @author seethinks@gmail.com
	 */
	public class StPlane extends Pivot3D
	{
		private var _scene:Scene3D;
		private var _planeCamera:Camera3D;
		
		public function StPlane(scene:Scene3D)
		{
			_planeCamera = new Camera3D();
			_scene = scene;
			var _bgPlane:Plane = new Plane("BackgroundPlane", 910, 560);
			this.addChild(_bgPlane);
			var texture:Texture3D = _scene.addTextureFromFile("material/carInfoPlane.png");
			var bgMaterial:Shader3D = new Shader3D("surfaceMaterial", [new TextureFilter(texture)]);
			this.parent = _planeCamera;
			this.z = 1 / _planeCamera.zoom * 910;
			_bgPlane.setMaterial(bgMaterial);
			_scene.addChild(_planeCamera);
			trace(_planeCamera,_scene.camera);
		}
		
		public function showOrHide(b:Boolean):void
		{
			if (b)
			{
				this.visible = true;
				this.z = 1 / _planeCamera.zoom * 910;
				//_planeCamera.scaleX = _planeCamera.scaleY = _planeCamera.scaleZ = .5;
				//_scene.addChild(_planeCamera);
				//TweenMax.to(_planeCamera,1, { scaleX:1,scaleY:1,scaleZ:1 } );
			}
			else
			{
				this.visible = false;
				//_scene.removeChild(_planeCamera);
			}
		}
	
	}

}
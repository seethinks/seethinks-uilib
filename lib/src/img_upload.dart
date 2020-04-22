import 'dart:io';
import 'package:beeui/bee.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImgUpload extends StatefulWidget {
  final Widget placeholder;
  final double width;
  final double height;
  final value;
  final Function onCrop;

  const ImgUpload({this.placeholder,
    this.width,
    this.value,
    this.height,
    this.onCrop,
    Key key})
      : super(key: key);

  @override
  _ImgUploadState createState() => _ImgUploadState();
}

class _ImgUploadState extends State<ImgUpload> {
  File imageFile;
  File _sample;
  BuildContext ctx;

  // final cropKey = GlobalKey<CropState>();
  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Listener(
        child: Container(
            child: widget.value == null
                ? defaultImage()
                : ovalImage()),
        onPointerDown: (e) {
          _onTap();
        }
    );
  }

  Widget defaultImage() {
    return SizedBox(
        width: widget.width, height: widget.height, child: widget.placeholder);
  }

  Widget ovalImage() {
    print("收到${widget.value}");
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.value),
          fit: BoxFit.cover,
        ),
        color: Colors.grey[300],
      ),
      // child: _img,
    );
    // return Align(
    // 默认头像图片放在左上方。
    // alignment: Alignment.topLeft,
    // child: NetworkImage(widget.value)
    // Image.network(widget.value,
    //     fit: BoxFit.cover, width: widget.width, height: widget.height)
    // child: Image.file(
    //   widget.value,
    //   fit: BoxFit.cover,
    //   width: widget.width,
    //   height: widget.height,
    // ),
    // );
  }

  void _onTap() {
    showModal();
  }

  Future showModal() {
    BeeActionsheet.ios(context)(
        cancelButton: '取消',
        options: [
          BeeActionsheetItem(label: "拍摄照片", value: '0'),
          BeeActionsheetItem(label: "从手机相册选择", value: '1'),
        ],
        onChange: (String value) {
          if (value == "0") {
            fromCamera();
          } else {
            fromGallery();
          }
        });
  }

  //从相机
  fromCamera() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setImgPath(image);
    } catch (e) {
      print(e);
    }
  }

  //从相册
  fromGallery() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setImgPath(image);
    } catch (e) {
      print(e);
    }
  }

  setImgPath(File file) async {
    print("image====${file}");
    setState(() {
      // _sample = sample;
      imageFile = file;
    });
    _cropImage(file);
    // showCropModal();
  }

  Future<Null> _cropImage(File imageFile) async {
    assert(imageFile != null);
    CropAspectRatio cropAspectRatio = CropAspectRatio(ratioX: 1.0, ratioY: 1.0);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: cropAspectRatio,
      maxWidth: 512,
      maxHeight: 512,
    );
    if (widget.onCrop != null) {
      widget.onCrop(croppedFile);
    }
  }
}

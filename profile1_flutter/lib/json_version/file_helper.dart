import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileHelper{
  String _fileName="mat_hangs.json";
  //lay duong dan tu thu muc ung dung
  Future<String> get _localPath async{
    var dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
  //tao tham chieu den tap tin
    //Dung file.io
    Future<File> get _localFile async{
    String path = await _localPath;
    return File("$path/$_fileName");
    }
  //ghi noi dung vao file
  Future<File> writeString(String content) async{
    File file = await _localFile;
    return file.writeAsString(content);
  }
 Future<String>readString() async{
    try{
      File file = await _localFile;
      if(!file.existsSync()){
        print('file chưa tồn tại: ${file.absolute}');
        // await file.writeAsString('{"mat_hangs": []}',encoding: Utf8Codec());
        await file.writeAsString('{"mat_hangs": []}');
      }
      // String content= await file.readAsString(encoding: Utf8Codec());
      String content= await file.readAsString();
      return content;
    } catch(e){
      print('Lỗi khi đọc file: $e');
      return null;
    }
  }
}
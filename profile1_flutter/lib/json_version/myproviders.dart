

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:profile1_flutter/json_version/file_helper.dart';
import 'package:profile1_flutter/json_version/model.dart';

class CatalogeFileProvider extends ChangeNotifier{
  MatHangDatabase _matHangDatabase;
  FileHelper _fileHelper = FileHelper();
  CatalogeFileProvider();


  List<MatHang> get listMH => _matHangDatabase == null ? null : _matHangDatabase.listMH;


  Future<void> readMatHangs() async{
    String contents = await _fileHelper.readString();
    if(contents != null){
      //chuyển contents thành đối tượng Map<String, dynamic>
      var mapObject = json.decode(contents);
      _matHangDatabase = MatHangDatabase.fromJson(mapObject);
      print("Số lượng mặt hàng: ${_matHangDatabase.listMH.length}");
      notifyListeners();
    }
  }

  Future<File> updateMatHangs() async{
    notifyListeners();
    String jsonStr = json.encode(_matHangDatabase);
    return _fileHelper.writeString(jsonStr);

  }
  Future<File> addMatHang(MatHang mh) async{
    listMH.add(mh);
    notifyListeners();
    String jsonStr = json.encode(_matHangDatabase);
    return _fileHelper.writeString(jsonStr);
  }
  Future<File> deleteMatHang(MatHang mh) async{
    listMH.remove(mh);
    notifyListeners();
    String jsonStr = json.encode(_matHangDatabase);
    return _fileHelper.writeString(jsonStr);
  }
}
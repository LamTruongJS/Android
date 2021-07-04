import 'package:flutter/cupertino.dart';
import 'package:profile1_flutter/model/cataloge_model.dart';

// Khai báo thư viện
// Tạo model và đặt lắng nghe với ChangeNotifier
// Khai báo provider ở các Widget cha
// Sử dụng provider ở các Widget con.

class ProviderCataloge extends ChangeNotifier{
  List<MatHang> _matHangs;
  List<int> _gioHang = [];
  ProviderCataloge(){
    _matHangs= CatalogeModel.matHangs;
  }
//state cua ung dung
  int get slMH => _gioHang.length;
  List<MatHang> get cataloge => _matHangs; // lay ra danh sach cac mat hang
  List<MatHang> get gioHang => _gioHang.map((id) => _matHangs[id]).toList(); // chuyển từng mặt hàng trong giỏ thành 1 danh sách mặt hàng
  int get total =>gioHang.fold(0, (previousValue, currentElement) => previousValue+ currentElement.price);
  //total=0
  // for(int i=0,i<gioHang.length,i++)
  //total=total+gioHang[i].price;
  //end
bool checkInCart(int id){
  return _gioHang.indexOf(id)>-1; // neu ko co thi tra ve -1// neu co tra ve index
}
void addToCart(MatHang mh){
if(!checkInCart(mh.id))
  {
    _gioHang.add(mh.id);
    notifyListeners(); // báo cho ta biết giao diện được cập nhật lại
  }
}
void removeFromCart(MatHang mh){
  int idXoa=_gioHang.indexOf(mh.id);
  _gioHang.removeAt(idXoa);
  notifyListeners();
}



}
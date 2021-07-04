import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:profile1_flutter/model.dart';

class EditPage extends StatefulWidget {
  //khoi tao them 1 widget
  MyProfile myProfile;
    //alt+ insert--> constructer
  EditPage({key,this.myProfile}):super(key:key);

  @override
  _EditPageState createState() => _EditPageState();
}
 //De thanh phan State truy xuat duoc  vao phan tren thi phan tren can khai bao 1 bien widget(data)// ki hieu la $
class _EditPageState extends State<EditPage> {
  TextEditingController hoTenController = TextEditingController();
  //Nhan Ctrl +D de coppy
  TextEditingController imageController = TextEditingController();
  TextEditingController ngaySinhController = TextEditingController();
  TextEditingController queQuanController = TextEditingController();
  TextEditingController soThichController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [

              _buidTextEdit(hoTenController,"Ho Ten"), // cach 1 de goi ham
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Row(
                  children: [
                    RadioButton(
                      description:"Nam",
                      value: true,
                      groupValue: widget.myProfile.gioiTinh,
                      onChanged: (value) => setState(
                              () => widget.myProfile.gioiTinh = value
                      ),
                    ),
                    RadioButton(
                      description: "Nu",
                      value: false,
                      groupValue: widget.myProfile.gioiTinh,
                      onChanged: (value) => setState(
                              () => widget.myProfile.gioiTinh = value
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: _buidTextEdit(ngaySinhController, "Ngay Sinh"),
                  ),
                  TextButton(
                      onPressed:() async{
                        var datePicked = await _selectDate(widget.myProfile.ngaySinh, context);
                        if(datePicked!=null){
                          setState(() { //cap nhat lai ngay sinh va chon ngay
                            widget.myProfile.ngaySinh=datePicked;
                            ngaySinhController.text="${datePicked.day}/${datePicked.month}/${datePicked.year}";  //ngaySinhController.text=datePicked.toString();//
                          });
                        }
                      },
                      child: Icon(Icons.calendar_today),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              _buidTextEdit(queQuanController, "Que Quan"),
              SizedBox(height: 10,),
              TextField(
                controller: soThichController,  //cach 2 de goi ham
                decoration: InputDecoration(
                  labelText: "So Thich",
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // vi tri bat dau noi dung
                children: [
                  ElevatedButton(
                      onPressed: () => _toProfilePage(context),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Ok"),
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      );
  }


  // ham de load du lieu
  Widget _buidTextEdit(TextEditingController controller, String label){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  //bo chon ngay
  Future<DateTime> _selectDate(DateTime ngaySinh, BuildContext context) async{
    var datePicked = showDatePicker(
        context: context,
        initialDate: ngaySinh== null? DateTime.now():ngaySinh,
        firstDate: DateTime.now().subtract(Duration(days: 365*50)),
        lastDate: DateTime.now().add(Duration(days: 356*50)),
    );
    return datePicked;
  }
  @override
  void initState() {
    super.initState();
    hoTenController.text =widget.myProfile.hoTen;
    ngaySinhController.text =widget.myProfile.ngaySinh== null? "" :widget.myProfile.ngaySinh.toString();
    queQuanController.text =widget.myProfile.queQuan;
    soThichController.text =widget.myProfile.soThich;

  }

  @override
  void dispose() {
    super.dispose();
    hoTenController.dispose();
    ngaySinhController.dispose();
    queQuanController.dispose();
    soThichController.dispose();
  }
  //Ham gui DL sang view 1
  _toProfilePage(BuildContext context) {
    widget.myProfile.hoTen= hoTenController.text;
    widget.myProfile.queQuan= queQuanController.text;
    widget.myProfile.soThich = soThichController.text;
    Navigator.pop(context,widget.myProfile);
  }
}


import 'package:flutter/material.dart';
import 'package:baitap01_onthi/models/Models.dart';
import 'package:baitap01_onthi/pages/app_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  MonHocSnapshot monHocSnapshot;
  TextEditingController diemMH = TextEditingController();
  TextEditingController soTC = TextEditingController();
  TextEditingController hocKy = TextEditingController();
  TextEditingController maMH = TextEditingController();
  TextEditingController tenMH = TextEditingController();
  bool bacBuoc = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm môn học"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextEdit(maMH, "Mã môn học",),
            SizedBox(height: 10),
            _buildTextEdit(tenMH, "Tên môn Học"),
            SizedBox(height: 10),
            _buildTextEdit(soTC, "Số tín chỉ"),
            SizedBox(height: 10),
            _buildTextEdit(hocKy, "Học kỳ"),
            SizedBox(height: 10),
            _buildTextEdit(diemMH, "Điểm trung bình môn"),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Bắc buộc!",style: TextStyle(fontSize: 20.0), ),
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                    value: bacBuoc,
                    onChanged: (bool value) {
                      setState(() {
                        bacBuoc = value;
                      });
                    },
                  ),]
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed:() async {
                    MonHoc mh =  MonHoc(TenMH: tenMH.text,
                        MaMH: maMH.text,
                        SoTC: int.parse(soTC.text),
                        DiemTB: int.parse(diemMH.text),
                        HocKy: int.parse(hocKy.text),
                        BatBuoc: bacBuoc);
                    await addToFirebase(mh);
                    _showDialogAdd(context);
                  },
                    child: Text("Thêm",style: TextStyle(fontSize: 20),),),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: ()=>Navigator.pop(context),
                      child: Text("Hủy",style: TextStyle(fontSize: 20),),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTextEdit(TextEditingController controller, String label){
    return TextField(
      style: TextStyle(fontSize: 20),
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
          )
      ),
    );
  }
  void _showDialogAdd(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Thông báo !"),
          content: Text("Thêm môn học thành công môn học "+ tenMH.text , style: TextStyle(fontSize: 20),),
          actions: [
            ElevatedButton(
              child: Text("Hoàn Tất",style: TextStyle(fontSize: 20),),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AppPage(),));
              },
            ),
          ],
        );
      },);
  }
}
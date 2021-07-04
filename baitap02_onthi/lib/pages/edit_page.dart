import 'package:flutter/material.dart';
import 'package:baitap02_onthi/models/model.dart';
import 'package:baitap02_onthi/pages/app_page.dart';

class EditPage extends StatefulWidget {
  final NhatKySnapshot nhatKySnapshot;
  const EditPage({Key key,@required this.nhatKySnapshot}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController ghiChu = TextEditingController();
  TextEditingController tamTrang = TextEditingController();
  TextEditingController ngay = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa nhật ký"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: ngay,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(labelText: "Thời gian",
                    icon: GestureDetector(
                      child: Icon(Icons.calendar_today) ,
                      onTap: () async {
                        var datePicker = await _selectDate(context);
                        if (datePicker != null) { //neu bang null, nó sẽ lấy ngày hôm nay
                          setState(() {
                            selectedDate = datePicker;
                            var x = datePicker.toString();
                            var y = x.substring(0, 4);
                            var m = x.substring(5, 7);
                            var d = x.substring(8,10);

                            print(d+"/"+m+"/"+y);

                            ngay.text =d+"/"+m+"/"+y;
                          });
                        }
                      }
                      ,
                    ) ),
              ),

              SizedBox(
                height: 10,
              ),
              TextField(
                controller: tamTrang,

                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(labelText: "Cảm xúc",
                    icon: Icon(Icons.mood)),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: ghiChu,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(labelText: "Ghi chú",
                    icon: Icon(Icons.note)),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  ElevatedButton(
                    child: Text("Lưu", style: TextStyle(fontSize: 20),),
                    onPressed: () async {
                      await widget.nhatKySnapshot.update(ngay.text , tamTrang.text , ghiChu.text);
                      _showDialog();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      child: Text("Hủy", style: TextStyle(fontSize: 20),),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    tamTrang.text = widget.nhatKySnapshot.nhatKy.TamTrang;
    ghiChu.text = widget.nhatKySnapshot.nhatKy.GhiChu;
    ngay.text = widget.nhatKySnapshot.nhatKy.Ngay;
  }
  void _showDialog (){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Thông báo !"),
          content: Text("Đã cập nhật xong nhật kí" ),
          actions: [
            ElevatedButton(
              child: Text("OK"),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AppPage(),));
              },
            ),
          ],
        );
      },);
  }
  Future<DateTime> _selectDate(BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate:  DateTime(int.tryParse((widget.nhatKySnapshot.nhatKy.Ngay).substring(6,10))+1,
            int.tryParse((widget.nhatKySnapshot.nhatKy.Ngay).substring(3,5)), int.tryParse((widget.nhatKySnapshot.nhatKy.Ngay).substring(0,2))),
        firstDate: DateTime.now().subtract(Duration(days: 365 * 50)),
        lastDate: DateTime.now().add(Duration(days: 365 * 50)));


    return picked;
  }
}

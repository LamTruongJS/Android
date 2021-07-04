import 'package:flutter/material.dart';
import 'package:baitap02_onthi/models/model.dart';
import 'package:baitap02_onthi/pages/app_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}



class _AddPageState extends State<AddPage> {
  TextEditingController ngay = TextEditingController();
  TextEditingController tamTrang = TextEditingController();
  TextEditingController ghiChu = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm nhật ký"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [

              TextField(
                controller: ngay,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(labelText: "Thời gian",
                    icon: GestureDetector( //bắt cử chỉ(chạm, lướt,lắc,.....)
                      child: Icon(Icons.calendar_today) ,
                      onTap: () async {
                        var datePicker = await _selectDate(context);
                        if (datePicker != null) {  // nếu bộ chọn ngày khác null nó sẽ lấy ngày trong bộ chọn, nếu bằng null, nó lấy ngày hôm nay
                          setState(() {
                            selectedDate = datePicker;
                            var x = datePicker.toString();
                            var y = x.substring(0, 4); //năm
                            var m = x.substring(5, 7); //tháng
                            var d = x.substring(8,10); //ngày

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
                decoration: InputDecoration(labelText: "Note",

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
                    child: Text("Thêm", style: TextStyle(fontSize: 20),),
                    onPressed: () async { //thao tác lưu vào firebase
                      NhatKy nk = new NhatKy(
                          Ngay: ngay.text,
                          TamTrang: tamTrang.text,
                          GhiChu: ghiChu.text);
                      await addToFirebase(nk);
                      _ShowDialog();
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

  void _ShowDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Thông báo"),
              content: Text("Đã thêm nhật kí mới"),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AppPage(),)),
                    child: Text("OK"))
              ]);
        });
  }

  @override
  void initState() {
    super.initState();
    tamTrang.text = "";
    ghiChu.text = "";
    DateTime date= DateTime.now();
    var x = date.toString();
    var y = x.substring(0, 4);
    var m = x.substring(5, 7);
    var d = x.substring(8,10);
    ngay.text = d+"/"+m+"/"+y;
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(Duration(days: 365 * 50)), // ngày đầu trong bộ chọn
        lastDate: DateTime.now().add(Duration(days: 365 * 50))); // ngày cuối trong bộ chọn
    return picked;
  }
}

import 'package:baitap04_onthi/models/chitieu_model.dart';
import 'package:baitap04_onthi/models/vi_model.dart';
import 'package:baitap04_onthi/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

class AddPage extends StatefulWidget {
  ViSnapshot vsn;
  AddPage({Key key, this.vsn}) : super(key: key);
  @override
  _AddPageState createState() => _AddPageState();
}

TextEditingController txtAddLD = TextEditingController();
TextEditingController txtAddST = TextEditingController();
TextEditingController txtAddTG = TextEditingController();
bool thu_chi = true;
class _AddPageState extends State<AddPage> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm mục thu chi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [

              TextField(
                  controller: txtAddLD,
                  decoration: InputDecoration(labelText: "Lí do",)

              ),

              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtAddST,
                decoration: InputDecoration(labelText: "Số tiền",
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtAddTG,
                      decoration: InputDecoration(labelText: "Thời gian",
                      ),
                      keyboardType: TextInputType.number,
                    ),),
                  TextButton(
                      onPressed: () async {
                        var datePicker = await _selectDate(context);
                        if (datePicker != null) {
                          setState(() {
                            selectedDate = datePicker;
                            var x = datePicker.toString();
                            var y = x.substring(0, 4);
                            var m = x.substring(5, 7);
                            var d = x.substring(8,10);

                            print(d+"/"+m+"/"+y);

                            txtAddTG.text =d+"/"+m+"/"+y;
                          });
                        }

                      },
                      child: Icon(Icons.calendar_today) ),
                ],
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RadioButton(description: "Thu", value: true , groupValue: thu_chi , onChanged:(value){
                      setState(() {
                        thu_chi = value;

                      });
                    } ,),
                    RadioButton(description: "Chi", value: false, groupValue: thu_chi , onChanged: (value) {
                      setState(() {
                        thu_chi = value;
                      });
                    },),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  ElevatedButton(
                    child: Text("OK"),
                    onPressed: () async {
                      //lưu vào firebase
                      ChiTiet ct = new ChiTiet(
                          lido: txtAddLD.text,
                          sotien:  int.tryParse(txtAddST.text),
                          thoigian: txtAddTG.text,
                          thuchi: thu_chi
                      );
                      await addCT(ct);
                      if(thu_chi){
                        // nếu bằng true, thực hiện cộng tiền vào thu
                        widget.vsn.vi.thu += int.tryParse(txtAddST.text);
                        await widget.vsn.updateVi(thu: widget.vsn.vi.thu);
                      }
                      else{
                        //nếu bằng false thực hiện cộng tiền vào chi
                        widget.vsn.vi.chi += int.tryParse(txtAddST.text);
                        await widget.vsn.updateVi(chi: widget.vsn.vi.chi);
                      }

                      print(widget.vsn.vi.thu);
                      print(widget.vsn.vi.chi);
                      _notice(); // thông báo

                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      child: Text("Thoát"),
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
    txtAddLD.text = "";
    txtAddST.text = "";
    DateTime date= DateTime.now();
    var x = date.toString();
    var y = x.substring(0, 4);
    var m = x.substring(5, 7);
    var d = x.substring(8,10);
    txtAddTG.text = d+"/"+m+"/"+y;
  }
  _notice() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Thông báo"),
              content: Text("Đã thêm mục thu chi mới"),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserPape(),)),
                    child: Text("OK"))
              ]);
        });
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 365 * 50)),
        lastDate: DateTime.now().add(Duration(days: 365 * 50)));

    return picked;
  }
}

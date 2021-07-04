import 'package:baitap04_onthi/models/chitieu_model.dart';
import 'package:baitap04_onthi/models/vi_model.dart';
import 'package:baitap04_onthi/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

class EditPage extends StatefulWidget {
  CTSnapshot ctSnapshot;
  ViSnapshot visn;
  EditPage({Key key, this.ctSnapshot, this.visn }) : super(key: key);
  @override
  _EditPageState createState() => _EditPageState();
}
TextEditingController txtAddLD = TextEditingController();
TextEditingController txtAddST = TextEditingController();
TextEditingController txtAddTG = TextEditingController();
bool thu_chi=true;
class _EditPageState extends State<EditPage> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sửa mục thu chi"),
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
                        widget.ctSnapshot.ct.thuchi = value;

                      });
                    } ,),
                    RadioButton(description: "Chi", value: false, groupValue: thu_chi , onChanged: (value) {
                      setState(() {
                        widget.ctSnapshot.ct.thuchi = value;
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


                      await widget.ctSnapshot.update(lido: txtAddLD.text,
                          sotien: int.tryParse(txtAddST.text), thoigian: txtAddTG.text, thuchi: thu_chi);

                      if(widget.ctSnapshot.ct.thuchi){
                        widget.visn.vi.thu =  widget.visn.vi.thu - widget.ctSnapshot.ct.sotien+ int.tryParse(txtAddST.text);
                        await widget.visn.updateVi(thu: widget.visn.vi.thu);
                      }
                      else{
                        widget.visn.vi.chi =  widget.visn.vi.chi - widget.ctSnapshot.ct.sotien+ int.tryParse(txtAddST.text);
                        await widget.visn.updateVi(chi: widget.visn.vi.chi);
                      }
                      _notice();

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
  Future<DateTime> _selectDate(BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: DateTime(int.tryParse((widget.ctSnapshot.ct.thoigian).substring(6,10))+1,
            int.tryParse((widget.ctSnapshot.ct.thoigian).substring(3,5)), int.tryParse((widget.ctSnapshot.ct.thoigian).substring(0,2))),
        firstDate: DateTime.now().subtract(Duration(days: 365 * 50)),
        lastDate: DateTime.now().add(Duration(days: 365 * 50)));

    return picked;
  }
  @override
  void initState() {
    super.initState();
    txtAddLD.text = widget.ctSnapshot.ct.lido;
    txtAddST.text = widget.ctSnapshot.ct.sotien.toString();
    txtAddTG.text = widget.ctSnapshot.ct.thoigian;
    thu_chi = widget.ctSnapshot.ct.thuchi;
  }
  void _notice (){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Thông báo !"),
          content: Text("Đã cập nhật xong thu chi" ),
          actions: [
            ElevatedButton(
              child: Text("OK"),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserPape(),));
              },
            ),
          ],
        );
      },);
  }
}
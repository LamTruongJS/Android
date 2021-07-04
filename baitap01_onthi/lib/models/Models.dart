
import 'package:cloud_firestore/cloud_firestore.dart';
class MonHoc{
  int DiemTB;
  int HocKy;
  String MaMH;
  int SoTC;
  String TenMH;
  bool BatBuoc;
  MonHoc({this.DiemTB, this.SoTC,this.HocKy,this.MaMH,this.TenMH,this.BatBuoc});
  factory MonHoc.fromJson(Map<String, dynamic> json){
    return MonHoc(
        DiemTB: json["DiemTB"],
        SoTC: json["SoTC"],
        HocKy: json["HocKy"],
        MaMH: json["MaMH"],
        TenMH: json["TenMH"],
        BatBuoc: json["BatBuoc"]
    );
  }
  Map<String, dynamic> toJson(){
    return {
      "DiemTB" : this.DiemTB,
      "SoTC" : this.SoTC,
      "HocKy" :this.HocKy,
      "MaMH" : this.MaMH,
      "TenMH" : this.TenMH,
      "BatBuoc" : this.BatBuoc
    };
  }
}
class MonHocSnapshot{
  MonHoc monHoc;
  DocumentReference documentReference;
  MonHocSnapshot({this.monHoc, this.documentReference});

  MonHocSnapshot.fromSnapshot(DocumentSnapshot snapshot){
    // sử dụng khi có factory
    // return UserSnapshot(
    //   user: User.fromJson(snapshot.data()),
    //   documentReference: snapshot.reference,
    // );
    this.monHoc = MonHoc.fromJson(snapshot.data());
    this.documentReference = snapshot.reference;
  }
  Future<void> update(int DiemTB,int SoTC,int HocKy, String MaMH,String TenMH,bool BatBuoc) async{
    await documentReference.update({
      "DiemTB" : DiemTB == null ? monHoc.DiemTB : DiemTB,
      "SoTC" : SoTC == null ? monHoc.SoTC : SoTC,
      "HocKy" : HocKy == null ? monHoc.HocKy : HocKy,
      "MaMH" : MaMH == null ? monHoc.MaMH : MaMH,
      "TenMH" : TenMH == null ? monHoc.TenMH : TenMH,
      "BatBuoc" : BatBuoc == null ? monHoc.BatBuoc : BatBuoc
    });  // cấu trúc dữ liệu của  phần data
  }
  Future<void> delete() async {
    await documentReference.delete();
  }
  static Stream<List<MonHocSnapshot>> getAllMonhocFromFirebase(){
    Stream<QuerySnapshot> doc = FirebaseFirestore.instance.collection("MonHoc").snapshots();
    Stream<List<DocumentSnapshot>> list = doc.map((qsn) => qsn.docs);
    Stream<List<MonHocSnapshot>> listmonhocSnapshot = list.map((listDocSnap) => listDocSnap.map((DocSnap) => MonHocSnapshot.fromSnapshot(DocSnap)).toList());
    return listmonhocSnapshot;
  }
}
Future<void> addToFirebase(MonHoc mh) async{
  var Bang = FirebaseFirestore.instance.collection("MonHoc");
  await Bang.add(mh.toJson());
  return;
}
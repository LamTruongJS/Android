import 'package:cloud_firestore/cloud_firestore.dart';

class NhatKy{
  String Ngay;
  String TamTrang;
  String GhiChu;
  NhatKy({this.Ngay, this.TamTrang, this.GhiChu});
  factory NhatKy.fromJson(Map<String, dynamic> json)=>
      NhatKy(
        Ngay: json['Ngay'],
        TamTrang: json['TamTrang'],
        GhiChu: json['GhiChu'],
      );
  Map<String, dynamic> toJson()=>
      {
        'Ngay': Ngay,
        'TamTrang':TamTrang,
        'GhiChu':GhiChu
      };
}
class NhatKySnapshot{
  NhatKy nhatKy;
  DocumentReference documentReference;

  NhatKySnapshot({this.nhatKy, this.documentReference});

  NhatKySnapshot.fromSnapshot(DocumentSnapshot snapshot){
    this.nhatKy = NhatKy.fromJson(snapshot.data());
    this.documentReference = snapshot.reference;
  }
  Future<void> update(String Ngay, String TamTrang, String GhiChu) async{
    await documentReference.update({
      'Ngay': Ngay == null ? nhatKy.Ngay : Ngay,
      'TamTrang':TamTrang == null ? nhatKy.TamTrang : TamTrang,
      'GhiChu':GhiChu == null ? nhatKy.GhiChu : GhiChu,});
  }
  Future<void> delete() async {
    await documentReference.delete();
  }

  static Stream<List<NhatKySnapshot>> getAllMonhocFromFirebase(){
    Stream<QuerySnapshot> doc = FirebaseFirestore.instance.collection("Nhatky").snapshots();
    Stream<List<DocumentSnapshot>> list = doc.map((qsn) => qsn.docs);
    Stream<List<NhatKySnapshot>> listmonhocSnapshot = list.map((listDocSnap) => listDocSnap.map((DocSnap) => NhatKySnapshot.fromSnapshot(DocSnap)).toList());
    return listmonhocSnapshot;
  }
}
Future<void> addToFirebase(NhatKy nk) async{
  var Bang = FirebaseFirestore.instance.collection("Nhatky");
  await Bang.add(nk.toJson());
  return;
}
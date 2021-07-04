import 'package:cloud_firestore/cloud_firestore.dart';

class NongSan{
  String tenns;
  String mota;
  int soluong;
  int gia;
  String url;
  NongSan({this.tenns,this.mota,this.gia,this.url,this.soluong});

  factory NongSan.fromJson(Map<String, dynamic> json)
  {
    return NongSan(
        tenns: json['tenns'],
        mota: json['mota'],
        gia: json['gia'],
        url: json['url']
    );
  }
  Map<String, dynamic> toJson()
  {
    return{
      "tenns" :this.tenns,
      "mota" : this.mota,
      "gia" : this.gia,
      "url" : this.url
    };
  }
}
class NongSanSnapshot{
  NongSan nongSan;
  DocumentReference documentReference;
  NongSanSnapshot(this.nongSan, this.documentReference);
  NongSanSnapshot.fromSnapshot(DocumentSnapshot snapshot){
    this.nongSan = NongSan.fromJson(snapshot.data());
    this.documentReference = snapshot.reference;
  }
  Future<void>update({String tenns, String mota, int gia, String url}) async {
    return await documentReference.set(
        {
          "tenns" : tenns != null ? tenns : nongSan.tenns,
          "mota" :mota != null ? mota :nongSan.mota,
          "gia" : gia != null ? gia: nongSan.gia,
          "url" : url != null ? url: nongSan.url,
        }
    );
  }
  Future<void> delete() async{
    return await documentReference.delete();
  }
}
Stream<List<NongSanSnapshot>> getAllNongSanFromFireBase(){

  Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance.collection("nongsan").snapshots();
  Stream<List<DocumentSnapshot>>list = querySnapshot.map((qsn)=> qsn.docs);
  Stream<List<NongSanSnapshot>> dsNhatKy = list.map((listDocSnap)=>
      listDocSnap.map((docSnap) => NongSanSnapshot.fromSnapshot(docSnap)).toList()
  );
  return dsNhatKy;
}
Future<void> addNongSan(NongSan nongSan) async{
  var collectionRef =FirebaseFirestore.instance.collection("nongsan");
  await collectionRef.add(nongSan.toJson());
  return;
}
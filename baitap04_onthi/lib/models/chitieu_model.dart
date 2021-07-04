import 'package:cloud_firestore/cloud_firestore.dart';

class ChiTiet{
  String lido;
  int sotien;
  String thoigian;
  bool thuchi;
  ChiTiet({this.lido, this.sotien, this.thoigian, this.thuchi});

  factory  ChiTiet.fromJson(Map<String, dynamic> json) {
    return  ChiTiet(
        lido: json["lido"],
        sotien: json["sotien"],
        thoigian: json["thoigian"],
        thuchi : json["thuchi"]
    );

  }
  Map<String, dynamic> toJson() {
    return {
      "lido": this.lido,
      "sotien": this.sotien,
      "thoigian": this.thoigian,
      "thuchi":this.thuchi
    };
  }
}

class CTSnapshot {
  ChiTiet ct;
  DocumentReference documentReference;

  CTSnapshot({this.ct, this.documentReference});

  CTSnapshot.fromSnapshot(DocumentSnapshot snapshot) {
    this.ct = ChiTiet.fromJson(snapshot.data());
    this.documentReference = snapshot.reference;
  }

  Future<void> update({String lido, int sotien, String thoigian, bool thuchi}) async {
    await documentReference.update({

      "lido": lido==null?ct.lido:lido,
      "sotien":sotien==null?ct.sotien:sotien,
      "thoigian": thoigian==null?ct.thoigian:thoigian,
      "thuchi":thuchi==null?ct.thuchi:thuchi,

    });
  }
  Future<void> delete() async {
    await documentReference.delete();
  }
}
Stream<List<CTSnapshot>> getAllSubjectFromFireBase() {
  Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance.collection("ChiTiet").snapshots();
  Stream<List<DocumentSnapshot>> list = querySnapshot.map((qsn) => qsn.docs);
  Stream<List<CTSnapshot>> listSJSnapshot = list.map((listDocSnap)
  =>listDocSnap.map((docSnap) => CTSnapshot.fromSnapshot(docSnap)).toList());
  return listSJSnapshot;
}

Future<void> addCT(ChiTiet chiTiet) async {
  CollectionReference CollectionRef =  FirebaseFirestore.instance.collection("ChiTiet");
  await CollectionRef.add(chiTiet.toJson()).then((value) => print("Subject has been added")).catchError((error) => print("Error"));
  //CollectionRef.doc("4").set(user.toJson());
  return;
}
import 'package:cloud_firestore/cloud_firestore.dart';

class Vi{
  int thu, chi;
  Vi({this.thu, this.chi});

  factory Vi.fromJson(Map<String, dynamic> json) {
    return Vi(
      thu: json["thu"],
      chi: json["chi"],

    );

  }
  Map<String, dynamic> toJson() {
    return {
      "thu": this.thu,
      "chi": this.chi,

    };
  }
}

class ViSnapshot {
  Vi vi;
  DocumentReference documentReference;

  ViSnapshot({this.vi, this.documentReference});
  ViSnapshot.fromSnapshot(DocumentSnapshot snapshot) {
    this.vi = Vi.fromJson(snapshot.data());
    this.documentReference = snapshot.reference;
  }

  Future<void> updateVi({int thu, int chi}) async {
    await documentReference.update({
      "thu":thu==null?vi.thu:thu,
      "chi":chi==null?vi.chi:chi,
    });
  }
  //
  // Future<void> delete() async {
  //   await documentReference.delete();
  // }

  static Stream<ViSnapshot> getUserFromFirebase(String id) {
    Stream<DocumentSnapshot> docSnapshot =
    FirebaseFirestore.instance.collection("Vi").doc(id).snapshots();
    return docSnapshot
        .map((docSnapshot) => ViSnapshot.fromSnapshot(docSnapshot));
  }
}
// Future<void> addNK(Vi vi) async {
//   CollectionReference CollectionRef =  FirebaseFirestore.instance.collection("NhatKy");
//   await CollectionRef.add(vi.toJson()).then((value) => print("Subject has been added")).catchError((error) => print("Error"));
//   //CollectionRef.doc("4").set(user.toJson());
//   return;
// }
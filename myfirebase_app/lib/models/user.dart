


import 'package:cloud_firestore/cloud_firestore.dart';

class User{
//  làm việc với giao diện với UI
  String ten, que_quan;
  int nam_sinh;

  User({this.ten, this.que_quan, this.nam_sinh});
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      ten: json["ten"],
      que_quan: json["que_quan"],
      nam_sinh: json["nam_sinh"],
    );
  }
  Map<String, dynamic> toJson(){
    return {
      "ten": this.ten,
      "quen_quan": this.que_quan,
      "nam_sinh": this.nam_sinh,
    };
  }
}

class UserSnapshot {
//  làm việc với CSDL
  User user;
  DocumentReference docReference; // đối tượng tham chiếu đến firebase
  // đối tượng trung gian không cần toJson
  UserSnapshot({this.user, this.docReference});


  factory UserSnapshot.fromSnapshot(DocumentSnapshot snapshot){
    //return khi dùng từ khóa factory
    return UserSnapshot(
      user: User.fromJson(snapshot.data()),
      docReference: snapshot.reference,
    );
    //nếu ko dùng từ khóa factory
    // this.user= User.fromJson(snapshot.data());
    // this.documentReference= snapshot.reference;
  }

  Future<void> update({String ten, String que_quan, int nam_sinh}) async {
    await docReference.update({
      "ten": ten == null ? user.ten : ten,
      "que_quan": que_quan == null ? user.que_quan : que_quan,
      "nam_sinh": nam_sinh == null ? user.nam_sinh : nam_sinh,
    }); // cấu trúc dữ liệu của  phần data
  }

  Future<void> delete() async {
    await docReference.delete();
  }

  static Future<UserSnapshot> getUserFromFireBaseByID(String id) async {
    var snapshot = await FirebaseFirestore.instance.collection("Users")
        .doc(id)
        .get();
    return UserSnapshot.fromSnapshot(snapshot);
  }

  static Stream<UserSnapshot> getDocFromFirebase(String id) {
    Stream<DocumentSnapshot> docSnapshop = FirebaseFirestore.instance
        .collection("Users").doc(id).snapshots();
    return docSnapshop.map((docSnapshot) =>
        UserSnapshot.fromSnapshot(docSnapshot));
  }

  static Stream <List<UserSnapshot>> getAllUserFromFirebase() {
    Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance.collection(
        "Users").snapshots(); // Tạo ra 1 biến với KDL là QuerySnapshot,
                              // mà 1 querySnapShot ta có  được khi truy xuất trên 1 collection
                              // 1 querySnapshot gồm nhiều documentSnapshot => nên cơ bản nó là 1 list
    Stream<List<DocumentSnapshot>> list = querySnapshot.map((qsn) => qsn.docs); //Tạo ra 1 biến có tên là list
                      // có các giá trị qsn
                      // nó là các phần tử của 1 query => cái list này cũng là 1 danh sách.
    Stream <List<UserSnapshot>> listUserSnapshot = list.map((listDocSnap) =>
        listDocSnap.map((docSnap) => UserSnapshot.fromSnapshot(docSnap))
            .toList()
    ); // cái này tạo ra 1 biến có tên là listUserSnapshot
        // các phần tử trong nó là của cái biến list ở trên
        // vì các phần tử của biến list là 1 documentSnapshot
        // nên phải tolist() để cái map này nó mới chuyển đổi hết cái list ở trên.
        // nếu ko có tolist() nó chỉ hiện ra 1 documentSnapshot

    return listUserSnapshot;
  }

}
Future<void> addUserToFirebase(User user) async{
  var collectionRef=FirebaseFirestore.instance.collection("Users");
  await collectionRef.add(user.toJson());
  return;
}


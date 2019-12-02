import 'package:cloud_firestore/cloud_firestore.dart';

class Api{
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Api( this.path ) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments() ;
  }
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    // print("path: " + path);
    // print("getting document by ID " + id.toString());
    // ref.document(id).get().then((onValue) {
    //   print(onValue.data.toString());
    // });
    return ref.document(id).get();
  }
  Future<void> removeDocument(String id){
    return ref.document(id).delete();
  }
  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }
  Future<void> updateDocument(Map data , String id) {
    print("updating document");
    return ref.document(id).updateData(data) ;
  }
  Future<void> updateArray(dynamic data, String id, String key) {
    return ref.document(id).updateData({key : FieldValue.arrayUnion([data.toJson()])});
  }


}
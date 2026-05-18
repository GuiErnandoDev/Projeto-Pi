import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Adiciona um documento em uma coleção
  Future<void> addData(String collection, Map<String, dynamic> data) async {
    await _db.collection(collection).add(data);
  }

  // Lê todos os documentos de uma subcoleção de um usuário
  Stream<QuerySnapshot> getUserSubcollectionStream(String userId, String subcollection) {
    return _db.collection('clientes').doc(userId).collection(subcollection).snapshots();
  }

  // Atualiza um documento
  Future<void> updateData(String collection, String docId, Map<String, dynamic> data) async {
    await _db.collection(collection).doc(docId).update(data);
  }

  // Deleta um documento
  Future<void> deleteData(String collection, String docId) async {
    await _db.collection(collection).doc(docId).delete();
  }
}

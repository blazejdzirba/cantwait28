import 'package:cantwait28/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    return FirebaseFirestore.instance
        .collection('items')
        .orderBy('release_date')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return ItemModel(
            id: doc.id,
            title: doc['title'],
            imageURL: doc['image_url'],
            relaseDate: (doc['release_date'] as Timestamp).toDate(),
          );
        },
      ).toList();
    });
  }

  Future<void> delete({required String id}) {
    return FirebaseFirestore.instance
          .collection('items')
          .doc(id)
          .delete();
  }
}

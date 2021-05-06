import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  int id;
  String title;
  Timestamp date;
  bool check;
  DocumentReference reference;

  TodoModel(
      {this.title = '',
      this.check = false,
      this.reference,
      this.date,
      this.id});

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    return TodoModel(
        title: doc['title'],
        check: doc['check'],
        date: doc['date'],
        reference: doc.reference);
  }

  factory TodoModel.fromJson(Map doc) {
    return TodoModel(
        title: doc['title'],
        check: doc['check'],
        date: doc['date'],
        id: doc['id']);
  }
}

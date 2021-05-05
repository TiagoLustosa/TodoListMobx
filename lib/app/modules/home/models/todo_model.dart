import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String title;
  Timestamp date;
  bool check;
  DocumentReference reference;

  TodoModel({this.title = '', this.check = false, this.reference, this.date});

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    return TodoModel(
        title: doc['title'],
        check: doc['check'],
        date: doc['date'],
        reference: doc.reference);
  }

  Future save() async {
    if (reference == null) {
      reference = await FirebaseFirestore.instance.collection('todo').add(
        {'title': title, 'check': check, 'date': date},
      );
    } else {
      reference.update({'title': title, 'check': check, 'date': date});
    }
  }

  Future delete() {
    return reference.delete();
  }
}

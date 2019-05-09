import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spent/models/expense.dart';

class FirestoreService {
  final Firestore fireStore;

  FirestoreService({this.fireStore});

  Stream<List<Expense>> getExpenses() {
    return fireStore.collection('expenses').snapshots().map((snapshot) {
      return snapshot.documents.map((doc) {
        int intAmount = doc['amount'];
        double amount = intAmount.toDouble();

        return Expense(
            expenseId: doc.documentID,
            name: doc['name'],
            amount: amount,
            category: doc['category']);
      }).toList();
    });
  }
}

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spent/models/category.dart';
import 'package:spent/models/expense.dart';

class FirestoreService {
  final Firestore fireStore;

  FirestoreService({this.fireStore});

  Stream<List<Expense>> getExpenses() {
    return fireStore.collection('expenses').snapshots().map((snapshot) {
      return snapshot.documents.map((doc) {
        return Expense(
            expenseId: doc.documentID,
            name: doc['name'],
            amount: doc['amount'],
            category: Category(name: doc['category']));
      }).toList();
    });
  }

  void addExpense(
      String name, String amount, String category, DateTime expenseDate) {
    fireStore.collection('expenses').add({
      'name': name,
      'amount': amount,
      'category': category,
      'expenseDate': expenseDate
    });
  }
}

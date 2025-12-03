import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();

  return snapshot.data()!;
});

//total item count provider
final totalItemProvider = StreamProvider<int>((ref) {
  final user = ref.watch(authProvider).value;

  if (user == null) {
    return Stream.value(0);
  }

  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('assets')
      .snapshots()
      .map((snap) => snap.docs.length);
});


//category count provider
final categoryCountProvider = StreamProvider.family<int, String>((ref, category){
  return FirebaseFirestore.instance
      .collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('assets').where('category', isEqualTo: category).snapshots()
      .map((snap) => snap.docs.length);
});

//warrenty count provider
final warrentyProvider = StreamProvider<int>((ref){
  final uid = FirebaseAuth.instance.currentUser!.uid;

  return FirebaseFirestore.instance.collection('users').doc(uid).collection('assets').snapshots().map((snap){
    int count = 0;
    for(var doc in snap.docs){
      final data = doc.data();

      final expiry = data['expiryDate'];

      if(expiry != null && expiry is String && expiry.trim().isNotEmpty){
        count++;
      }
    }
    return count;
  });
});

//Firestore Query to sort Category assets
final categoryAssetsProvider  = StreamProvider.family<List<QueryDocumentSnapshot>, String>((ref, categoryName){
  final uid = FirebaseAuth.instance.currentUser!.uid;
   return FirebaseFirestore.instance.collection('users').doc(uid).collection('assets')
       .where('category', isEqualTo: categoryName).snapshots().map((snap) => snap.docs);
});


//auth Provider for authStateChanges() so provider rebuilds for each user
final authProvider = StreamProvider<User?>((ref){
  return FirebaseAuth.instance.authStateChanges();
});


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marrow_master/view/auth_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) throw Exception('No user currently logged in');
      String userId = user.uid;
      await _deleteUserData(userId);
      await _deleteUserFiles(userId);
      await user.delete();
      await _saveLoginStatus(false);
      Get.snackbar('Success', 'Account deleted successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAll(() => LoginScreen());
    } catch (e) {
      print('Error deleting account: $e');
      Get.snackbar('Error', 'Failed to delete account: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> _saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> _deleteUserData(String userId) async {
    WriteBatch batch = _firestore.batch();

    DocumentReference userDoc = _firestore.collection('users').doc(userId);
    batch.delete(userDoc);
    QuerySnapshot historySnapshot = await _firestore
        .collection('history')
        .where('userId', isEqualTo: userId)
        .get();
    for (QueryDocumentSnapshot doc in historySnapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  Future<void> _deleteUserFiles(String userId) async {
    String storagePath = 'user_files/$userId/';
    ListResult result = await _storage.ref(storagePath).listAll();
    for (Reference fileRef in result.items) {
      await fileRef.delete();
    }
  }
}

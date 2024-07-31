import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  RxList<HistoryItem> historyItems = <HistoryItem>[].obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  late StreamSubscription<QuerySnapshot> _historySubscription;

  @override
  void onInit() {
    super.onInit();
    listenToHistoryItems();
  }

  @override
  void onClose() {
    _historySubscription.cancel();
    super.onClose();
  }

  void listenToHistoryItems() {
    print("Listening to history items...");
    User? user = _auth.currentUser;
    if (user != null) {
      final String userId = user.uid;
      try {
        isLoading.value = true;
        _historySubscription = FirebaseFirestore.instance
            .collection('history')
            .where('userId', isEqualTo: userId)
            .snapshots()
            .listen((querySnapshot) {
          print("Fetched ${querySnapshot.docs.length} history items");
          historyItems.assignAll(querySnapshot.docs.map((doc) {
            final data = doc.data();
            return HistoryItem(
              text: data['description'] as String,
              date: data['date'].toString(),
              imageUrl: data['image'] as String,
              name: data['name'] as String,
              userId: data['userId'] as String,
            );
          }).toList());
          isLoading.value = false;
        });
      } catch (e) {
        isLoading.value = false;
        print("Error listening to history: $e");
        historyItems.clear(); // Clear in case of error
      }
    } else {
      print("No user is currently logged in.");
      isLoading.value = false;
    }
  }
}

class HistoryItem {
  final String text;
  final String date;
  final String imageUrl;
  final String name;
  final String userId;

  HistoryItem({
    required this.text,
    required this.date,
    required this.imageUrl,
    required this.name,
    required this.userId,
  });
}

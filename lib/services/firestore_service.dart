import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- Users ---

  Future<void> saveUser(String uid, Map<String, dynamic> userData) async {
    await _db.collection(AppConstants.usersCollection).doc(uid).set(userData, SetOptions(merge: true));
  }

  Future<DocumentSnapshot> getUser(String uid) async {
    return await _db.collection(AppConstants.usersCollection).doc(uid).get();
  }

  // --- Plans ---

  Future<void> createPlan(Map<String, dynamic> planData) async {
    await _db.collection(AppConstants.plansCollection).add(planData);
  }

  Stream<QuerySnapshot> getNearbyPlans(
    double lat,
    double lng,
    double radiusInKm,
  ) {
    // Note: For real geo-queries, use 'geoflutterfire' package.
    // This is a simplified query fetching all active plans for MVP.
    // In production, you would filter by geohash or lat/lng bounds.
    return _db
        .collection(AppConstants.plansCollection)
        .where('isOpen', isEqualTo: true)
        // .where('expiresAt', isGreaterThan: Timestamp.now()) // Requires composite index
        .snapshots();
  }

  // --- Chats ---
  
  Stream<QuerySnapshot> getMyChats(String userId) {
    return _db
        .collection(AppConstants.chatsCollection)
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
  }
}

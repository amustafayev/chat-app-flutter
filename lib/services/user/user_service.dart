import 'package:chat_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsService {
  static final USER_DETAILS_COLLECTION = 'user_details';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserDetailsDto> getUserDetails(String userId) async {
    final snapshot = await _firestore
        .collection(USER_DETAILS_COLLECTION)
        .doc(userId)
        .get();

    if (!snapshot.exists) {
      throw Exception("User details not found with user id: $userId");
    }

    final data = snapshot.data() as Map<String, dynamic>;

    return UserDetailsDto(
      userId: data['userId'],
      profilePicUrl: data['profilePicUrl'],
      name: data['name'],
      email: data['email'],
      bio: data['bio'],
    );
  }

  Future<void> saveUserDetails(UserDetailsDto userDetails) async {
    _firestore
        .collection(USER_DETAILS_COLLECTION)
        .doc(userDetails.userId)
        .set(userDetails.toMap());
  }

  Stream<List<UserDetailsDto>> getUserList() {
    return _firestore.collection(USER_DETAILS_COLLECTION).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs.map((doc) {
        final user = UserDetailsDto(
          userId: doc.data()['userId'],
          email: doc.data()['email'],
          profilePicUrl: doc.data()['profilePicUrl'],
          name: doc.data()['name'],
          bio: doc.data()['bio'],
        );
        return user;
      }).toList();
    });
  }

  Future<void> saveUserProfilePicture(String userId, String downloadUrl) async {
    var userDetailsDto = await getUserDetails(userId);
    userDetailsDto.profilePicUrl = downloadUrl;
    await saveUserDetails(userDetailsDto);
  }
}

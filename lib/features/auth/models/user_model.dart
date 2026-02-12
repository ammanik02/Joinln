class UserModel {
  final String uid;
  final String phoneNumber;
  final String displayName;
  final String? photoUrl;
  final String? bio;
  final bool isVerified;
  
  UserModel({
    required this.uid,
    required this.phoneNumber,
    required this.displayName,
    this.photoUrl,
    this.bio,
    this.isVerified = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'bio': bio,
      'isVerified': isVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      displayName: map['displayName'] ?? '',
      photoUrl: map['photoUrl'],
      bio: map['bio'],
      isVerified: map['isVerified'] ?? false,
    );
  }
}

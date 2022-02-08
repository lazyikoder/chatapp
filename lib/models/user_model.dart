class UserModel {
  String userName;
  String userEmailId;
  String userStatus;

  UserModel({
    required this.userName,
    required this.userEmailId,
    required this.userStatus,
  });

  factory UserModel.fromMap(QueryDocumentSnapshot<Object?> map) {
    return UserModel(
      userName: map["name"] ?? 'No User',
      userEmailId: map["email"] ?? 'No Email',
      userStatus: map["status"] ?? 'Unknown',
    );
  }
}

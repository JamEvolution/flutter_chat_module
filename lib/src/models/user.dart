class User {
  final String userID;
  final String userPhoneNumber;
  final String userName;

  User({
    required this.userID,
    required this.userPhoneNumber,
    required this.userName,
  });

  @override
  String toString() {
    return 'User{id: $userID, phoneNumber: $userPhoneNumber, name: $userName}';
  }
}

class FirebaseUser {
  final String uid;
  FirebaseUser({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String email;
  final String home;
  final String car;
  final List routine;

  UserData(
      {this.uid, this.name, this.email, this.home, this.car, this.routine});
}

class SessionController {
  static final SessionController _session = SessionController.internal();
  String? userID;
  String? userName;
  String? email;
  

  factory SessionController() {
    return _session;
  }
  SessionController.internal() {}
}

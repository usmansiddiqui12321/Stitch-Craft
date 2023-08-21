class Receipt {
  final String tailorName;
  final String tailorLocation;
  final String tailorEmail;
  final String username;
  final String userage;
  final String useremail;
  final String totalprice;
  final String userDetails;

  Receipt({
    required this.totalprice,

    required this.tailorName,
    required this.tailorLocation,
    required this.tailorEmail,
    required this.username,
    required this.userage,
    required this.useremail,
    required this.userDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'tailorname': tailorName,
      'tailorlocation': tailorLocation,
      'tailoremail': tailorEmail,
      'username': username,
      'userdetails': userDetails,
      'useremail': useremail,
      'userage': userage,
      'total'  : totalprice
    };
  }
}

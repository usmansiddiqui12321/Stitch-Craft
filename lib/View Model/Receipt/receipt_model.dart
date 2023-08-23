class Receipt {
  final String tailorName;
  final String tailorLocation;
  final String tailorEmail;
  final String username;
  final String userage;
  final String useremail;
  final int totalprice;
  final String address;
  final String userDetails;
  final double chest;
  final double waist;
  final double hips;
  final double neck;

  final double inseam;
  final double sleeveLength;
  Receipt({
    required this.totalprice,
    required this.chest,
    required this.neck,
    required this.waist,
    required this.hips,
    required this.inseam,
    required this.sleeveLength,
    required this.tailorName,
    required this.tailorLocation,
    required this.tailorEmail,
    required this.username,
    required this.userage,
    required this.address,
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
      'total': totalprice,
      'hips': hips,
      'sleeve': sleeveLength,
      'inseam': inseam,
      'neck': neck,
      'chest': chest,
      'waist': waist,
      'address':address
    };
  }
}

class Name {
  String use;
  String family;
  List<String> given;

  Name({
    required this.use,
    required this.family,
    required this.given,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      use: json['use'],
      family: json['family'],
      given: List<String>.from(json['given']),
    );
  }
}

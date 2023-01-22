class Disease {
  String id;
  String collectionId;
  String databaseId;
  String name;
  String about;
  List<dynamic> symptoms;
  List<dynamic> homeRemedies;
  List<dynamic> medications;
  String note;
  String imageURL;

  Disease(
      {required this.name,
      required this.about,
      required this.symptoms,
      required this.homeRemedies,
      required this.medications,
      required this.note,
      required this.databaseId,
      required this.id,
      required this.collectionId,
      required this.imageURL});

  factory Disease.empty() => Disease(
        id: '',
        databaseId: '',
        collectionId: '',
        name: '',
        about: '',
        homeRemedies: [],
        imageURL: 'assets/images/cold.png',
        medications: [],
        note: '',
        symptoms: [],
      );

  factory Disease.fromJson(Map<String, dynamic> json) => Disease(
      id: json["\$id"],
      databaseId: json["\$databaseId"],
      collectionId: json["\$collectionId"],
      name: json['data']['name'] ?? "",
      about: json['data']['about'] ?? "",
      symptoms: json['data']['symptoms'] ?? [],
      homeRemedies: json['data']['home_remedies'] ?? [],
      medications: json['data']['medications'] ?? [],
      note: json['data']['note'] ?? "",
      imageURL: json['data']['imageURL'] ?? "");

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'name': name,
        'about': about,
        'symptoms': symptoms,
        'home_remedies': homeRemedies,
        'medications': medications,
        'note': note,
        'imageURL': imageURL
      };

  @override
  String toString() {
    return "$name $medications";
  }
}

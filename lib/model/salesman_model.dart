class SalesmanModel {
  int? columId; 
  String name;
  String pass;
  String imgUrl;

  SalesmanModel({
    this.columId,
    required this.name,
    required this.pass,
    required this.imgUrl,
  });

  factory SalesmanModel.fromMap(Map<String, dynamic> map) {
    return SalesmanModel(
      columId: map['id'],
      name: map['name'],
      pass: map['pass'],
      imgUrl: map['imgUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'columId': columId, 
      'name': name,
      'pass': pass,
      'imgUrl': imgUrl,
    };
  }
}

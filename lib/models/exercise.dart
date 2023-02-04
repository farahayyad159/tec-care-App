class Exercise{
  late String id;
  late String description;
  late String name;
  late String urlVideo;
  late String muscleName;

  Exercise();
  Exercise.fromMap(Map<String, dynamic> documentMap){
    // id = documentMap['id'];
    description = documentMap['description'];
    name = documentMap['name'];
    urlVideo = documentMap['urlVideo'];
    muscleName = documentMap['muscleName'];
  }
  Map<String, dynamic> toMap(){
    Map<String,dynamic> map = <String,dynamic>{};
    map['description'] = description;
    map['name'] = name;
    map['urlVideo'] = urlVideo;
    map['muscleName'] = muscleName;
    return map;
  }

}
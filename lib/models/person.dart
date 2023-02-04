class Person{
  late String id;
  late String name;
  late String email;
  late String height;
  late String weight;
  // late DateTime dateOfBirth ;

  Person();
  Person.fromMap(Map<String, dynamic> documentMap){
    id = documentMap['id'];
    name = documentMap['name'];
    email = documentMap['email'];
    height = documentMap['height'];
    weight = documentMap['weight'];
    // dateOfBirth = documentMap['dateOfBirth'];
  }
  Map<String, dynamic> toMap(){
    Map<String,dynamic> map = <String,dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['height'] = height;
    map['weight'] = weight;
    // map['dateOfBirth'] = dateOfBirth;
    return map;
  }
}
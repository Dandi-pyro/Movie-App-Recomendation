class Users {
  String? id;
  String? name;
  String? email;
  String? password;
  List? movieWatch;
  List? movieDropped;
  List? movieFinish;

  Users(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.movieWatch,
      this.movieDropped,
      this.movieFinish});

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'name': name,
  //       'email': email,
  //       'password': password,
  //     };

  // static Users fromJson(Map<String, dynamic> json) => Users(
  //       id: json['id'],
  //       name: json['name'],
  //       email: json['email'],
  //       password: json['password'],
  //     );
  factory Users.fromMap(map) {
    return Users(
        id: map['id'],
        email: map['email'],
        name: map['name'],
        password: map['password'],
        movieWatch: map['movieWatch'],
        movieDropped: map['movieDropped'],
        movieFinish: map['movieFinish']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'movieWatch': movieWatch,
      'movieDropped': movieDropped,
      'movieFinish': movieFinish
    };
  }
}

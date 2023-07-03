class UserAuth extends NewUserDTO {
  String id;
  String token;
  String tokenType;

  factory UserAuth(Map jsonMap) {
    return UserAuth._internalFromJson(jsonMap);
  }

  UserAuth._internalFromJson(Map jsonMap)
      : id = jsonMap['user']['id'],
        token = jsonMap['access_token'],
        tokenType = jsonMap['token_type'],
        super(
          username: jsonMap['user']['username'],
          email: jsonMap['user']['email'],
          name: jsonMap['user']['name'],
          lastname: jsonMap['user']['lastname'],
          secondLastname: jsonMap['user']['second_lastname'],
        );
}

class NewUserDTO {
  String username;
  String email;
  String name;
  String? lastname;
  String? secondLastname;
  static String? password;

  void set pass(String pass) {
    password = pass;
  }

  NewUserDTO({
    required this.username,
    required this.email,
    required this.name,
    this.lastname,
    this.secondLastname,
  });

  toMap() {
    return {
      'username': username,
      'email': email,
      'name': name,
      'lastname': lastname,
      'second_lastname': secondLastname,
      'password': password,
    };
  }
}

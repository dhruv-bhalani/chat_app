class UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String password;
  String image;
  String token;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.image,
    required this.token,
  });

  factory UserModel.fromMap({required Map<String, dynamic> data}) => UserModel(
        uid: data['uid'],
        name: data['name'],
        email: data['email'],
        phone: data['phone'],
        password: data['password'],
        image: data['image'],
        token: data['token'],
      );

  Map<String, dynamic> get toMap => {
        'uid': uid,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'image': image,
        'token': token,
      };
}

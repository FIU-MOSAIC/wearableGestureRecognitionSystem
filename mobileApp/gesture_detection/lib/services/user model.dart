class UserModel {
  String? name;
  String? age;
  String? weight;
  String? gender;
  String? feet;
  String? inches;
  String? impairment;
  String? email;

  UserModel({
    this.name,
    this.age,
    this.weight,
    this.gender,
    this.feet,
    this.inches,
    this.impairment,
    this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'],
      age: data['age'],
      weight: data['weight'],
      gender: data['gender'],
      feet: data['ft'],
      inches: data['in'],
      impairment: data['impairment'],
      email: data['email'],
    );
  }
}

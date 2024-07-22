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

  // factory constructor to create a usermodel instance from a map
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'], // assign name from map
      age: data['age'], // assign age from map
      weight: data['weight'], // assign weight from map
      gender: data['gender'], // assign gender from map
      feet: data['ft'], // assign feet from map
      inches: data['in'], // assign inches from map
      impairment: data['impairment'], // assign impairment from map
      email: data['email'], // assign email from map
    );
  }
}

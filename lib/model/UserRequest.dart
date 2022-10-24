class UserRequest {

  String email;
  String password;
  String firstName,lastName;
  String? country, countryCode;
  late String birthdate,phoneNum,phoneSeparated,countrydialcode;



  UserRequest(
      this.birthdate,this.phoneNum,this.phoneSeparated,this.countrydialcode,
      {
        this.country,
        this.countryCode,
        required this.email,
        required this.password,
        required this.firstName,
        required this.lastName
      }
      ); // now create converter


}


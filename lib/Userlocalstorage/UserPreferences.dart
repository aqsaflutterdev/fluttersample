
import 'package:practiceflutter/domain/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

initializePreferences() async {
  prefs = await SharedPreferences.getInstance();
}
class UserPreferences{
  Future<User> getUser() async {
    print("getUser");
    String? email = prefs.getString("email");
    String? pass = prefs.getString("password");
    String? firstname = prefs.getString("firstname");
    String? lastname = prefs.getString('lastname');
    String? phoneno = prefs.getString('phoneno');
    String? uservatar = prefs.getString("useravatar");
    String? phoneseparated = prefs.getString("phoneseparated");
    String? avatarpath = prefs.getString("avatar_path");
    String? currency = prefs.getString('currency');
    String? countrycode = prefs.getString('country_code');
    String? token = prefs.getString("token");
    String? userName = prefs.getString("username");
    int? orgID = prefs.getInt("organization_id");
    int? field_officer_id = prefs.getInt("field_officer_id");
    String? control_room_number = prefs.getString("control_room_number");

    return User(
      token: token!,
      email: email!,
      firstname: firstname!,
      avatar: uservatar!,
      lastname: lastname!,
      phonenumber: phoneno!,
      phoneseparated: phoneseparated,
      avatarpath: avatarpath,
      currency: currency!,
      country_code: countrycode!,
      password: pass!,
      organizationID: orgID,
      control_room_number: control_room_number,
      username: userName!,
      siteID: prefs.getInt("site_id"),
      clientID: prefs.getInt("client_id"),
      field_officer_id: field_officer_id,
    );
    // String user = prefs.getString('user')!;
    // return User.fromJson(json.decode(user));
  }
  static String get baseUrl =>
      prefs.getString("baseUrl") ??
          'https://solo.novusguard.co.uk/api/fofficer';

  static set baseUrl(String baseUrl) {
    prefs.setString("baseUrl", baseUrl);
  }

  static getToken() {
    //  final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    return token!;
  }
}
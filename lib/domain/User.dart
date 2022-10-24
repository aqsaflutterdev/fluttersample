

class User{

  int? field_officer_id, organizationID, siteID, clientID;
  String? token, email, username, password, firstname, lastname, phonenumber, currency, country_code;
  String? phoneseparated, avatarpath, avatar, twitterIntegration, control_room_number,safe_pin,duress_pin;

  User(
  {
    required this.token,
    required this.email,
    required this.password,
    this.organizationID,
    this.clientID,
    this.siteID,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phonenumber,
    required this.currency,
    required this.avatar,
    required this.phoneseparated,
    required this.avatarpath,
    this.field_officer_id,
    required this.country_code,
    this.twitterIntegration,
    this.control_room_number,
    this.safe_pin,
    this.duress_pin
}
      );
  factory User.fromJson(Map<String, dynamic> responseData){
    return User(
        token: responseData['token'],
        field_officer_id: responseData['user']['field_officer_id'],
        email: responseData['user']['email'],
        password: responseData['user']['password'],
        organizationID: responseData['user']['miscDetail']['officer_organisations'][0]['officer_data']['organisation_id'],
        siteID: responseData['user']['miscDetail']['officer_organisations'][0]['clients'][0]['sites'][0]['site_id'],
        clientID: responseData['user']['miscDetail']['officer_organisations'][0]['clients'][0]['client_id'],
        username: responseData['user']['name'],
        firstname: responseData['user']['first_name'],
        lastname: responseData['user']['last_name'] == null ? "" : responseData['user']['last_name'],
        phonenumber: responseData['user']['phone'],
        phoneseparated: responseData['user']['phone_separated'],
        country_code: responseData['user']['country_code'],
        twitterIntegration: (responseData['user']['twitter'] == null) ? "off" : responseData['user']['twitter']['enable'],
        avatar: responseData['user']['avatar'] == null ? '' : responseData['user']['avatar'],
        avatarpath: responseData['avatar_path'],
        currency: responseData['general_settings']['currency_symbol'],
        control_room_number: responseData['user']['miscDetail']['officer_organisations'][0]['control_room_number'],
        safe_pin: responseData['user']['safe_pin'] ,
        duress_pin: responseData['user']['duress_pin']
    );
  }


}
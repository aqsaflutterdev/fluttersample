import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:practiceflutter/providers/UserProvider.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late UserProvider userProvider;
  String? fcmToken = '';
  firebaseToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    fcmToken = await messaging.getToken();
    print("firebase token is \t $fcmToken");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProvider= Provider.of<UserProvider>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    firebaseToken();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,

      ),
      body: Center(
        child: Text("Login Screen"),
      ),
    );
  }


}

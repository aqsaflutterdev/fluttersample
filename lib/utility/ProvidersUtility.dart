import 'package:flutter/cupertino.dart';
import 'package:practiceflutter/providers/UserProvider.dart';
import 'package:practiceflutter/utility/TopVariables.dart';
import 'package:provider/provider.dart';

class ProvidersUtility{
  static BuildContext? providersContext = TopVariables.appNavigationKey.currentContext;
  static UserProvider? userProvider = Provider.of<UserProvider>(providersContext!, listen: false);
  // static SessionProvider? sessionProvider = Provider.of<SessionProvider>(providersContext!, listen: false);
  // static VehicleProvider? vehicleProvider = Provider.of<VehicleProvider>(providersContext!, listen: false);
  // static SubscriptionProvider? subscriptionProvider = Provider.of<SubscriptionProvider>(providersContext!, listen: false);

}
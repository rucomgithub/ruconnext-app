import 'package:th.ac.ru.uSmart/model/homelist.dart';

// Define user roles
enum UserRole { Guest, Bachelor, Master, Doctor }

// Define access control
class AccessControl {
  final UserRole userRole;

  AccessControl(this.userRole);

  // Define button items with access rules and destination pages
  List<HomeList> getButtonItems() {
    List<HomeList> buttonItems = HomeList.homeList;

    // Filter button items based on user role
    return buttonItems.where((item) => item.roles!.contains(userRole)).toList();
  }

  static UserRole Role(String role) {
    final UserRole userRole;
    switch (role) {
      case "Doctor":
        userRole = UserRole.Doctor;
        break;
      case "Master":
        userRole = UserRole.Master;
        break;
      case "Bachelor":
        userRole = UserRole.Bachelor;
        break;
      default:
        userRole = UserRole.Guest;
        break;
    }
    return userRole;
  }
}

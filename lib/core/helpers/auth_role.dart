import '../services/debug/debug_service.dart';
import '../services/app_pigeon/app_pigeon.dart';

enum AccountType {
  provider("provider"), user("user"), unknown("");
  final String label;

  const AccountType(this.label);

  
  factory AccountType.fromString(String name) {
    switch (name) {
      case "provider":
        return AccountType.provider;
      case "user":
        return AccountType.user;
      default:
        return AccountType.unknown;
    }
  }
}

extension ExtraAuth on Auth {
  String get userId => data["userId"];
  AccountType get accountType {
    try {
      if(data["role"] == null) return AccountType.unknown;
        AuthDebugger().dekhao("has role");
        switch (data["role"]) {
          case "provider":
            return AccountType.provider;
          case "user":
            return AccountType.user;
          default:
            return AccountType.unknown;
        }
    } catch (e) {
      return AccountType.unknown;
    }
  }
}
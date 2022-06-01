import 'package:http/http.dart' as http;

class UserResult{
  String id;
  String email;
  String role;
  
  UserResult({
    required this.id,
    required this.email,
    required this.role
  });
}
import 'package:encrypt_shared_preferences/provider.dart';

class CacheManager {
  var sharedPref = EncryptedSharedPreferences.getInstance();
  var testToken = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI3MDM2NDI0MDE4NTY2NjU3NyIsInR5cGUiOiJwb3MudGVybWluYWwiLCJjb25uIjoxMjIwNjAwMjI0NDEsImlhdCI6MTcxOTgzNjU5MH0.tuYFNe0Wr5dFH3byoUz0Rqre5gFgT0yDVhq3dzQ6OMHps7oONh8JRSO2b3a4qLezlixl3e1lDPYTFHxe8wjYrA';
  
  Future<void> updateToken(String? token) async {
    if(token == null) {
        return;
    }
    await sharedPref.setString('token', token);
  }

  String? getToken() {
      return sharedPref.getString('token');
  }

}
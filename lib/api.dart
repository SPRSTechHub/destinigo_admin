import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future loginUser(String mobileno) async {
  Map<String, String> param = {'mobile': mobileno};
  final response = await http.post(
    Uri.parse('https://play.liveipl.online/play/gen_link/'),
    headers: <String, String>{
      /*'Content-Type': 'application/json; charset=UTF-8',*/
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: param,
  );

  // ignore: non_constant_identifier_names
  var ResponseMsg = jsonDecode(response.body);
  return ResponseMsg;
}

jsonString(Map<String, String> map) {}

Future sendEmail(String fullname, String email) async {
  Map<String, String> headers = {
    "Content-type": "application/x-www-form-urlencoded"
  };
  var json_body = {'email': email, 'fullname': fullname, 'action': 'send_mail'};
  final response = await http.post(
      Uri.parse('https://control.destinigo.co.in/api/'),
      headers: headers,
      body: json_body);
  if (response.statusCode == 200) {
    var ResponseMsg = jsonDecode(response.body);
    return ResponseMsg;
  } else {
    throw Exception(response.body);
  }
}
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService{
  Future<Map<String,dynamic>> postApi({
    required String url,
    required Map<String,dynamic> body
  })async{
    try{
      final response = await http.post(
        Uri.parse(url),
        headers:{
          "Content-Type":"application/json"
        },
        body: jsonEncode(body)
      );
      return jsonDecode(response.body);
    }catch(e){
      return {
        "status":false,
        "message":e.toString()
      };

    }
  }
}
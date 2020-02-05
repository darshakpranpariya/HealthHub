import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:requests/requests.dart';

Future Getdata(String text) async {
    try {
      //http.Response response = await http.get(url);
      http.Response response = await http.post(Uri.encodeFull("https://bern.korea.ac.kr/plain"), body:{"sample_text":text});
      //print(json.decode(response.body));
        return(json.decode(response.body));
    } catch (error) {
      print(error);
    }
  }
//   Future<Post> Getdata(String url, {Map body}) async {
//   return http.post(url, body: body).then((http.Response response) {
//     final int statusCode = response.statusCode;
 
//     if (statusCode < 200 || statusCode > 400 || json == null) {
//       throw new Exception("Error while fetching data");
//     }
//     return Post.fromJson(json.decode(response.body));
//   });
// }
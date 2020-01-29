import 'package:http/http.dart' as http;

Future Getdata(String url) async {
    try {
      http.Response response = await http.get(url);
      print(response.body);
        return(response.body);
    } catch (error) {
      print(error);
    }
  }
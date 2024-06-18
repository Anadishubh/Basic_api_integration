import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api/model.dart';

class InstagramData {
  Future<List<InstagramPost>> fetchPosts() async {
    final response = await http.get(Uri.parse(
        'https://graph.instagram.com/me/media?fields=id,caption,media_url,media_type,timestamp,children%7Bmedia_url%7D&access_token=IGQWRQV1RjQTVsRVNEMzlLWEtwSmJyZAmJHR3B5amVpTGtrYlZAyMllXQ3RTakhfQW5XYWVMRkxTWWxEZAmhHNUNDdzhaeFNTbGRrdE4wc3MyQTNJLVZANVzQ2eHZAxRFh6c0NxX0xGa3BNYkZArelZAhRE1DdDJEcXhZASWcZD'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => InstagramPost.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load the data');
    }
  }
}

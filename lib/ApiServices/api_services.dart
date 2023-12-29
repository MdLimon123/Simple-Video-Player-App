import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_video_player_app/ApiServices/api_component.dart';
import 'package:simple_video_player_app/View/HomeScreen/Model/video_model.dart';

class ApiServices {
  static var client = http.Client();

  static dynamic fetchVideo() async {
    try {
      final response = await client.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        return VideoModel.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
      } else {
        return response.statusCode;
      }
    } on Exception catch (e) {
      debugPrint('Video Fetch Error ${e.toString()}');
    }
  }
}

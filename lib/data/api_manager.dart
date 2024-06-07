import 'dart:convert';

import 'package:http/http.dart';

import 'model/quote_generate_model.dart';

class ApiManager {
  static String baseUrl = "https://zenquotes.io/api/";
  static Future<QuoteGenerateModel> fetchRandomQuote() async{
    Response response = await get(Uri.parse("${baseUrl}random"));
    if(response.statusCode >= 200 && response.statusCode < 300) {
      final data = json.decode(response.body);
      return QuoteGenerateModel.fromJson(data[0]);
    }else {
      throw Exception("Failed to generate quote");
    }
}
}
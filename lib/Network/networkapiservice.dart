import 'dart:convert';
import 'package:tourism/Network/ApiResponse.dart';
import 'package:tourism/Network/Status.dart';
import 'package:tourism/Network/baseAPIservice.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {
  Future<ApiResponse> login(String phoneNumber, String flag, String url) async {
    try {
      // Send a request to your backend
      var body = json.encode({
        'phone_number': phoneNumber,
        'flag': flag,
      });
      print("224 ${baseUrl + url}");
      final response = await http.post(
        Uri.parse(baseUrl + url),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json",
          'Accept': '/',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print("response:$response");
        return ApiResponse(Status.COMPLETED, response.body, "");

        // Navigate to the homepage or OTP verification page
      } else {
        print("response.statusCode:${response.statusCode}");
        return ApiResponse(Status.ERROR, response.statusCode, "");
      }
    } catch (e) {
      // Handle network error
      print("ttt$e");
      return ApiResponse(Status.COMPLETED, e.toString(), "");
    }
  }
   Future<ApiResponse> verify(String phoneNumber, String flag, String password, String otp, String url) async {
    try {
      // Send a request to your backend
      var body = json.encode({
        'phone_number': phoneNumber,
        'flag': flag,
        'password':password,
        'otp': otp,

      });

      print("2244 ${baseUrl + url}");
      final response = await http.post(
        Uri.parse(baseUrl + url),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json",
          'Accept': '/',
        },
        body: body,
      );

     if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var token = jsonResponse['data']['token'];
        print("OTP verification response: $response");
        return ApiResponse(Status.COMPLETED, token, "");
      }
     else {
        print("OTP verification failed with status code: ${response.statusCode}");
        return ApiResponse(Status.ERROR, response.statusCode, "");
      }
    } catch (e) {
      print("Error during OTP verification: $e");
      return ApiResponse(Status.COMPLETED, e.toString(), "");
    }
  }
   Future<ApiResponse> registerUserPersonalInfos(String firstName, String lastName, String birthday, String gender, String email, String url) async {
    try {
      // Send a request to your backend
      var body = json.encode({
        'first_name': firstName,
        'last_name': lastName,
        'birth_day': birthday,
        'gender': gender,
        'email': email,
      });

      print("Registering user: ${baseUrl + url}");
      final response = await http.post(
        Uri.parse(baseUrl + url),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json",
          'Accept': '/',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        // Handle successful response
        var jsonResponse = json.decode(response.body);
        print("Registration response: $jsonResponse");
        return ApiResponse(Status.COMPLETED, jsonResponse, "");
      } else {
        print("Registration failed with status code: ${response.statusCode}");
        return ApiResponse(Status.ERROR, response.statusCode, "");
      }
    } catch (e) {
      // Handle network error
      print("Error during registration: $e");
      return ApiResponse(Status.ERROR, e.toString(), "");
    }
  }
  Future<List<String>> fetchLogos() async {
    final response = await http.get(Uri.parse('${baseUrl}api/Brands/getAllBrandsForUser'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final logos = (data['data'] as List).map((item) => item['logo'] as String).toList();
      return logos;
    } else {
      throw Exception('Failed to load logos');
    }
  }
}
  


  
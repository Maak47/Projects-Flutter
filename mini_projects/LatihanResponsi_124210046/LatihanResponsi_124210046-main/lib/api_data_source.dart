import 'package:latihan_responsi/base_network.dart';
import 'package:latihan_responsi/reportsmodel.dart';

import 'blog_model.dart';

class ApiDataSource {
  static final ApiDataSource instance = ApiDataSource._privateConstructor();

  ApiDataSource._privateConstructor();

  Future<dynamic> loadData(String path) async {
    try {
      final response = await BaseNetwork.get(path);
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<List<BlogModel>> loadBlogs(String path) async {
    try {
      final response = await BaseNetwork.get(path);
      return _processResponse(response);
    } catch (error) {
      throw error;
    }
  }

  List<BlogModel> _processResponse(Map<String, dynamic> response) {
    try {
      print("API Response: $response"); // Add this line for debugging
      final List<dynamic> jsonList = response['results'];
      return jsonList
          .map((dynamic e) => BlogModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print("Error processing response: $error");
      throw error;
    }
  }

  Future<List<BlogModel>> loadReports(String path) async {
    try {
      final response = await BaseNetwork.get(path);
      return _processResponse(response);
    } catch (error) {
      throw error;
    }
  }

  List<ReportsModel> _processReportResponse(Map<String, dynamic> response) {
    try {
      print("API Response: $response"); // Add this line for debugging
      final List<dynamic> jsonList = response['results'];
      return jsonList
          .map((dynamic e) => ReportsModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print("Error processing response: $error");
      throw error;
    }
  }
}

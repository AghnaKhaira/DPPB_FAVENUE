import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/developer_model.dart';
import '../models/umkm_model.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class ApiService {
  // ==================== DEVELOPERS ====================
  
  /// Fetch semua developer dengan optional filter
  static Future<List<Developer>> getDevelopers({
    String? category,
    String? search,
  }) async {
    try {
      String url = '${AppConstants.baseUrl}/developers';
      
      // Build query parameters
      Map<String, String> params = {};
      if (category != null && category != 'Semua') {
        params['category'] = category;
      }
      if (search != null && search.isNotEmpty) {
        params['search'] = search;
      }

      final uri = Uri.parse(url).replace(queryParameters: params.isNotEmpty ? params : null);
      
      final response = await http.get(uri).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Developer.fromJson(item)).toList();
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load developers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching developers: $e');
    }
  }

  /// Fetch developer berdasarkan ID
  static Future<Developer> getDeveloperById(String id) async {
    try {
      final response = await http
          .get(Uri.parse('${AppConstants.baseUrl}/developers/$id'))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response.statusCode == 200) {
        return Developer.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load developer: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching developer: $e');
    }
  }

  // ==================== UMKM ====================

  /// Fetch semua UMKM dengan optional filter
  static Future<List<UMKM>> getUMKM({
    String? category,
    String? search,
    String? location,
  }) async {
    try {
      String url = '${AppConstants.baseUrl}/umkm';
      
      // Build query parameters
      Map<String, String> params = {};
      if (category != null && category != 'Semua') {
        params['category'] = category;
      }
      if (search != null && search.isNotEmpty) {
        params['search'] = search;
      }
      if (location != null && location.isNotEmpty) {
        params['location'] = location;
      }

      final uri = Uri.parse(url).replace(queryParameters: params.isNotEmpty ? params : null);
      
      final response = await http.get(uri).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => UMKM.fromJson(item)).toList();
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load UMKM: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching UMKM: $e');
    }
  }

  /// Fetch UMKM berdasarkan ID
  static Future<UMKM> getUMKMById(String id) async {
    try {
      final response = await http
          .get(Uri.parse('${AppConstants.baseUrl}/umkm/$id'))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response.statusCode == 200) {
        return UMKM.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load UMKM: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching UMKM: $e');
    }
  }

  // ==================== AUTHENTICATION ====================

  /// Register user baru
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String role, // 'developer' atau 'umkm'
    required String phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'role': role,
          'phone': phone,
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Registration failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error registering: $e');
    }
  }

  /// Login user
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('Email atau password salah');
      } else {
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }

  // ==================== USER PROFILE ====================

  /// Fetch user profile
  static Future<User> getUserProfile(String userId) async {
    try {
      final response = await http
          .get(Uri.parse('${AppConstants.baseUrl}/users/$userId'))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching profile: $e');
    }
  }

  /// Update user profile
  static Future<User> updateUserProfile({
    required String userId,
    required Map<String, dynamic> data,
    required String token,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('${AppConstants.baseUrl}/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }

  // ==================== MESSAGES ====================

  /// Fetch messages untuk user
  static Future<List<Map<String, dynamic>>> getMessages(
    String userId,
    String token,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}/messages/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load messages: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching messages: $e');
    }
  }

  /// Send message
  static Future<Map<String, dynamic>> sendMessage({
    required String senderId,
    required String recipientId,
    required String message,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/messages'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'sender_id': senderId,
          'recipient_id': recipientId,
          'message': message,
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }

  // ==================== RATINGS & REVIEWS ====================

  /// Add rating untuk developer/UMKM
  static Future<Map<String, dynamic>> addRating({
    required String targetId,
    required String targetType, // 'developer' atau 'umkm'
    required double rating,
    required String review,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/ratings'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'target_id': targetId,
          'target_type': targetType,
          'rating': rating,
          'review': review,
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to add rating: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding rating: $e');
    }
  }

  /// Get ratings untuk developer/UMKM
  static Future<List<Map<String, dynamic>>> getRatings(
    String targetId,
    String targetType,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}/ratings/$targetType/$targetId'),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load ratings: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching ratings: $e');
    }
  }

  // ==================== PROJECTS/ORDERS ====================

  /// Create project/order
  static Future<Map<String, dynamic>> createProject({
    required String clientId,
    required String developerId,
    required String title,
    required String description,
    required String budget,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/projects'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'client_id': clientId,
          'developer_id': developerId,
          'title': title,
          'description': description,
          'budget': budget,
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create project: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating project: $e');
    }
  }

  /// Get user projects
  static Future<List<Map<String, dynamic>>> getUserProjects(
    String userId,
    String token,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}/projects/user/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load projects: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching projects: $e');
    }
  }
}

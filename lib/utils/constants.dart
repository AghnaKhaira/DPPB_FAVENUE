class AppConstants {
  // API Base URL - ubah sesuai backend Anda
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // Navigation Routes
  static const String homeRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String developerListRoute = '/developers';
  static const String developerDetailRoute = '/developer-detail';
  static const String umkmListRoute = '/umkm';
  static const String umkmDetailRoute = '/umkm-detail';
  static const String dashboardRoute = '/dashboard';
  static const String profileRoute = '/profile';

  // Dummy Data
  static const List<String> categories = [
    'Web Development',
    'Mobile Development',
    'UI/UX Design',
    'Backend Development',
    'Full Stack',
  ];

  static const List<String> umkmCategories = [
    'Fashion',
    'Food & Beverage',
    'Handcraft',
    'Electronics',
    'Services',
  ];
}

// CONTOH INTEGRASI API KE SCREEN
// File ini menunjukkan cara mengintegrasikan API ke dalam screen

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import '../widgets/developer_card.dart';
import '../services/api_service.dart';
import '../models/developer_model.dart';

// ======================== CONTOH 1: DEVELOPER LIST DENGAN API ========================

class DeveloperListScreenWithAPI extends StatefulWidget {
  const DeveloperListScreenWithAPI({Key? key}) : super(key: key);

  @override
  State<DeveloperListScreenWithAPI> createState() => _DeveloperListScreenWithAPIState();
}

class _DeveloperListScreenWithAPIState extends State<DeveloperListScreenWithAPI> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Semua';
  late Future<List<Developer>> _developersFuture;

  final List<String> categories = [
    'Semua',
    'Web Development',
    'Mobile Development',
    'UI/UX Design',
    'Backend',
    'Full Stack'
  ];

  @override
  void initState() {
    super.initState();
    _developersFuture = ApiService.getDevelopers();
  }

  void _onSearch(String query) {
    setState(() {
      String category = _selectedCategory == 'Semua' ? '' : _selectedCategory;
      _developersFuture = ApiService.getDevelopers(
        category: category.isEmpty ? null : category,
        search: query.isEmpty ? null : query,
      );
    });
  }

  void _onCategoryChange(String category) {
    setState(() {
      _selectedCategory = category;
      _onSearch(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cari Developer',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.secondaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  hintText: 'Cari developer...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppTheme.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppTheme.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppTheme.accentColor, width: 2),
                  ),
                ),
              ),
            ),

            // Category Filter
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kategori',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = _selectedCategory == category;
                        return Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              _onCategoryChange(category);
                            },
                            backgroundColor: Colors.white,
                            selectedColor: AppTheme.accentColor,
                            side: BorderSide(
                              color: isSelected
                                  ? AppTheme.accentColor
                                  : AppTheme.borderColor,
                            ),
                            labelStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Developer List dengan FutureBuilder
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: FutureBuilder<List<Developer>>(
                future: _developersFuture,
                builder: (context, snapshot) {
                  // Loading State
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 400,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.accentColor,
                        ),
                      ),
                    );
                  }

                  // Error State
                  if (snapshot.hasError) {
                    return SizedBox(
                      height: 400,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, size: 48, color: Colors.red),
                            SizedBox(height: 16),
                            Text(
                              'Terjadi kesalahan',
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              snapshot.error.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _developersFuture = ApiService.getDevelopers();
                                });
                              },
                              child: Text('Coba Lagi'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // Empty State
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return SizedBox(
                      height: 400,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_search,
                              size: 48,
                              color: AppTheme.borderColor,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Tidak ada developer ditemukan',
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // Success State - Data Grid
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final developer = snapshot.data![index];
                      return DeveloperCard(
                        name: developer.name,
                        specialty: developer.specialty,
                        imageUrl: developer.imageUrl,
                        rating: developer.rating,
                        reviews: developer.reviews,
                        onTap: () {
                          // Navigate ke developer detail
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tapped: ${developer.name}'),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// ======================== CONTOH 2: AUTHENTICATION SCREEN ========================

class LoginScreenExample extends StatefulWidget {
  const LoginScreenExample({Key? key}) : super(key: key);

  @override
  State<LoginScreenExample> createState() => _LoginScreenExampleState();
}

class _LoginScreenExampleState extends State<LoginScreenExample> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  void _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email dan password harus diisi')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await ApiService.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Simpan token ke shared preferences
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('token', result['token']);

      // Navigate ke home
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login berhasil!')),
        );
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login gagal: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: AppTheme.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Masuk ke Favenue',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Gunakan email dan password Anda',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: 32),

              // Email Field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),

              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 16),

              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Belum punya akun? '),
                  TextButton(
                    onPressed: () {
                      // Navigate ke register screen
                    },
                    child: Text(
                      'Daftar di sini',
                      style: GoogleFonts.poppins(
                        color: AppTheme.accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// ======================== CONTOH 3: FETCH DATA DENGAN ERROR HANDLING ========================

class SafeApiCall {
  /// Fetch data dengan error handling dan retry logic
  static Future<T?> fetch<T>({
    required Future<T> Function() apiCall,
    required BuildContext context,
    int maxRetries = 3,
  }) async {
    for (int i = 0; i < maxRetries; i++) {
      try {
        return await apiCall().timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw Exception('Request timeout'),
        );
      } catch (e) {
        if (i == maxRetries - 1) {
          // Last retry failed
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return null;
        }
        // Wait sebelum retry
        await Future.delayed(Duration(seconds: 2 * (i + 1)));
      }
    }
    return null;
  }
}

// ======================== CONTOH 4: PAGINATION ========================

class DeveloperListWithPagination extends StatefulWidget {
  const DeveloperListWithPagination({Key? key}) : super(key: key);

  @override
  State<DeveloperListWithPagination> createState() => _DeveloperListWithPaginationState();
}

class _DeveloperListWithPaginationState extends State<DeveloperListWithPagination> {
  final ScrollController _scrollController = ScrollController();
  List<Developer> _developers = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _loadMore();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_hasMoreData && !_isLoading) {
        _loadMore();
      }
    }
  }

  void _loadMore() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final newDevelopers = await ApiService.getDevelopers();
      setState(() {
        _developers.addAll(newDevelopers);
        _currentPage++;
        if (newDevelopers.isEmpty) {
          _hasMoreData = false;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _developers.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _developers.length) {
            return Center(child: CircularProgressIndicator());
          }
          final developer = _developers[index];
          return ListTile(
            title: Text(developer.name),
            subtitle: Text(developer.specialty),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

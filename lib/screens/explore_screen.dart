import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import '../widgets/custom_appbar.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedCategory = 'all';

  final List<Map<String, String>> features = [
    {
      'title': 'Jelajahi Developer',
      'description': 'Temukan developer berpengalaman dengan skill yang sesuai kebutuhan bisnis Anda',
      'icon': '👨‍💻',
    },
    {
      'title': 'Jelajahi UMKM',
      'description': 'Lihat berbagai UMKM yang sedang berkembang dan membutuhkan solusi digital',
      'icon': '🏪',
    },
    {
      'title': 'Lihat Project',
      'description': 'Pelajari portfolio project yang telah diselesaikan oleh developer di platform kami',
      'icon': '📁',
    },
    {
      'title': 'Kategori Layanan',
      'description': 'Telusuri berbagai kategori layanan yang tersedia di Favenue',
      'icon': '🔧',
    },
  ];

  final List<Map<String, String>> categories = [
    {
      'name': 'Web Development',
      'count': '256',
      'icon': '🌐',
    },
    {
      'name': 'Mobile App',
      'count': '189',
      'icon': '📱',
    },
    {
      'name': 'UI/UX Design',
      'count': '142',
      'icon': '🎨',
    },
    {
      'name': 'Backend Development',
      'count': '178',
      'icon': '⚙️',
    },
    {
      'name': 'E-Commerce',
      'count': '203',
      'icon': '🛍️',
    },
    {
      'name': 'Cloud Solutions',
      'count': '96',
      'icon': '☁️',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Jelajahi Favenue',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              color: AppTheme.secondaryColor,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'Jelajahi Favenue',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Temukan Developer dan Solusi Digital Terbaik untuk Bisnis Anda',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // Quick Access Cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: features.map((feature) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: _featureCard(
                      feature['icon']!,
                      feature['title']!,
                      feature['description']!,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 40),
            // Categories
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kategori Layanan Populer',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return _categoryCard(
                        category['icon']!,
                        category['name']!,
                        category['count']!,
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // Explore Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/developers');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondaryColor,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Cari Developer',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/umkm');
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppTheme.secondaryColor),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Jelajahi UMKM',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _featureCard(String icon, String title, String description) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            icon,
            style: TextStyle(fontSize: 32),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryCard(String icon, String name, String count) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            icon,
            style: TextStyle(fontSize: 36),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            '$count Developer',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppTheme.accentColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

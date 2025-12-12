import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import '../widgets/developer_card.dart';
import '../widgets/umkm_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;

  final List<String> banners = [
    'Selamat Datang di Favenue',
    'Kolaborasi UMKM & Developer',
    'Wujudkan Digitalisasi Toko Anda',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAVENUE',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.secondaryColor,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel Banner
            SizedBox(
              height: 200,
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    _carouselIndex = index;
                  });
                },
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        banners[index],
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            // Carousel Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: banners.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _carouselIndex == entry.key
                        ? AppTheme.primaryColor
                        : AppTheme.borderColor,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24),

            // Quick Access Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Akses Cepat',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _buildQuickAccessCard(
                        icon: Icons.code,
                        title: 'Cari Developer',
                        color: AppTheme.accentColor,
                        onTap: () {
                          Navigator.pushNamed(context, '/developers');
                        },
                      ),
                      _buildQuickAccessCard(
                        icon: Icons.store,
                        title: 'Jelajahi UMKM',
                        color: AppTheme.primaryColor,
                        onTap: () {
                          Navigator.pushNamed(context, '/umkm');
                        },
                      ),
                      _buildQuickAccessCard(
                        icon: Icons.dashboard,
                        title: 'Dashboard',
                        color: Colors.green,
                        onTap: () {
                          Navigator.pushNamed(context, '/dashboard');
                        },
                      ),
                      _buildQuickAccessCard(
                        icon: Icons.person,
                        title: 'Profil',
                        color: Colors.purple,
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Featured Developers Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Developer Terbaik',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/developers');
                        },
                        child: Text(
                          'Lihat Semua',
                          style: GoogleFonts.poppins(
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: SizedBox(
                            width: 160,
                            child: DeveloperCard(
                              name: 'Developer ${index + 1}',
                              specialty: 'Web Developer',
                              imageUrl: '',
                              rating: 4.5,
                              reviews: 12,
                              onTap: () {},
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Featured UMKM Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'UMKM Populer',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/umkm');
                        },
                        child: Text(
                          'Lihat Semua',
                          style: GoogleFonts.poppins(
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: SizedBox(
                            width: 160,
                            child: UMKMCard(
                              name: 'UMKM ${index + 1}',
                              category: 'Fashion',
                              imageUrl: '',
                              location: 'Jakarta',
                              rating: 4.8,
                              onTap: () {},
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(color: AppTheme.borderColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: color),
              SizedBox(height: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

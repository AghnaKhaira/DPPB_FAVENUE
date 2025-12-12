import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import 'about_screen.dart';
import 'explore_screen.dart';
import 'knowledge_screen.dart';
import 'contact_us_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentSlide = 0;

  final List<Map<String, String>> slides = [
    {
      'title': 'SELAMAT DATANG DI FAVENUE',
      'subtitle': 'Kolaborasi UMKM & Developer, Wujudkan Digitalisasi Toko Anda',
    },
    {
      'title': 'TRANSFORMASI DIGITAL',
      'subtitle': 'Bersama Developer Profesional untuk Bisnis Anda',
    },
    {
      'title': 'GROW YOUR BUSINESS',
      'subtitle': 'Skalakan Bisnis Anda dengan Teknologi Terkini',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: size.width <= 600 ? _buildMobileMenu() : null,
      body: Column(
        children: [
          // Header Navigation - Mobile
          if (size.width <= 600)
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => SizedBox(
                      width: 50,
                      child: IconButton(
                        icon: Icon(Icons.menu, color: AppTheme.secondaryColor, size: 32),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Favenue',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  SizedBox(width: 50),
                ],
              ),
            )
          else
            // Header Navigation - Desktop
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Favenue',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      _navItem('Home', onTap: () {}),
                      SizedBox(width: 30),
                      _navItem('About', onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
                      }),
                      SizedBox(width: 30),
                      _navItem('Explore', onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ExploreScreen()));
                      }),
                      SizedBox(width: 30),
                      _navItem('Knowledge', onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const KnowledgeScreen()));
                      }),
                      SizedBox(width: 30),
                      _navItem('Contact', onTap: () {}),
                    ],
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/umkm-role');
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppTheme.secondaryColor),
                        ),
                        child: Text(
                          'Umkm',
                          style: GoogleFonts.poppins(
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/developer-role');
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppTheme.secondaryColor),
                        ),
                        child: Text(
                          'Developer',
                          style: GoogleFonts.poppins(
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          // Mobile Auth Buttons
          if (size.width <= 600)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/umkm-role');
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppTheme.secondaryColor),
                      ),
                      child: Text(
                        'Umkm',
                        style: GoogleFonts.poppins(
                          color: AppTheme.secondaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/developer-role');
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppTheme.secondaryColor),
                      ),
                      child: Text(
                        'Developer',
                        style: GoogleFonts.poppins(
                          color: AppTheme.secondaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // Rest of the page
          Divider(height: 1),
          // Hero Section with Carousel
          Expanded(
            child: Stack(
              children: [
                // Background Image or Gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.secondaryColor,
                        AppTheme.secondaryColor.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        _currentSlide = index;
                      });
                    },
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      return _buildSlide(slides[index]);
                    },
                  ),
                ),
                // Indicators at bottom
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          slides.length,
                          (index) => Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentSlide == index
                                  ? AppTheme.primaryColor
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        icon: Icon(Icons.arrow_forward),
                        label: Text(
                          'Pelajari Lebih Lanjut',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide(Map<String, String> slide) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon placeholder
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
            child: Icon(
              Icons.domain,
              size: 60,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 40),
          Text(
            slide['title']!,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            slide['subtitle']!,
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _navItem(String title, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildMobileMenu() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor,
            ),
            child: Text(
              'Favenue Menu',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(
              'About',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.explore),
            title: Text(
              'Explore',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExploreScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text(
              'Knowledge',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const KnowledgeScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(
              'Contact Us',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUsScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.login),
            title: Text(
              'Login',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text(
              'Sign Up',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/register');
            },
          ),
        ],
      ),
    );
  }
}

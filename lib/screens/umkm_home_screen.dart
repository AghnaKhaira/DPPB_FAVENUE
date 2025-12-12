import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';

class UMKMHomeScreen extends StatefulWidget {
  const UMKMHomeScreen({Key? key}) : super(key: key);

  @override
  State<UMKMHomeScreen> createState() => _UMKMHomeScreenState();
}

class _UMKMHomeScreenState extends State<UMKMHomeScreen> {
  List<Map<String, dynamic>> availableDevelopers = [
    {
      'id': 1,
      'name': 'Budi Santoso',
      'specialty': 'Full Stack Developer',
      'rating': 4.8,
      'projects': 25,
      'price': 'Rp 500K - 1M/project'
    },
    {
      'id': 2,
      'name': 'Siti Nurhaliza',
      'specialty': 'Mobile App Developer',
      'rating': 4.9,
      'projects': 18,
      'price': 'Rp 400K - 800K/project'
    },
    {
      'id': 3,
      'name': 'Ahmad Hidayat',
      'specialty': 'UI/UX Designer',
      'rating': 4.7,
      'projects': 32,
      'price': 'Rp 300K - 600K/project'
    },
  ];

  List<Map<String, dynamic>> myProjects = [
    {
      'id': 101,
      'title': 'Website Toko Online',
      'status': 'In Progress',
      'developer': 'Budi Santoso',
      'progress': 60,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: Text(
          'UMKM Marketplace',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.1),
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Welcome Card
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, Color(0xFFFCD34D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat datang di Marketplace UMKM!',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Temukan developer terbaik untuk mengembangkan bisnis Anda',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // Available Developers Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Developer Tersedia',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: availableDevelopers.length,
                    itemBuilder: (context, index) {
                      final dev = availableDevelopers[index];
                      return _buildDeveloperCard(dev);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // My Projects Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Proyek Saya',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: myProjects.length,
                    itemBuilder: (context, index) {
                      final project = myProjects[index];
                      return _buildProjectCard(project);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Logout Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperCard(Map<String, dynamic> dev) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.accentColor,
                  child: Icon(Icons.code, color: Colors.white),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dev['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        dev['specialty'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      dev['rating'].toString(),
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${dev['projects']} projects',
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
                Text(
                  dev['price'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.accentColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project['title'],
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Developer: ${project['developer']}',
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: project['status'] == 'In Progress'
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    project['status'],
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: project['status'] == 'In Progress'
                          ? Colors.blue
                          : Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: project['progress'] / 100,
                minHeight: 6,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.green,
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${project['progress']}% Complete',
              style: GoogleFonts.poppins(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

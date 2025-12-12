import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import '../widgets/custom_appbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tentang Favenue',
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
                    'Tentang FavenueKu',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Platform Kolaborasi UMKM & Developer untuk Transformasi Digital',
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
            // Mission
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Misi Kami',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Kami berkomitmen untuk memberdayakan UMKM Indonesia melalui solusi digital yang inovatif dan terjangkau. Dengan menghubungkan UMKM dengan developer berbakat, kami membantu mengakselerasi transformasi digital bisnis Anda.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // Vision
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visi Kami',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Menjadi platform terdepan dalam ekosistem digital UMKM di Asia Tenggara, menciptakan peluang pertumbuhan yang berkelanjutan untuk setiap UMKM dan developer yang bergabung dengan kami.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // Why Choose Us
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mengapa Memilih Favenue?',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  _featureItem('✓ Solusi Digital Terpercaya', 'Platform yang aman dan terpercaya untuk transformasi bisnis Anda'),
                  SizedBox(height: 12),
                  _featureItem('✓ Developer Profesional', 'Ribuan developer bersertifikat siap mewujudkan ide bisnis Anda'),
                  SizedBox(height: 12),
                  _featureItem('✓ Harga Terjangkau', 'Paket solusi yang kompetitif dan fleksibel sesuai kebutuhan'),
                  SizedBox(height: 12),
                  _featureItem('✓ Dukungan 24/7', 'Tim support kami siap membantu setiap pertanyaan Anda'),
                ],
              ),
            ),
            SizedBox(height: 40),
            // Contact CTA
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Mengarahkan ke halaman kontak...')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                ),
                child: Text(
                  'Hubungi Kami',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _featureItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
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
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

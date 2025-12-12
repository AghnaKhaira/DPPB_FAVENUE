import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import '../widgets/custom_appbar.dart';

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({Key? key}) : super(key: key);

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  String _selectedCategory = 'all';

  final List<Map<String, String>> articles = [
    {
      'title': 'Panduan Transformasi Digital untuk UMKM',
      'category': 'Guide',
      'author': 'Tim Favenue',
      'date': '10 Des 2024',
      'description': 'Langkah-langkah praktis untuk memulai transformasi digital bisnis Anda dari nol.',
    },
    {
      'title': '5 Tren Web Development 2025',
      'category': 'Technology',
      'author': 'Dev Team',
      'date': '8 Des 2024',
      'description': 'Pelajari teknologi terbaru dan trend yang akan mendominasi di 2025.',
    },
    {
      'title': 'Cara Memilih Developer yang Tepat',
      'category': 'Guide',
      'author': 'Tim Support',
      'date': '5 Des 2024',
      'description': 'Tips dan trik memilih developer yang sesuai dengan kebutuhan dan budget Anda.',
    },
    {
      'title': 'Keamanan Website: Best Practices',
      'category': 'Security',
      'author': 'Security Team',
      'date': '3 Des 2024',
      'description': 'Panduan lengkap untuk menjaga keamanan website dan data pelanggan Anda.',
    },
    {
      'title': 'Monetisasi Aplikasi Mobile Anda',
      'category': 'Business',
      'author': 'Business Team',
      'date': '1 Des 2024',
      'description': 'Strategi efektif untuk menghasilkan revenue dari aplikasi mobile Anda.',
    },
    {
      'title': 'Introduction to Cloud Computing',
      'category': 'Technology',
      'author': 'Tech Writer',
      'date': '28 Nov 2024',
      'description': 'Pemahaman dasar tentang cloud computing dan manfaatnya untuk bisnis.',
    },
  ];

  final List<String> categories = ['all', 'Guide', 'Technology', 'Business', 'Security'];

  @override
  Widget build(BuildContext context) {
    final filteredArticles = _selectedCategory == 'all'
        ? articles
        : articles.where((article) => article['category'] == _selectedCategory).toList();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Knowledge Base',
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
                    'Pusat Pengetahuan Favenue',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Artikel, panduan, dan tips untuk memaksimalkan potensi bisnis digital Anda',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari artikel...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),
            SizedBox(height: 24),
            // Category Filter
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        category == 'all' ? 'Semua' : category,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                      backgroundColor: isSelected ? AppTheme.secondaryColor : Colors.grey[200],
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 24),
            // Articles List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: filteredArticles.map((article) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: _articleCard(article),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _articleCard(Map<String, String> article) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  article['category']!,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.secondaryColor,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                article['date']!,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            article['title']!,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),
          Text(
            article['description']!,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Oleh ${article['author']!}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Membuka artikel: ${article['title']}')),
                  );
                },
                child: Text(
                  'Baca Selengkapnya →',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.secondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

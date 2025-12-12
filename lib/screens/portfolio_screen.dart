import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _techStackController = TextEditingController();

  List<Map<String, dynamic>> portfolios = [
    {
      'id': 1,
      'projectName': 'E-Commerce Platform',
      'description': 'Platform e-commerce dengan fitur pembayaran dan inventory management',
      'url': 'www.ecommerce-demo.com',
      'techStack': 'Flutter, Firebase, Stripe',
      'year': '2024',
    },
    {
      'id': 2,
      'projectName': 'Task Management App',
      'description': 'Aplikasi manajemen tugas dengan notifikasi real-time',
      'url': 'www.taskapp-demo.com',
      'techStack': 'Flutter, Node.js, MongoDB',
      'year': '2024',
    },
    {
      'id': 3,
      'projectName': 'Social Media App',
      'description': 'Aplikasi media sosial dengan fitur messaging dan notifications',
      'url': 'www.socialmedia-demo.com',
      'techStack': 'Flutter, Firebase, Realtime Database',
      'year': '2023',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: AppTheme.secondaryColor,
        elevation: 0,
        title: Text(
          'Portfolio Saya',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPortfolioDialog,
        backgroundColor: AppTheme.secondaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: portfolios.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.portfolio_outlined,
                    size: 64,
                    color: Color(0xFFD1D5DB),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Belum ada portfolio',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tambahkan portfolio untuk menunjukkan karya Anda',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: portfolios.length,
              itemBuilder: (context, index) {
                final portfolio = portfolios[index];
                return _buildPortfolioCard(portfolio, index);
              },
            ),
    );
  }

  Widget _buildPortfolioCard(Map<String, dynamic> portfolio, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        portfolio['projectName'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        portfolio['year'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Edit'),
                      value: 'edit',
                    ),
                    PopupMenuItem(
                      child: Text('Hapus', style: TextStyle(color: Colors.red)),
                      value: 'delete',
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditPortfolioDialog(index);
                    } else if (value == 'delete') {
                      setState(() {
                        portfolios.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Portfolio dihapus')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deskripsi',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7280),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  portfolio['description'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.link, size: 14, color: AppTheme.secondaryColor),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        portfolio['url'],
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppTheme.secondaryColor,
                          decoration: TextDecoration.underline,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'Tech Stack',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7280),
                  ),
                ),
                SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (portfolio['techStack'] as String)
                      .split(',')
                      .map((tech) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.secondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              tech.trim(),
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.secondaryColor,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddPortfolioDialog() {
    _resetForm();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Tambah Portfolio',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _projectNameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Proyek',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama proyek tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Deskripsi tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    labelText: 'URL/Link Proyek',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'URL tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _techStackController,
                  decoration: InputDecoration(
                    labelText: 'Tech Stack (pisahkan dengan koma)',
                    hintText: 'Flutter, Firebase, Node.js',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tech Stack tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  portfolios.add({
                    'id': DateTime.now().millisecondsSinceEpoch,
                    'projectName': _projectNameController.text,
                    'description': _descriptionController.text,
                    'url': _urlController.text,
                    'techStack': _techStackController.text,
                    'year': DateTime.now().year.toString(),
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Portfolio berhasil ditambahkan!'),
                    backgroundColor: Colors.green,
                  ),
                );
                _resetForm();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondaryColor,
            ),
            child: Text(
              'Tambah',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditPortfolioDialog(int index) {
    final portfolio = portfolios[index];
    _projectNameController.text = portfolio['projectName'];
    _descriptionController.text = portfolio['description'];
    _urlController.text = portfolio['url'];
    _techStackController.text = portfolio['techStack'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Portfolio',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _projectNameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Proyek',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    labelText: 'URL/Link Proyek',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _techStackController,
                  decoration: InputDecoration(
                    labelText: 'Tech Stack (pisahkan dengan koma)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                portfolios[index] = {
                  'id': portfolio['id'],
                  'projectName': _projectNameController.text,
                  'description': _descriptionController.text,
                  'url': _urlController.text,
                  'techStack': _techStackController.text,
                  'year': portfolio['year'],
                };
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Portfolio berhasil diperbarui!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondaryColor,
            ),
            child: Text(
              'Simpan',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    _projectNameController.clear();
    _descriptionController.clear();
    _urlController.clear();
    _techStackController.clear();
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _descriptionController.dispose();
    _urlController.dispose();
    _techStackController.dispose();
    super.dispose();
  }
}

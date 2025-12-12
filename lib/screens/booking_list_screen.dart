import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';

class BookingListScreen extends StatefulWidget {
  final String role;

  const BookingListScreen({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  String _selectedStatus = 'Semua';
  List<String> statusList = ['Semua', 'Pending', 'Accepted', 'Rejected', 'Completed'];

  List<Map<String, dynamic>> bookings = [
    {
      'id': '1',
      'projectTitle': 'Website E-commerce',
      'clientName': 'PT. Maju Jaya',
      'developerName': 'Budi Santoso',
      'budget': 'Rp 50.000.000',
      'status': 'accepted',
      'createdAt': '2024-12-01',
      'description': 'Website e-commerce dengan fitur pembayaran online',
    },
    {
      'id': '2',
      'projectTitle': 'Aplikasi Mobile Banking',
      'clientName': 'Bank Digital',
      'developerName': 'Siti Nurhaliza',
      'budget': 'Rp 30.000.000',
      'status': 'pending',
      'createdAt': '2024-12-05',
      'description': 'Aplikasi mobile untuk layanan perbankan digital',
    },
    {
      'id': '3',
      'projectTitle': 'Dashboard Analytics',
      'clientName': 'PT. Retail Plus',
      'developerName': 'Ahmad Hidayat',
      'budget': 'Rp 20.000.000',
      'status': 'completed',
      'createdAt': '2024-11-15',
      'description': 'Dashboard untuk analisis data penjualan real-time',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredBookings = _selectedStatus == 'Semua'
        ? bookings
        : bookings.where((b) => b['status'] == _selectedStatus.toLowerCase()).toList();

    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: widget.role == 'umkm'
            ? AppTheme.primaryColor
            : AppTheme.secondaryColor,
        elevation: 0,
        title: Text(
          'Riwayat Booking',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: widget.role == 'umkm' ? Colors.black : Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: statusList.map((status) {
                  final isSelected = _selectedStatus == status;
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedStatus = status;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (widget.role == 'umkm'
                                  ? AppTheme.primaryColor
                                  : AppTheme.secondaryColor)
                              : Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected
                              ? null
                              : Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Color(0xFF6B7280),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: filteredBookings.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 48,
                          color: Color(0xFFD1D5DB),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Belum ada booking',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      final booking = filteredBookings[index];
                      return _buildBookingCard(booking);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    final statusColor = _getStatusColor(booking['status']);
    final statusLabel = _getStatusLabel(booking['status']);

    return GestureDetector(
      onTap: () {
        _showBookingDetail(booking);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['projectTitle'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.role == 'umkm'
                            ? 'Developer: ${booking['developerName']}'
                            : 'Klien: ${booking['clientName']}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    statusLabel,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budget',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                    Text(
                      booking['budget'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dibuat',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                    Text(
                      booking['createdAt'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFFD1D5DB)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Color(0xFFF59E0B);
      case 'accepted':
        return Color(0xFF10B981);
      case 'rejected':
        return Color(0xFFEF4444);
      case 'completed':
        return Color(0xFF3B82F6);
      default:
        return Color(0xFF6B7280);
    }
  }

  String _getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Menunggu';
      case 'accepted':
        return 'Diterima';
      case 'rejected':
        return 'Ditolak';
      case 'completed':
        return 'Selesai';
      default:
        return status;
    }
  }

  void _showBookingDetail(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          booking['projectTitle'],
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow(
                'Status',
                _getStatusLabel(booking['status']),
              ),
              _buildDetailRow(
                'Klien',
                booking['clientName'],
              ),
              _buildDetailRow(
                'Developer',
                booking['developerName'],
              ),
              _buildDetailRow(
                'Budget',
                booking['budget'],
              ),
              _buildDetailRow(
                'Dibuat',
                booking['createdAt'],
              ),
              SizedBox(height: 12),
              Text(
                'Deskripsi:',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                booking['description'],
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Color(0xFF6B7280),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

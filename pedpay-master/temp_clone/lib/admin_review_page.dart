import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

class _Report {
  final String id;
  final String farmerName;
  final String species;
  final String coordinates;
  final String locationName;
  final String date;
  final String imageUrl;

  _Report({
    required this.id,
    required this.farmerName,
    required this.species,
    required this.coordinates,
    required this.locationName,
    required this.date,
    required this.imageUrl,
  });
}

class AdminReviewPage extends StatefulWidget {
  const AdminReviewPage({super.key});

  @override
  State<AdminReviewPage> createState() => _AdminReviewPageState();
}

class _AdminReviewPageState extends State<AdminReviewPage> {
  // Mock data for evaluation/demo
  final List<_Report> _pendingReports = [
    _Report(
      id: "REP-9021",
      farmerName: "Ramesh Kumar",
      species: "Red Mangrove",
      coordinates: "21.84°N, 89.02°E",
      locationName: "Sundarbans Sector 4",
      date: "Oct 24, 2023",
      imageUrl: "https://picsum.photos/400/300?random=11",
    ),
    _Report(
      id: "REP-9022",
      farmerName: "Amina Begum",
      species: "Black Mangrove",
      coordinates: "22.25°N, 89.55°E",
      locationName: "Sundarbans Sector 2",
      date: "Oct 25, 2023",
      imageUrl: "https://picsum.photos/400/300?random=12",
    ),
    _Report(
      id: "REP-9023",
      farmerName: "Vijay Singh",
      species: "White Mangrove",
      coordinates: "19.07°N, 72.87°E",
      locationName: "Mangrove Park, Mumbai",
      date: "Oct 26, 2023",
      imageUrl: "https://picsum.photos/400/300?random=13",
    ),
  ];

  void _handleAction(_Report report, bool isApprove) {
    setState(() {
      _pendingReports.removeWhere((r) => r.id == report.id);
    });

    final actionText = isApprove ? 'Approved' : 'Rejected';
    final actionColor = isApprove ? AppColors.accent : AppColors.coral;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isApprove ? Icons.check_circle_outline : Icons.cancel_outlined,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Text('Report ${report.id} $actionText'),
          ],
        ),
        backgroundColor: actionColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.surface),
      child: CustomScrollView(
        slivers: [
          _buildHeader(),
          if (_pendingReports.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.circleCheck, 
                         size: 64, color: AppColors.textTertiary.withValues(alpha: 0.5)),
                    const SizedBox(height: 16),
                    Text(
                      'All caught up!',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No pending reports to review.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final report = _pendingReports[index];
                    return _ReviewCard(
                      report: report,
                      onApprove: () => _handleAction(report, true),
                      onReject: () => _handleAction(report, false),
                    );
                  },
                  childCount: _pendingReports.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        decoration: const BoxDecoration(gradient: AppColors.heroGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(FontAwesomeIcons.clipboardCheck, color: AppColors.accent, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  'Pending Reviews',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Evaluate plantation reports uploaded by farmers.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final _Report report;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _ReviewCard({
    required this.report,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: GlassDecoration.card(borderRadius: 16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header banner (Report ID & Date)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.03),
              border: const Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  report.id,
                  style: GoogleFonts.jetBrainsMono(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    fontSize: 13,
                  ),
                ),
                Text(
                  report.date,
                  style: GoogleFonts.inter(
                    color: AppColors.textTertiary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          // Content body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Placeholder
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(report.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.farmerName,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _DetailRow(icon: FontAwesomeIcons.seedling, text: report.species, color: AppColors.accent),
                      const SizedBox(height: 4),
                      _DetailRow(icon: FontAwesomeIcons.locationDot, text: report.locationName, color: AppColors.skyBlue),
                      const SizedBox(height: 4),
                      _DetailRow(icon: FontAwesomeIcons.satellite, text: report.coordinates, color: AppColors.lavender),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onReject,
                    icon: const Icon(Icons.close, size: 18),
                    label: const Text('Reject'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.coral,
                      side: BorderSide(color: AppColors.coral.withValues(alpha: 0.5)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onApprove,
                    icon: const Icon(Icons.check, size: 18, color: Colors.white),
                    label: Text(
                      'Approve',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white), 
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _DetailRow({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

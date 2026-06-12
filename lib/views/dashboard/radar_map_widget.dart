import 'dart:math' as math;
import 'package:flutter/material.dart';

class RadarMapWidget extends StatefulWidget {
  final List<dynamic> activePartners;

  const RadarMapWidget({super.key, required this.activePartners});

  @override
  State<RadarMapWidget> createState() => _RadarMapWidgetState();
}

class _RadarMapWidgetState extends State<RadarMapWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int? _selectedIndex;
  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    // Filter partners with GPS
    final gpsPartners = widget.activePartners.where((p) {
      final lat = double.tryParse(p['latitude']?.toString() ?? '');
      final lng = double.tryParse(p['longitude']?.toString() ?? '');
      return lat != null && lng != null;
    }).toList();

    // Find min/max boundaries for scaling
    double minLat = 90.0, maxLat = -90.0;
    double minLng = 180.0, maxLng = -180.0;

    for (var p in gpsPartners) {
      final lat = double.parse(p['latitude'].toString());
      final lng = double.parse(p['longitude'].toString());
      if (lat < minLat) minLat = lat;
      if (lat > maxLat) maxLat = lat;
      if (lng < minLng) minLng = lng;
      if (lng > maxLng) maxLng = lng;
    }

    double latRange = maxLat - minLat;
    double lngRange = maxLng - minLng;
    if (latRange == 0) latRange = 0.1;
    if (lngRange == 0) lngRange = 0.1;

    // Add 15% margins
    minLat -= latRange * 0.15;
    maxLat += latRange * 0.15;
    minLng -= lngRange * 0.15;
    maxLng += lngRange * 0.15;
    
    latRange = maxLat - minLat;
    lngRange = maxLng - minLng;

    Widget buildMainLayout(double width) {
      return Container(
        height: 520,
        decoration: BoxDecoration(
          color: const Color(0xff0f172a), // Slate 900
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color:const Color(0xff1e293b)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            // Radar screen
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: RadarPainter(
                            sweepAngle: _animationController.value * 2 * math.pi,
                            pulseValue: _animationController.value,
                            partners: gpsPartners,
                            minLat: minLat,
                            maxLat: maxLat,
                            minLng: minLng,
                            maxLng: maxLng,
                            selectedIndex: _selectedIndex,
                            hoveredIndex: _hoveredIndex,
                          ),
                        );
                      },
                    ),
                  ),
                  // Click handler overlay
                  Positioned.fill(
                    child: GestureDetector(
                      onTapUp: (details) {
                        final RenderBox box = context.findRenderObject() as RenderBox;
                        final localOffset = box.globalToLocal(details.globalPosition);
                        
                        // Bounding Box to detect click
                        // Find closest dot
                        int? closestIndex;
                        double closestDist = 20.0; // Click radius
                        
                        final radarWidth = box.size.width * 0.7; // 70% width is radar
                        final radarHeight = box.size.height;

                        for (int i = 0; i < gpsPartners.length; i++) {
                          final p = gpsPartners[i];
                          final lat = double.parse(p['latitude'].toString());
                          final lng = double.parse(p['longitude'].toString());

                          final x = (lng - minLng) / lngRange * radarWidth;
                          final y = (1 - (lat - minLat) / latRange) * radarHeight;

                          final dist = math.sqrt(math.pow(localOffset.dx - x, 2) + math.pow(localOffset.dy - y, 2));
                          if (dist < closestDist) {
                            closestDist = dist;
                            closestIndex = i;
                          }
                        }

                        setState(() {
                          _selectedIndex = closestIndex;
                        });
                      },
                    ),
                  ),
                  // Bounding text stats overlay
                  Positioned(
                    top: 15,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.radar, color: Colors.greenAccent, size: 18),
                            SizedBox(width: 6),
                            Text(
                              "LIVE RADAR SCANNING",
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Active GPS Nodes: ${gpsPartners.length}",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Divider
            VerticalDivider(color: const Color(0xff1e293b), width: 1),
            // Right info/list sidebar
            Expanded(
              flex: 3,
              child: Container(
                color: const Color(0xff1e293b), // Slate 800
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: const Color(0xff0f172a),
                      child: const Row(
                        children: [
                          Icon(Icons.online_prediction, color: Colors.greenAccent, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Online Partners",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: widget.activePartners.isEmpty
                          ? const Center(
                              child: Text(
                                "No active partners online",
                                style: TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                            )
                          : ListView.builder(
                              itemCount: widget.activePartners.length,
                              itemBuilder: (context, index) {
                                final partner = widget.activePartners[index];
                                final hasGps = partner['latitude'] != null && partner['longitude'] != null;
                                
                                // Check if this is the currently selected partner in the map
                                final isPartnerSelected = hasGps && gpsPartners.indexOf(partner) == _selectedIndex;

                                return InkWell(
                                  onTap: () {
                                    if (hasGps) {
                                      final gpsIndex = gpsPartners.indexOf(partner);
                                      setState(() {
                                        _selectedIndex = gpsIndex;
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: isPartnerSelected 
                                          ? const Color(0xff1e293b).withOpacity(0.7)
                                          : Colors.transparent,
                                      border: Border(
                                        bottom: BorderSide(color: const Color(0xff0f172a).withOpacity(0.5)),
                                        left: BorderSide(
                                          color: isPartnerSelected ? Colors.greenAccent : Colors.transparent,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        // Profile Image
                                        CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Colors.blueGrey.shade700,
                                          backgroundImage: partner['profileImage'] != null && partner['profileImage'].isNotEmpty
                                              ? NetworkImage(partner['profileImage'])
                                              : null,
                                          child: partner['profileImage'] == null || partner['profileImage'].isEmpty
                                              ? const Icon(Icons.person, size: 18, color: Colors.white)
                                              : null,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                partner['name'] ?? 'Unknown',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                partner['category']?.isNotEmpty == true 
                                                    ? partner['category'] 
                                                    : 'No Service Category',
                                                style: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: 11,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          hasGps ? Icons.gps_fixed : Icons.gps_off,
                                          size: 16,
                                          color: hasGps ? Colors.greenAccent : Colors.amber.shade600,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        buildMainLayout(size.width),
        // Detail panel (displayed if a marker is tapped)
        if (_selectedIndex != null && _selectedIndex! < gpsPartners.length) ...[
          const SizedBox(height: 15),
          Builder(
            builder: (context) {
              final selectedPartner = gpsPartners[_selectedIndex!];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    // Profile image large
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: selectedPartner['profileImage'] != null && selectedPartner['profileImage'].isNotEmpty
                          ? NetworkImage(selectedPartner['profileImage'])
                          : null,
                      child: selectedPartner['profileImage'] == null || selectedPartner['profileImage'].isEmpty
                          ? const Icon(Icons.person, size: 28, color: Colors.grey)
                          : null,
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedPartner['name'] ?? 'Unknown',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  selectedPartner['category'] ?? 'Vendor',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (selectedPartner['subCategory']?.isNotEmpty == true) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade50,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    selectedPartner['subCategory'],
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.purple.shade800,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 14, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                selectedPartner['area'] ?? 'N/A',
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                              ),
                              const SizedBox(width: 15),
                              Icon(Icons.phone, size: 14, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                selectedPartner['phone'] ?? 'N/A',
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.assignment, size: 16, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text(
                              "${selectedPartner['currentOrders']} active orders",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Last Active: ${selectedPartner['lastActive'] ?? 'N/A'}",
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}

class RadarPainter extends CustomPainter {
  final double sweepAngle;
  final double pulseValue;
  final List<dynamic> partners;
  final double minLat;
  final double maxLat;
  final double minLng;
  final double maxLng;
  final int? selectedIndex;
  final int? hoveredIndex;

  RadarPainter({
    required this.sweepAngle,
    required this.pulseValue,
    required this.partners,
    required this.minLat,
    required this.maxLat,
    required this.minLng,
    required this.maxLng,
    this.selectedIndex,
    this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) / 1.1;

    // Paints
    final bgPaint = Paint()
      ..color = const Color(0xff0f172a)
      ..style = PaintingStyle.fill;

    final gridPaint = Paint()
      ..color = Colors.greenAccent.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final sweepPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.greenAccent.withOpacity(0.0),
          Colors.greenAccent.withOpacity(0.2),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius))
      ..style = PaintingStyle.fill;

    // Draw background grid circles
    for (double i = 0.25; i <= 1.0; i += 0.25) {
      canvas.drawCircle(center, maxRadius * i, gridPaint);
    }

    // Draw radar crosshairs lines
    canvas.drawLine(Offset(center.dx - maxRadius, center.dy), Offset(center.dx + maxRadius, center.dy), gridPaint);
    canvas.drawLine(Offset(center.dx, center.dy - maxRadius), Offset(center.dx, center.dy + maxRadius), gridPaint);

    // Draw sweep sector (radar sweep effect)
    final sweepPath = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: maxRadius),
        sweepAngle - 0.5, // Sweep width
        0.5,
        false,
      )
      ..close();
    canvas.drawPath(sweepPath, sweepPaint);

    // Draw sweeping line
    final linePaint = Paint()
      ..color = Colors.greenAccent.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final lineX = center.dx + maxRadius * math.cos(sweepAngle);
    final lineY = center.dy + maxRadius * math.sin(sweepAngle);
    canvas.drawLine(center, Offset(lineX, lineY), linePaint);

    // Draw partners coordinates mapping
    final double latRange = maxLat - minLat;
    final double lngRange = maxLng - minLng;

    for (int i = 0; i < partners.length; i++) {
      final p = partners[i];
      final lat = double.parse(p['latitude'].toString());
      final lng = double.parse(p['longitude'].toString());

      // Normalize mapping coordinates
      final x = (lng - minLng) / lngRange * size.width;
      final y = (1 - (lat - minLat) / latRange) * size.height;
      final partnerOffset = Offset(x, y);

      final isSelected = selectedIndex == i;
      final pulseRadius = 6.0 + 12.0 * pulseValue;
      
      // Draw pulse glow outer ring
      final glowPaint = Paint()
        ..color = isSelected ? Colors.cyanAccent.withOpacity(1.0 - pulseValue) : Colors.greenAccent.withOpacity(1.0 - pulseValue)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawCircle(partnerOffset, pulseRadius, glowPaint);

      // Draw center solid dot
      final dotPaint = Paint()
        ..color = isSelected ? Colors.cyanAccent : Colors.greenAccent
        ..style = PaintingStyle.fill;
      canvas.drawCircle(partnerOffset, 6.0, dotPaint);

      // Target pointer if selected
      if (isSelected) {
        final targetPaint = Paint()
          ..color = Colors.cyanAccent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;
        canvas.drawCircle(partnerOffset, 12.0, targetPaint);
        // crosshairs
        canvas.drawLine(Offset(x - 18, y), Offset(x + 18, y), targetPaint);
        canvas.drawLine(Offset(x, y - 18), Offset(x, y + 18), targetPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant RadarPainter oldDelegate) {
    return oldDelegate.sweepAngle != sweepAngle ||
        oldDelegate.pulseValue != pulseValue ||
        oldDelegate.partners != partners ||
        oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.hoveredIndex != hoveredIndex;
  }
}

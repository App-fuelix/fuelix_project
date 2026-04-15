import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // Données statiques pour le binôme
  final Map<String, dynamic> stats = {
    "total_consumption": "1,480L",
    "total_cost": "3,920",
    "avg_per_vehicle": "185L",
    "monthly_trend": "+8,5%",
    "ai_insight": "Your fuel consumption increased by 12% this week.",
  };

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color primaryColor = const Color(0xFFF2A945);
    final Color navyColor = const Color(0xFF0F2A44);
    final Color scaffoldBg = isDark ? navyColor : const Color(0xFFF4F6F8);
    final Color cardBg = isDark ? const Color(0xFF1B3B5A) : Colors.white;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          isDark 
            ? 'assets/images/logo_fuelix_2.png' 
            : 'assets/images/logo_fuelix.png',
          width: 100,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: isDark ? Colors.white : navyColor),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
          IconButton(
            icon: Icon(Icons.account_circle_outlined, color: isDark ? Colors.white : navyColor),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Home",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : navyColor),
            ),
            const SizedBox(height: 20),

            _buildInsightCard(stats['ai_insight'], cardBg, primaryColor),

            const SizedBox(height: 20),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _buildStatCard("Total Consumption", stats['total_consumption'], "", cardBg, isDark),
                _buildStatCard("Total Cost", "${stats['total_cost']} TND", "TND", cardBg, isDark, valueColor: primaryColor),
                _buildStatCard("Average / Vehicle", stats['avg_per_vehicle'], "", cardBg, isDark),
                _buildStatCard("Monthly Trend", stats['monthly_trend'], "", cardBg, isDark, valueColor: Colors.orangeAccent),
              ],
            ),

            const SizedBox(height: 25),

            _buildChartSection(cardBg, isDark, navyColor),
            
            const SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/stations'),
                    child: _buildQuickAction("Stations", Icons.location_on, primaryColor, cardBg, isDark),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/ai-insights'),
                    child: _buildQuickAction("IA Insights", Icons.psychology, primaryColor, cardBg, isDark),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(isDark, primaryColor, navyColor),
    );
  }

  // --- WIDGETS DE COMPOSANTS ---

  Widget _buildInsightCard(String text, Color bg, Color accent) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(15),
        border: Border(top: BorderSide(color: accent, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("AI Insight", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String unit, Color bg, bool isDark, {Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value.replaceAll(unit, ""),
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold, 
                    color: valueColor ?? (isDark ? Colors.white : const Color(0xFF0F2A44))
                  ),
                ),
                TextSpan(text: unit, style: TextStyle(fontSize: 12, color: valueColor ?? Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection(Color bg, bool isDark, Color navy) {
    return Container(
      height: 280,
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Weekly Fuel Consumption",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text("Last 7 days", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        if (value.toInt() >= 0 && value.toInt() < days.length) {
                          return Text(days[value.toInt()], style: const TextStyle(color: Colors.grey, fontSize: 12));
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 1),
                      const FlSpot(1, 1.5),
                      const FlSpot(2, 1.4),
                      const FlSpot(3, 2),
                      const FlSpot(4, 3), 
                      const FlSpot(5, 2.2),
                      const FlSpot(6, 1.5),
                    ],
                    isCurved: true,
                    color: const Color(0xFFF2A945),
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFF2A945).withOpacity(0.3),
                          const Color(0xFFF2A945).withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
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

  Widget _buildQuickAction(String title, IconData icon, Color color, Color bg, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildBottomNav(bool isDark, Color primary, Color navy) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() => _selectedIndex = index);
        switch (index) {
          case 0: break; 
          case 1: Navigator.pushNamed(context, '/card'); break;
          case 2: Navigator.pushNamed(context, '/history'); break;
          case 3: Navigator.pushNamed(context, '/profile'); break;
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: isDark ? navy : Colors.white,
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Card"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
      ],
    );
  }
}
// about_me_page.dart
import 'package:flutter/material.dart';

class AboutMePage extends StatefulWidget {
  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> with TickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'About Me',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Colors.blue,
          tabs: [
            Tab(icon: Icon(Icons.person), text: 'Profile'),
            Tab(icon: Icon(Icons.directions_car), text: 'Formula 1'),
            Tab(icon: Icon(Icons.sports_basketball), text: 'Basketball'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProfileTab(),
          _buildF1Tab(),
          _buildBasketballTab(),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Profile Picture
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),
          
          SizedBox(height: 24),
          
          // Name and Title
          Text(
            'Your Name',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          
          SizedBox(height: 8),
          
          Text(
            'Flutter Developer & Sports Enthusiast',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          
          SizedBox(height: 32),
          
          // Bio Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Me',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Passionate Flutter developer with a love for high-speed Formula 1 racing and the strategic gameplay of basketball. I enjoy building mobile applications while following the latest F1 seasons and NBA finals.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Apps Built', '12+', Icons.phone_android, Colors.blue),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('Years Coding', '3+', Icons.code, Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildF1Tab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // F1 Header
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red[600]!, Colors.red[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car, size: 40, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'Formula 1 Passion',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 24),
          
          // Favorite Driver
          _buildInfoCard(
            'Favorite Driver',
            'Max Verstappen',
            'Red Bull Racing',
            Icons.star,
            Colors.blue[600]!,
          ),
          
          SizedBox(height: 16),
          
          // Favorite Team
          _buildInfoCard(
            'Favorite Team',
            'Red Bull Racing',
            'Current Champions',
            Icons.emoji_events,
            Colors.orange[600]!,
          ),
          
          SizedBox(height: 16),
          
          // Favorite Circuit
          _buildInfoCard(
            'Favorite Circuit',
            'Monaco Grand Prix',
            'Street Circuit Legend',
            Icons.location_on,
            Colors.green[600]!,
          ),
          
          SizedBox(height: 24),
          
          // Recent Season Highlights
          Text(
            'Recent Season Highlights',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          
          SizedBox(height: 16),
          
          _buildHighlightCard(
            '2024 Season',
            'Following the intense championship battle',
            Icons.speed,
          ),
          
          SizedBox(height: 12),
          
          _buildHighlightCard(
            'Best Races',
            'Monaco, Silverstone, Spa-Francorchamps',
            Icons.flag,
          ),
        ],
      ),
    );
  }

  Widget _buildBasketballTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Basketball Header
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[600]!, Colors.orange[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sports_basketball, size: 40, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'Basketball Finals',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 24),
          
          // Favorite Team
          _buildInfoCard(
            'Favorite NBA Team',
            'Los Angeles Lakers',
            '17x NBA Champions',
            Icons.emoji_events,
            Colors.purple[600]!,
          ),
          
          SizedBox(height: 16),
          
          // Favorite Player
          _buildInfoCard(
            'Favorite Player',
            'LeBron James',
            'The King',
            Icons.star,
            Colors.blue[600]!,
          ),
          
          SizedBox(height: 16),
          
          // Finals History
          _buildInfoCard(
            'Memorable Finals',
            '2020 NBA Finals',
            'Lakers Championship',
            Icons.trophy,
            Colors.amber[600]!,
          ),
          
          SizedBox(height: 24),
          
          // Recent Finals
          Text(
            'Recent NBA Finals',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          
          SizedBox(height: 16),
          
          _buildFinalsCard('2024 Finals', 'Boston Celtics vs Dallas Mavericks', 'Celtics Win 4-1'),
          SizedBox(height: 12),
          _buildFinalsCard('2023 Finals', 'Denver Nuggets vs Miami Heat', 'Nuggets Win 4-1'),
          SizedBox(height: 12),
          _buildFinalsCard('2022 Finals', 'Golden State Warriors vs Boston Celtics', 'Warriors Win 4-2'),
          
          SizedBox(height: 24),
          
          // Basketball Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Favorite Position', 'Point Guard', Icons.sports_basketball, Colors.orange),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('Finals Watched', '15+', Icons.tv, Colors.purple),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String main, String subtitle, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  main,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard(String title, String description, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red[600], size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalsCard(String year, String matchup, String result) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                year,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[600],
                ),
              ),
              Icon(Icons.sports_basketball, color: Colors.orange[400], size: 20),
            ],
          ),
          SizedBox(height: 8),
          Text(
            matchup,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 4),
          Text(
            result,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
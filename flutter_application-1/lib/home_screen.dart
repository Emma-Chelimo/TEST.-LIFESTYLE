class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _recentlyPlayed = [
    {'title': 'Blinding Lights', 'artist': 'The Weeknd', 'image': 'https://i.scdn.co/image/ab67616d00004851c96f7c7b077c224975b4c5ce'},
    {'title': 'Save Your Tears', 'artist': 'The Weeknd', 'image': 'https://i.scdn.co/image/ab67616d00004851c08d11dfdcf3270f8c4ee866'},
    {'title': 'Stay', 'artist': 'The Kid LAROI, Justin Bieber', 'image': 'https://i.scdn.co/image/ab67616d0000485170dbc8f8eefebc0901a7c123'},
  ];

  final List<Map<String, dynamic>> _recommended = [
    {'title': 'Daily Mix 1', 'description': 'Made for you', 'image': 'https://i.scdn.co/image/ab67706f00000002a980b152e708b33c6516c16b'},
    {'title': 'Discover Weekly', 'description': 'Your weekly mixtape', 'image': 'https://i.scdn.co/image/ab67706f00000002a980b152e708b33c6516c16b'},
    {'title': 'Chill Hits', 'description': 'Kick back to the best...', 'image': 'https://i.scdn.co/image/ab67706f00000002a980b152e708b33c6516c16b'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Good afternoon', style: Theme.of(context).textTheme.headline4),
          ),
          _buildSection('Recently played', _recentlyPlayed, isSquare: false),
          _buildSection('Made for you', _recommended, isSquare: true),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> items, {bool isSquare = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 8),
          Container(
            height: isSquare ? 180 : 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(isSquare ? 4 : 50),
                        child: Image.network(
                          items[index]['image'],
                          width: isSquare ? 160 : 140,
                          height: isSquare ? 160 : 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: isSquare ? 160 : 140,
                        child: Text(
                          items[index]['title'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (items[index]['artist'] != null || items[index]['description'] != null)
                        Container(
                          width: isSquare ? 160 : 140,
                          child: Text(
                            items[index]['artist'] ?? items[index]['description'],
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
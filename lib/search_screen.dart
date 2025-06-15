class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Podcasts', 'color': Colors.orange},
    {'name': 'Made For You', 'color': Colors.purple},
    {'name': 'Charts', 'color': Colors.blue},
    {'name': 'New Releases', 'color': Colors.green},
    {'name': 'Discover', 'color': Colors.pink},
    {'name': 'Concerts', 'color': Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            title: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for songs, artists, or podcasts',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Simulate search
                if (value.isNotEmpty) {
                  setState(() {
                    _searchResults = [
                      {'type': 'song', 'title': 'Blinding Lights', 'artist': 'The Weeknd'},
                      {'type': 'artist', 'name': 'The Weeknd'},
                      {'type': 'playlist', 'name': 'Today\'s Top Hits'},
                    ];
                  });
                } else {
                  setState(() {
                    _searchResults = [];
                  });
                }
              },
            ),
          ),
          if (_searchResults.isEmpty)
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Card(
                      color: _categories[index]['color'].withOpacity(0.7),
                      child: Center(
                        child: Text(
                          _categories[index]['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: _categories.length,
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = _searchResults[index];
                  return ListTile(
                    leading: item['type'] == 'song'
                        ? Icon(Icons.music_note)
                        : item['type'] == 'artist'
                            ? Icon(Icons.person)
                            : Icon(Icons.playlist_play),
                    title: Text(item['title'] ?? item['name']),
                    subtitle: item['artist'] != null ? Text(item['artist']) : null,
                  );
                },
                childCount: _searchResults.length,
              ),
            ),
        ],
      ),
    );
  }
}
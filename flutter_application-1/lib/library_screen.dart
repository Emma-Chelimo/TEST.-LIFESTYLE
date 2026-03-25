class LibraryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _playlists = [
    {'name': 'Liked Songs', 'count': 125, 'image': 'https://t.scdn.co/images/3099b3803ad9496896c43f22fe9be8c4.png'},
    {'name': 'Workout Mix', 'count': 42, 'image': 'https://i.scdn.co/image/ab67706f00000002a980b152e708b33c6516c16b'},
    {'name': 'Chill Vibes', 'count': 78, 'image': 'https://i.scdn.co/image/ab67706f00000002a980b152e708b33c6516c16b'},
  ];

  final List<Map<String, dynamic>> _artists = [
    {'name': 'The Weeknd', 'image': 'https://i.scdn.co/image/ab6761610000e5eb0bae7cfd3b32b10154e0b8b3'},
    {'name': 'Dua Lipa', 'image': 'https://i.scdn.co/image/ab6761610000e5ebcdce7620dc940db079bf4952'},
    {'name': 'Drake', 'image': 'https://i.scdn.co/image/ab6761610000e5eb4293385d324db8558179afd9'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Library'),
          bottom: TabBar(
            indicatorColor: Colors.purpleAccent,
            tabs: [
              Tab(text: 'Playlists'),
              Tab(text: 'Artists'),
              Tab(text: 'Albums'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPlaylists(),
            _buildArtists(),
            Center(child: Text('Albums will appear here')),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaylists() {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: _playlists.length,
      itemBuilder: (context, index) {
        return Card(
          color: Color(0xFF1E1E1E),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                _playlists[index]['image'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(_playlists[index]['name']),
            subtitle: Text('${_playlists[index]['count']} songs'),
            trailing: Icon(Icons.more_vert, color: Colors.white70),
          ),
        );
      },
    );
  }

  Widget _buildArtists() {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _artists.length,
      itemBuilder: (context, index) {
        return Card(
          color: Color(0xFF1E1E1E),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(_artists[index]['image']),
              ),
              SizedBox(height: 10),
              Text(_artists[index]['name']),
            ],
          ),
        );
      },
    );
  }
}
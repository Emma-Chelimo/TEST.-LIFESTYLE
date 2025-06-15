class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Upload to Firebase Storage
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final ref = FirebaseStorage.instance.ref().child('profile_images/${user.uid}.jpg');
        await ref.putFile(_image!);
        final url = await ref.getDownloadURL();
        await user.updatePhotoURL(url);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          GestureDetector(
            onTap: _getImage,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: _image != null
                  ? FileImage(_image!)
                  : (user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : AssetImage('assets/default_profile.png')) as ImageProvider,
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.edit, size: 18),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            user?.displayName ?? 'User Name',
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            user?.email ?? 'user@example.com',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 30),
          _buildProfileOption(Icons.settings, 'Settings'),
          _buildProfileOption(Icons.payment, 'Subscription'),
          _buildProfileOption(Icons.help_outline, 'Help'),
          _buildProfileOption(Icons.logout, 'Logout', isLogout: true),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String text, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.purpleAccent),
      title: Text(text, style: TextStyle(color: isLogout ? Colors.red : Colors.white)),
      onTap: () {
        if (isLogout) {
          FirebaseAuth.instance.signOut();
        }
      },
    );
  }
}
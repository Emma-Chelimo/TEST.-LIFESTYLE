import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

// If you need to initialize Supabase (usually in main.dart):
// await Supabase.initialize(
//   url: 'https://your-project.supabase.co',
//   anonKey: 'your-anon-key',
// );
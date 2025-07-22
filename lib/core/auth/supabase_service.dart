import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://ajncyrbbbkabswjbjurn.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFqbmN5cmJiYmthYnN3amJqdXJuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxNzgyMjksImV4cCI6MjA2MTc1NDIyOX0.4agb4QyLfPVFHkMd5LI3Z1pVDYPTFvcac8eMs-ndiig',
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}

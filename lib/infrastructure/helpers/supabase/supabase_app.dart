import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zawya_islamic/secret.dart';

class SupabaseApp {
  static final SupabaseApp _instance = SupabaseApp._internal();
  factory SupabaseApp() => _instance;
  SupabaseApp._internal();

  late Supabase supabase;

  Future<void> init() async {
    supabase = await Supabase.initialize(
      url: SupabaseSecrets.supabaseUrl,
      anonKey: SupabaseSecrets.supabaseApi,
    );

  }
}

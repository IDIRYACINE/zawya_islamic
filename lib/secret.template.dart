// ignore_for_file: unused_field

abstract class SupabaseSecrets {
  static const isTest = true;
  static const _supabaseUrl2 = "url";
  static const _supabaseApi2 = "apiKey";

  static const _supabaseUrl = "url";
  static const _supabaseApi = "apiKey";

  static const _testSupabaseUrl = "http://192.168.1.100:54321";
  static const _testSupabaseApi = "apiKey";

  static String get supabaseUrl => isTest ? _testSupabaseUrl : _supabaseUrl;
  static String get supabaseApi => isTest ? _testSupabaseApi : _supabaseApi;
}

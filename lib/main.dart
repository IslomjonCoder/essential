import 'package:essential/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndrZGtubmV2dHJmY2xjZXRsaWVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM5NTY0ODUsImV4cCI6MjAyOTUzMjQ4NX0.zKUO3W90U-xDYga01OgPIaDfd6vrByYryt4EJZfY0gI';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Supabase.initialize(
    url: "https://wkdknnevtrfclcetlied.supabase.co",
    anonKey: token,
  );
  runApp(const App());
}

final supabase = Supabase.instance.client;

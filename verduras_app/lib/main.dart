import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/verduras_controller.dart';
import 'views/inicio_view.dart';
import 'theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => VerdurasController()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
        child: const MyMaterialApp()
    );
  }
}

class MyMaterialApp extends StatelessWidget{
  const MyMaterialApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Gestión de Verduras',
          theme: themeProvider.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
          home: InicioView(),
        );
      },
    );
  }
}
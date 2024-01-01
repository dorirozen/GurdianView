/*

MultiProvider(
providers: [
ChangeNotifierProvider(create: (context) => ThemeProvider()),
],

class CounterAppState extends State<CounterApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      /// device_preview
      builder: DevicePreview.appBuilder,
      title: Strings.appTitle,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}

to use it :
ElevatedButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          child: Text('Toggle Theme'),
        ),
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian_view/src/theme/theme_provider.dart';

class ToggleDarkLight extends StatelessWidget {
  const ToggleDarkLight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(context.read<ThemeProvider>().isDarkMode
          ? Icons.dark_mode
          : Icons.light_mode),
      onPressed: () {
        context.read<ThemeProvider>().toggleTheme();
      },
    );
  }
}

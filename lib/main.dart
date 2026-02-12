import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme.dart';
import 'core/network/connectivity_service.dart';
import 'features/auth/screens/auth_entry_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const JoinlnApp());
}

class JoinlnApp extends StatelessWidget {
  const JoinlnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joinln',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthEntryScreen(),
      builder: (context, child) {
        return ConnectivityWrapper(child: child!);
      },
      // TODO: Add routing
    );
  }
}

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;
  const ConnectivityWrapper({super.key, required this.child});

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  final ConnectivityService _connectivityService = ConnectivityService();
  bool _isConnected = true;
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    _connectivityService.connectionChange.listen((hasConnection) {
      if (mounted) {
        setState(() => _isConnected = hasConnection);
        if (!_isConnected && !_isDialogShown) {
           _showNoInternetDialog();
        } else if (_isConnected && _isDialogShown) {
          Navigator.of(context, rootNavigator: true).pop();
          _isDialogShown = false;
        }
      }
    });
  }

  void _showNoInternetDialog() {
    _isDialogShown = true;
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, size: 60, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Please check your internet settings.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    ).then((_) => _isDialogShown = false);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

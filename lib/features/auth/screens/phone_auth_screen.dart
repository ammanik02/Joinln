import 'package:flutter/material.dart';
import 'verify_otp_screen.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../../../core/theme.dart';
import '../../../services/auth_service.dart';

class PhoneAuthScreen extends StatefulWidget {
  final bool isLogin;
  const PhoneAuthScreen({super.key, required this.isLogin});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _countryCode = '+1';
  bool _isLoading = false;

  void _sendOtp() async {
    setState(() => _isLoading = true);
    try {
      await AuthService().verifyPhone(
        phoneNumber: '$_countryCode${_phoneController.text.trim()}',
        onCodeSent: (verificationId, resendToken) {
          setState(() => _isLoading = false);
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyOtpScreen(
                phoneNumber: '$_countryCode${_phoneController.text.trim()}',
                isLogin: widget.isLogin,
                verificationId: verificationId,
              ),
            ),
          );
        },
        onVerificationFailed: (e) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Verification Failed: ${e.message}')),
          );
        },
        onVerificationCompleted: (credential) {
           // Auto-sign-in logic could go here
           setState(() => _isLoading = false);
        },
        onCodeAutoRetrievalTimeout: (verificationId) {
          setState(() => _isLoading = false);
        },
      );
    } catch (e) {
      setState(() => _isLoading = false);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Configuration Error'),
          content: Text('Firebase has not been initialized. \n\nError: $e\n\nPlease ensure you have run "flutterfire configure" and checking the "Release Checklist".'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isLogin ? 'Log In' : 'Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your phone number',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We will send you a verification code.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                CountryCodePicker(
                  onChanged: (country) {
                    setState(() => _countryCode = country.dialCode ?? '+1');
                  },
                  initialSelection: 'US',
                  favorite: const ['+1', 'US'],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      hintText: '123 456 7890',
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _sendOtp,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

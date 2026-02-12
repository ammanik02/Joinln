import 'package:flutter/material.dart';
import 'setup_profile_screen.dart';
import '../../map/screens/home_map_screen.dart';
import '../../../services/auth_service.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isLogin;
  final String verificationId;

  const VerifyOtpScreen({
    super.key,
    required this.phoneNumber,
    required this.isLogin,
    required this.verificationId,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  void _verifyOtp() async {
    setState(() => _isLoading = true);
    
    try {
      await AuthService().signInWithConnect(
        verificationId: widget.verificationId,
        smsCode: _otpController.text.trim(),
      );

      setState(() => _isLoading = false);
      if (!mounted) return;

      if (widget.isLogin) {
         // Existing user -> Go to Map
         Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeMapScreen()),
          (route) => false,
        );
      } else {
        // New user -> Setup Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SetupProfileScreen()),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Code')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Enter the code sent to \n${widget.phoneNumber}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
              style: const TextStyle(fontSize: 24, letterSpacing: 8),
              decoration: const InputDecoration(
                hintText: '000000',
                counterText: '',
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyOtp,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

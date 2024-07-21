import 'package:flutter/material.dart';

class ThemeDataExampleApp extends StatelessWidget {
  const ThemeDataExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xffF09036)),
      home: const ConfirmationScreen(),
    );
  }
}

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    bool isBooked = false;
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: const Color(0xffF09036),
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.05),
                Image.asset(
                  isBooked
                      ? 'assets/images/success.png'
                      : 'assets/images/fail.png',
                  height: 350,
                  fit: BoxFit.fitHeight,
                ),
                isBooked ? SuccessTitle() : FailureTitle(),
                SizedBox(height: screenHeight * 0.05),
                isBooked ? SuccessContent() : FailureContent(),
                SizedBox(height: screenHeight * 0.2),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: const BorderSide(width: 2, color: Colors.white),
                        ),
                        child: const Text('Xác nhận',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessContent extends StatelessWidget {
  const SuccessContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
        'Lịch hẹn của bạn đã được ghi nhận thành công. Vui lòng ghi nhớ ngày lịch hẹn và đến đúng giờ.',
        style: const TextStyle(fontSize: 20, color: Colors.white),
        textAlign: TextAlign.center);
  }
}

class FailureContent extends StatelessWidget {
  const FailureContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
        'Lịch hẹn của bạn chưa được ghi nhận thành công. Vui lòng thử lại sau ít phút hoặc liên hệ với chúng tôi nếu gặp vấn đề gì.',
        style: const TextStyle(fontSize: 20, color: Colors.white),
        textAlign: TextAlign.center);
  }
}

class SuccessTitle extends StatelessWidget {
  const SuccessTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Đặt lịch thành công!',
      style: TextStyle(
          fontSize: 35, fontWeight: FontWeight.w700, color: Colors.white),
    );
  }
}

class FailureTitle extends StatelessWidget {
  const FailureTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Đặt lịch thất bại!',
      style: TextStyle(
          fontSize: 35, fontWeight: FontWeight.w700, color: Colors.white),
    );
  }
}

// src/adm_frontend/lib/widgets/nyan_progress_dialog.dart

import 'package:flutter/material.dart';

class NyanProgressDialog extends StatefulWidget {
  final String fileName;
  final Future<bool> transferFuture;

  const NyanProgressDialog({
    super.key,
    required this.fileName,
    required this.transferFuture,
  });

  @override
  State<NyanProgressDialog> createState() => _NyanProgressDialogState();
}

class _NyanProgressDialogState extends State<NyanProgressDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _progress = 0.0;
  bool _isCompleted = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _startSimulatedProgress();
  }

  void _startSimulatedProgress() async {
    for (int i = 1; i <= 90; i++) {
      if (_isCompleted || _isError) return;
      await Future.delayed(const Duration(milliseconds: 30));
      if (mounted) {
        setState(() {
          _progress = i / 100;
        });
      }
    }

    bool success = await widget.transferFuture;

    if (mounted) {
      setState(() {
        _progress = 1.0;
        _isCompleted = true;
        _isError = !success;
      });
    }

    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      Navigator.pop(context, success);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.blueGrey.shade900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.cyanAccent, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '🐱 در حال انتقال فایل با نیان‌کَت! 🌈',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.fileName,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 30),

            SizedBox(
              height: 60,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: _progress,
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                            Colors.green,
                            Colors.blue,
                            Colors.purple,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 100),
                    left: MediaQuery.of(context).size.width * 0.55 * _progress,
                    child: RotationTransition(
                      turns: Tween(
                        begin: -0.02,
                        end: 0.02,
                      ).animate(_controller),
                      child: const Text('🐱🌈', style: TextStyle(fontSize: 32)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _isCompleted
                  ? (_isError
                        ? 'خطا در انتقال!'
                        : 'انتقال با موفقیت انجام شد! 🎉')
                  : '${(_progress * 100).toInt()}%',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _isError ? Colors.redAccent : Colors.cyanAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

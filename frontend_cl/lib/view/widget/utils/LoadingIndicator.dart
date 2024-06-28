import 'package:flutter/material.dart';
import 'package:frontend/view_model/loading_state.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoadingState>().isLoading;
    return Stack(
      children: [
        child,
        state
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Color(0xffF48B29),
                        strokeWidth: 5,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

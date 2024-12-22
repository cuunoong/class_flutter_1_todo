import 'package:flutter/material.dart';

class TodoItemWidget extends StatelessWidget {
  final String todo;
  final Animation<double> animation;
  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Transform.translate(
            offset: Offset(0, -50 * (1 - animation.value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        margin: const EdgeInsets.only(bottom: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          spacing: 12,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Color(0xFFE7E9EA),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Text(
              todo,
              style: TextStyle(fontSize: 14, height: 14 / 22),
            ),
          ],
        ),
      ),
    );
  }
}

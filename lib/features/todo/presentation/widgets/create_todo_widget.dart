import 'package:class_flutter_1_todo/features/todo/presentation/blocs/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CreateTodoWidget extends StatefulWidget {
  final Function(String) onSubmitted;
  const CreateTodoWidget({super.key, required this.onSubmitted});

  @override
  State<CreateTodoWidget> createState() => _CreateTodoWidgetState();
}

class _CreateTodoWidgetState extends State<CreateTodoWidget>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  late AnimationController _animationController;

  bool isSubmitting = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {});
    });

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is FailureState) {
          setState(() {
            isSubmitting = false;
          });

          return;
        }

        if (state is SuccessState && state.type == Type.add) {
          _textEditingController.clear();
          setState(() {
            isSubmitting = false;
          });

          return;
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: _focusNode.hasFocus || isSubmitting
              ? Colors.white
              : Color(0xFFE0E3E6),
          borderRadius: BorderRadius.circular(15),
          boxShadow: _focusNode.hasFocus || isSubmitting
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    offset: Offset(0, 30),
                    blurRadius: 80,
                  ),
                  BoxShadow(
                    color: Colors.black.withAlpha(3),
                    offset: Offset(0, 4),
                    blurRadius: 13,
                  ),
                ]
              : null,
        ),
        child: Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _focusNode.hasFocus || isSubmitting ? 20 : 0,
              height: _focusNode.hasFocus || isSubmitting ? 20 : 0,
              decoration: BoxDecoration(
                color: _focusNode.hasFocus || isSubmitting
                    ? Color(0xFFE7E9EA)
                    : null,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Flexible(
              child: TextFormField(
                controller: _textEditingController,
                focusNode: _focusNode,
                autocorrect: false,
                onTapOutside: (event) {
                  _focusNode.unfocus();
                },
                onFieldSubmitted: (value) {
                  widget.onSubmitted(value);
                  setState(() {
                    isSubmitting = true;
                  });
                },
                style: TextStyle(
                  fontSize: 14,
                  height: 22 / 14,
                  color: Color(0xFF27272B),
                ),
                decoration: InputDecoration(
                  hintText: "Create new task",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    height: 22 / 14,
                    color: Color(0xFF8E939A),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 22,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: isSubmitting
                  ? RotationTransition(
                      turns: _animationController,
                      child: SvgPicture.asset(
                        'assets/svgs/refresh-icon.svg',
                        height: 20,
                        width: 20,
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}

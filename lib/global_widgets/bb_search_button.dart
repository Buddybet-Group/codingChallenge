import 'package:flutter/material.dart';

/// Customized BuddyBet Search Box used around the app.
class BBSearchButton extends StatelessWidget {
  const BBSearchButton({
    Key? key,
    required this.buttonTitle,
    required this.onClick,
  }) : super(key: key);

  /// Title of the button
  final String buttonTitle;

  /// Click event listener
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Material(
          color: const Color(0xFF005898),
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: onClick,
            splashColor: const Color(0xFF009FDF),
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.center,
              child: Text(
                buttonTitle,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class AnimatedTextWIthCard extends StatelessWidget {
  const AnimatedTextWIthCard({
    Key? key,
    required this.title,
    required this.discreption,
    required this.expand,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final String discreption;
  final bool expand;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 18),
                ),
                IconButton(
                  icon: Icon(
                    expand ? Icons.expand_less : Icons.expand_more,
                    color: expand
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: onTap,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Align(
            alignment: Alignment.centerRight,
            child: expand
                ? const SizedBox()
                : Text(
                    discreption,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        //color: Color.fromARGB(255, 139, 139, 145),
                        fontSize: 17),
                    textAlign: TextAlign.start,
                  ),
          ),
        ),
      ],
    );
  }
}

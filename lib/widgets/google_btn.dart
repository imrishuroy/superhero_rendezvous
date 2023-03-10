import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;

  const GoogleSignInButton({
    Key? key,
    @required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 44.0,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: SizedBox(
                    height: 32.0,
                    width: 32.0,
                    child: Image.network(
                      'https://raw.githubusercontent.com/imrishuroy/Yukti/main/assets/google.png',
                    )

                    //Image.asset('assets/google.png'),
                    ),
              ),
              const SizedBox(width: 10.0),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                    fontSize: 16.0,
                    letterSpacing: 1.0,
                    fontFamily: 'Montserrat',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

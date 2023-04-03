import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl5/bloc/bloc/authenticationbloc.dart';
import 'package:pbl5/bloc/bloc/loginemailbloc.dart';
import 'package:provider/provider.dart';

import '../../model/repository/authentication_repository.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          BlocProvider(
            create: (context) => LoginCubit(context.read<AuthRepository>()),
            child: Align(
              alignment: const Alignment(0, -1 / 3),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                        icon: const Icon(
                          Icons.facebook,
                          color: Colors.blue,
                        ),
                        iconSize: 48,
                        title: "Connect with Facebook",
                        titleSize: 15,
                        titleColor: Colors.white,
                        bgColor: Colors.blue,
                        onPressed: () {
                          context.read<LoginCubit>().signInWithFacebook();
                        }),
                    CustomButton(
                        icon: Image.asset(
                          "assets/images/google.png",
                        ),
                        iconSize: 48,
                        title: "Connect with Google",
                        titleSize: 15,
                        titleColor: Colors.black,
                        bgColor: Colors.white,
                        onPressed: () {
                          context.read<LoginCubit>().googleLogin();
                        }),
                    const Text(
                      "Hoặc tham gia bằng số điện thoại",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextField(
                      onChanged: (number) {},
                    ),
                    CustomButton(
                        icon: null,
                        iconSize: 0,
                        title: "Tiếp tục",
                        titleSize: 18,
                        titleColor: Colors.white,
                        bgColor: Colors.red,
                        onPressed: () {})
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

typedef VoidFunc = void Function();

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.icon,
      required this.iconSize,
      required this.title,
      required this.titleSize,
      required this.titleColor,
      required this.bgColor,
      required this.onPressed,
      super.key});
  final Widget? icon;
  final String title;
  final VoidFunc onPressed;
  final double iconSize;
  final double titleSize;
  final Color bgColor;
  final Color titleColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: titleColor,
        alignment: Alignment.center,
        minimumSize: Size.fromHeight(iconSize),
      ),
      label: Text(title),
      onPressed: onPressed,
      icon: icon ?? Container(),
    );
  }
}

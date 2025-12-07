import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgima_chat/utils/routes/app_routes.dart';
import 'package:sgima_chat/view_model/chat/chat_cubit.dart';
import 'package:sgima_chat/views/pages/chat_page.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.chatRoutePage:
      default:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ChatCubit(),
            child: const ChatPage(),
          ),
        );
    }
  }
}

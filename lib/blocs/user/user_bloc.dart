import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserState get initialState => UserInitial();

  @override
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoadUser) {
        UserApp user = await UserServices.getUser(event.id);

        emit(UserLoaded(user));
      } else if (event is SignOut) {
        emit(UserInitial());
      } else if (event is UpdateData) {
        UserApp updatedUser = (state as UserLoaded).user.copyWith(
              name: event.name,
              profilePicture: event.profileImage,
            );

        await UserServices.updateUser(updatedUser);

        emit(UserLoaded(updatedUser));
      } else if (event is TopUp) {
        if (state is UserLoaded) {
          try {
            UserApp updateUser = (state as UserLoaded).user.copyWith(
                balance: (state as UserLoaded).user.balance + event.amount,
                name: '',
                profilePicture: '');

            await UserServices.updateUser(updateUser);
            emit(UserLoaded(updateUser));
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        }
      } else if (event is Purchase) {
        if (state is UserLoaded) {
          try {
            UserApp updateUser = (state as UserLoaded).user.copyWith(
                balance: (state as UserLoaded).user.balance - event.amount,
                name: '',
                profilePicture: '');

            await UserServices.updateUser(updateUser);
            emit(UserLoaded(updateUser));
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        }
      }
    });
  }
}

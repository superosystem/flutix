import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserState get initialState => UserInitial();

  @override
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoadUser) {
        UserModel user = await UserService.getUser(event.id);

        emit(UserLoaded(user));
      } else if (event is SignOut) {
        emit(UserInitial());
      } else if (event is UpdateData) {
        UserModel updatedUser = (state as UserLoaded).user.copyWith(
              name: event.name,
              profilePicture: event.profileImage,
            );

        await UserService.updateUser(updatedUser);

        emit(UserLoaded(updatedUser));
      }
    });
  }
}

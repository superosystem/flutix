import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';

part 'page_event.dart';

part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageState get initialState => OnInitialPage();

  PageBloc() : super(OnInitialPage()) {
    on<PageEvent>((event, emit) async {
      if (event is GoToSplashPage) {
        emit(OnSplashPage());
      } else if (event is GoToMainPage) {
        emit(OnMainPage());
      } else if (event is GoToSignInPage) {
        emit(OnSignInPage());
      } else if (event is GoToSignUpPage) {
        emit(OnSignUpPage(event.signUpData));
      } else if (event is GoToSignUpPreferencePage) {
        emit(OnSignUpPreferencePage(event.signUpData));
      } else if (event is GoToSignUpAccountConfirmationPage) {
        emit(OnSignUpAccountConfirmationPage(event.signUpData));
      }
    });
  }
}

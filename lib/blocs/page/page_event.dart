part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignInPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignUpPage extends PageEvent {
  final SignUpModel signUpData;

  const GoToSignUpPage(this.signUpData);

  @override
  List<Object> get props => [];
}

class GoToSignUpPreferencePage extends PageEvent {
  final SignUpModel signUpData;

  const GoToSignUpPreferencePage(this.signUpData);

  @override
  List<Object> get props => [];
}

class GoToSignUpAccountConfirmationPage extends PageEvent {
  final SignUpModel signUpData;

  const GoToSignUpAccountConfirmationPage(this.signUpData);

  @override
  List<Object> get props => [];
}

class GoToMovieDetailPage extends PageEvent {
  final Movie movie;

  const GoToMovieDetailPage(this.movie);

  @override
  List<Object> get props => [];
}

class GoToSelectSchedulePage extends PageEvent {
  final MovieDetail movieDetail;

  const GoToSelectSchedulePage(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

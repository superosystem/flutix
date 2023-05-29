part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnInitialPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSignInPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSignUpPage extends PageState {
  final SignUpModel signUpData;

  const OnSignUpPage(this.signUpData);

  @override
  List<Object> get props => [];
}

class OnSignUpPreferencePage extends PageState {
  final SignUpModel signUpData;

  const OnSignUpPreferencePage(this.signUpData);

  @override
  List<Object> get props => [];
}

class OnSignUpAccountConfirmationPage extends PageState {
  final SignUpModel signUpData;

  const OnSignUpAccountConfirmationPage(this.signUpData);

  @override
  List<Object> get props => [];
}

class OnMovieDetailPage extends PageState {
  final Movie movie;

  const OnMovieDetailPage(this.movie);
  @override
  List<Object> get props => [movie];
}

class OnSelectSchedulePage extends PageState {
  final MovieDetail movieDetail;

  const OnSelectSchedulePage(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnSelectSeatPage extends PageState {
  final Ticket ticket;

  const OnSelectSeatPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}
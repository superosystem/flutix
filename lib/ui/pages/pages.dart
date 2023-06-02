import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:random_string/random_string.dart';

import '../../blocs/blocs.dart';
import '../../extensions/extensions.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../shared/shared.dart';
import '../widgets/widgets.dart';

part 'auth/account_confirmation_page.dart';

part 'auth/preference_page.dart';

part 'auth/sign_in_page.dart';

part 'auth/sign_up_page.dart';

part 'book/checkout_page.dart';

part 'book/select_schedule_page.dart';

part 'book/select_seat_page.dart';

part 'main_page.dart';

part 'movie/movie_detail_page.dart';

part 'movie/movie_page.dart';

part 'profile/edit_profile_page.dart';

part 'profile/profile_page.dart';

part 'splash/splash_page.dart';

part 'info/success_page.dart';

part 'ticket/ticket_detail_page.dart';

part 'ticket/ticket_page.dart';

part 'wrapper.dart';

part 'wallet/top_up_page.dart';

part 'wallet/wallet_page.dart';

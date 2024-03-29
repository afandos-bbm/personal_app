import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/core/shared_preferences_service/shared_preferences_service.dart';
import 'package:flutter/foundation.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState());

  String get locale => state.selectedLanguage;

  Future<void> changeLanguage(String language) async {
    locator<SharedPreferencesService>().selectedLanguage = language;
    emit(state.copyWith(selectedLanguage: language));
  }

  Future<void> loadLanguagePreference() async {
    var savedLanguage = locator<SharedPreferencesService>().selectedLanguage;

    if (savedLanguage.isEmpty) {
      savedLanguage = PlatformDispatcher.instance.locale.languageCode;
    }

    emit(state.copyWith(selectedLanguage: savedLanguage));
  }
}

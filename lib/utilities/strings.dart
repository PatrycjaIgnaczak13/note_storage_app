import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Strings {
  Strings(this.locale);

  static const StringsDelegate delegate = StringsDelegate();

  final Locale locale;

  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings)!;
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    "en": {
      //home screen screen
      "notes": "Notes",
      "date_format" : "kk:mm, EEEE MM yyyy",
      //add note screen
      "add_note" : "Add Note",
      "your_note" : "Your note",
      "save" : "save",
      "snackbar_error_msg" : "Sotehing went wrong :( Try again",
    },
  };

  String get notes {
    return _localizedValues[locale.languageCode]!["notes"]!;
  }

  String get addNote {
    return _localizedValues[locale.languageCode]!["add_note"]!;
  }

  String get yourNote {
    return _localizedValues[locale.languageCode]!["your_note"]!;
  }

  String get dateFormat {
    return _localizedValues[locale.languageCode]!["date_format"]!;
  }

  String get save {
    return _localizedValues[locale.languageCode]!["save"]!;
  }

  String get snackBarErrorMsg {
    return _localizedValues[locale.languageCode]!["snackbar_error_msg"]!;
  }
}

class StringsDelegate extends LocalizationsDelegate<Strings> {
  const StringsDelegate();

  @override
  bool isSupported(Locale locale) => ["en"].contains(locale.languageCode);

  @override
  Future<Strings> load(Locale locale) {
    return SynchronousFuture<Strings>(Strings(locale));
  }

  @override
  bool shouldReload(StringsDelegate old) => false;
}

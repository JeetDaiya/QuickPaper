enum Subject {
  science,
  socialScience,
  english
}

extension SubjectX on Subject {
  String get label {
    switch (this) {
      case Subject.science:
        return 'Science';
      case Subject.socialScience:
        return 'Social Science';
      case Subject.english:
        return 'English';
    }
  }

  String get apiKey {
    switch (this) {
      case Subject.science:
        return 'sci';
      case Subject.socialScience:
        return 'ss';
      case Subject.english:
        return 'eng';
    }
  }
}
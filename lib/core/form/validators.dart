import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:intl/intl.dart';

class Validators {
  /// [FormFieldValidator] that requires the field have a non-empty value.
  static FormFieldValidator name_required({
    String errorText = "Name is required.",
    String errorinvalidText = "Name does not Exit.",
  }) {
    return (valueCandidate) {
      print(valueCandidate.length);
      if (valueCandidate == null ||
          ((valueCandidate is Iterable ||
                  valueCandidate is String ||
                  valueCandidate is Map) &&
              valueCandidate.length == 0)) {
        return errorText;
      }

      return null;
    };
  }
}

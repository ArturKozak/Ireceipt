import 'package:flutter_animate/flutter_animate.dart';

class AppConstants {
  const AppConstants._();
  static final animDuration = 700.ms;
  static final halfAnimDuration = 350.ms;
  static const padding = 16.0;
  static const productNameCollection = 'productNameCollection';

  static final moneyExp = RegExp(r'([0-9]{1,3}(\,|\.)\s?[0-9]{2})');
  static final moneyCategoryExp = RegExp(r'([0-9]{1,3}\,\s?[0-9]{2}\s?[ABD])');
  static final dateExp =
      RegExp(r'[0-9]{1,4}\-[0-9]{2}\-[0-9]{2}\s[0-9]{2}\:[0-9]{2}');
  static final drExp = RegExp(r'([Dd][Rr])');
  static final adresExp = RegExp(r'([Aa][Dd][Rr][Ee][Ss])');
  static final nipExp = RegExp(r'([Nn][Ii][Pp])');
  static final spExp = RegExp(r'([Ss][Pp]\.\s)');
  static final ulExp = RegExp(r'([Uu][Ll]\.\s?)');
  static final nrSpaceExp = RegExp(r'([Nr][Rr]\:\s?)');
  static final nrExp = RegExp(r'([Nr][Rr]\s)');
  static final rabatExp = RegExp(r'([Rr][Aa][Bb][Aa][Tt])');
  static final paragonExp = RegExp(r'([Pp][Aa][Rr][Aa][Gg][Oo][Nn])');
  static final kartaExp = RegExp(r'([Ka][Aa][Rr][Tt[Aa])');
  static final categoryExp = RegExp(r'\s?[ABD]\s');
  static final numCategoryExp = RegExp(r'[0-9][ABD]\s?');
  static final totalExp = RegExp(r'([Ss][Uu][Mm][Aa]\s?[Pp][Ll][Nn])');
  static final ptuSumExp = RegExp(r'([Ss][Uu][Mm][Aa]\s?[Pp][Tt][Uu])');
  static final podatekSumExp =
      RegExp(r'([Pp][Oo][Dd][Aa][Tt][Ee][kk]\s?[Pp][Tt][Uu])');
  static final ptuExp = RegExp(r'[Pp][Tt][Uu]\s');
  static final kwotaExp = RegExp(r'[Kk][Ww]?[Uu]?[Oo][Tt][Aa]\s');
  static final spredExp = RegExp(r'[Ss][Pp][Rr][Zz][Ee][Dd][Aa]?[Żż]?[Zz]?');
  static final quantityExp = RegExp(
    r'[0-9]\,?\s?[0-9]?[0-9]?[0-9]?\s?[a-z][0-9]{1,3}\s?\,\s?[0-9]{1,3}',
  );
  static final quantityTwoExp = RegExp(
    r'[0-9]\,?\s?[0-9]?[0-9]?[0-9]?\s?\*\s?[0-9]{1,3}\s?\,\s?[0-9]{1,3}',
  );
}

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get onBoardingWelcome {
    return Intl.message(
      'Welcome',
      name: 'onBoardingWelcome',
      desc: '',
      args: [],
    );
  }

  /// `to our store`
  String get onBoardingToOurStore {
    return Intl.message(
      'to our store',
      name: 'onBoardingToOurStore',
      desc: '',
      args: [],
    );
  }

  /// `Ger your groceries in as fast as one hour`
  String get onBoardingSubTitle {
    return Intl.message(
      'Ger your groceries in as fast as one hour',
      name: 'onBoardingSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get onBoardingGetStarted {
    return Intl.message(
      'Get Started',
      name: 'onBoardingGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Exclusive Offer`
  String get homeExclusiveOffer {
    return Intl.message(
      'Exclusive Offer',
      name: 'homeExclusiveOffer',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get homeSeeAll {
    return Intl.message(
      'See all',
      name: 'homeSeeAll',
      desc: '',
      args: [],
    );
  }

  /// `Best Selling`
  String get homeBestSelling {
    return Intl.message(
      'Most Selling',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Groceries`
  String get homeGroceries {
    return Intl.message(
      'Groceries',
      name: 'homeGroceries',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `Nutritions`
  String get nutritions {
    return Intl.message(
      'Nutritions',
      name: 'nutritions',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Add To Basket`
  String get addToBasket {
    return Intl.message(
      'Add To Basket',
      name: 'addToBasket',
      desc: '',
      args: [],
    );
  }

  /// `Find Products`
  String get findProduct {
    return Intl.message(
      'Find Products',
      name: 'findProduct',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

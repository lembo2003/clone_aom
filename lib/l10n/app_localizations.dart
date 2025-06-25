import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Language selection label
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// English language name
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Vietnamese language name
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese;

  /// Navigation label for PDF demo
  ///
  /// In en, this message translates to:
  /// **'Go to PDF DEMO'**
  String get goToPdfDemo;

  /// All items label
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Tasks assigned to current user
  ///
  /// In en, this message translates to:
  /// **'Assigned to me'**
  String get assignedToMe;

  /// Employee list label
  ///
  /// In en, this message translates to:
  /// **'Employee List'**
  String get employeeList;

  /// All the texts that have login
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginText;

  /// Username label
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get userName;

  /// Password label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Default session label
  ///
  /// In en, this message translates to:
  /// **'Default Session?'**
  String get defaultSession;

  /// No description provided for @detailHomeLabel.
  ///
  /// In en, this message translates to:
  /// **'Employee detail:'**
  String get detailHomeLabel;

  /// No description provided for @detailEmployee_basicInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic information'**
  String get detailEmployee_basicInformation;

  /// No description provided for @detailEmployee_attendanceCode.
  ///
  /// In en, this message translates to:
  /// **'Attendance Code'**
  String get detailEmployee_attendanceCode;

  /// No description provided for @detailEmployee_recordID.
  ///
  /// In en, this message translates to:
  /// **'Record ID'**
  String get detailEmployee_recordID;

  /// No description provided for @detailEmployee_employeeName.
  ///
  /// In en, this message translates to:
  /// **'Employee Name'**
  String get detailEmployee_employeeName;

  /// No description provided for @detailEmployee_birthDate.
  ///
  /// In en, this message translates to:
  /// **'BirthDate'**
  String get detailEmployee_birthDate;

  /// No description provided for @detailEmployee_gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get detailEmployee_gender;

  /// No description provided for @detailEmployee_pob.
  ///
  /// In en, this message translates to:
  /// **'Place of birth'**
  String get detailEmployee_pob;

  /// No description provided for @detailEmployee_nationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get detailEmployee_nationality;

  /// No description provided for @detailEmployee_ethnicGroup.
  ///
  /// In en, this message translates to:
  /// **'Ethnic Group'**
  String get detailEmployee_ethnicGroup;

  /// No description provided for @detailEmployee_maritalStatus.
  ///
  /// In en, this message translates to:
  /// **'Marital Status'**
  String get detailEmployee_maritalStatus;

  /// No description provided for @detailEmployee_religion.
  ///
  /// In en, this message translates to:
  /// **'Religion'**
  String get detailEmployee_religion;

  /// No description provided for @detailEmployee_highSchoolLevel.
  ///
  /// In en, this message translates to:
  /// **'High school level'**
  String get detailEmployee_highSchoolLevel;

  /// No description provided for @detailEmployee_specialization.
  ///
  /// In en, this message translates to:
  /// **'Specialization'**
  String get detailEmployee_specialization;

  /// No description provided for @detailEmployee_personalTaxCode.
  ///
  /// In en, this message translates to:
  /// **'Personal Tax Code'**
  String get detailEmployee_personalTaxCode;

  /// No description provided for @detailEmployee_citizenIdentificationInfo.
  ///
  /// In en, this message translates to:
  /// **'Citizen Identification Info'**
  String get detailEmployee_citizenIdentificationInfo;

  /// No description provided for @detailEmployee_citizenID.
  ///
  /// In en, this message translates to:
  /// **'Citizen ID'**
  String get detailEmployee_citizenID;

  /// No description provided for @detailEmployee_issueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue Date'**
  String get detailEmployee_issueDate;

  /// No description provided for @detailEmployee_issuePlace.
  ///
  /// In en, this message translates to:
  /// **'Issue Place'**
  String get detailEmployee_issuePlace;

  /// No description provided for @detailEmployee_frontIdCard.
  ///
  /// In en, this message translates to:
  /// **'Front ID Card'**
  String get detailEmployee_frontIdCard;

  /// No description provided for @detailEmployee_backIdCard.
  ///
  /// In en, this message translates to:
  /// **'Back ID Card'**
  String get detailEmployee_backIdCard;

  /// No description provided for @detailEmployee_bankAccount.
  ///
  /// In en, this message translates to:
  /// **'Bank Account'**
  String get detailEmployee_bankAccount;

  /// No description provided for @detailEmployee_bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get detailEmployee_bankName;

  /// No description provided for @detailEmployee_cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get detailEmployee_cardNumber;

  /// No description provided for @detailEmployee_accountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get detailEmployee_accountName;

  /// No description provided for @detailEmployee_health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get detailEmployee_health;

  /// No description provided for @detailEmployee_height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get detailEmployee_height;

  /// No description provided for @detailEmployee_weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get detailEmployee_weight;

  /// No description provided for @detailEmployee_bloodType.
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get detailEmployee_bloodType;

  /// No description provided for @detailEmployee_attachment.
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get detailEmployee_attachment;

  /// No description provided for @detailEmployee_contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get detailEmployee_contactInfo;

  /// No description provided for @detailEmployee_phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get detailEmployee_phoneNumber;

  /// No description provided for @detailEmployee_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get detailEmployee_email;

  /// No description provided for @detailEmployee_houseNumber.
  ///
  /// In en, this message translates to:
  /// **'House Number, Street'**
  String get detailEmployee_houseNumber;

  /// No description provided for @detailEmployee_wardCity.
  ///
  /// In en, this message translates to:
  /// **'Ward, District, City'**
  String get detailEmployee_wardCity;

  /// No description provided for @detailEmployee_familyInfo.
  ///
  /// In en, this message translates to:
  /// **'Family Information'**
  String get detailEmployee_familyInfo;

  /// No description provided for @detailEmployee_relativeRelationship.
  ///
  /// In en, this message translates to:
  /// **'Relative Relationship'**
  String get detailEmployee_relativeRelationship;

  /// No description provided for @detailEmployee_relativeName.
  ///
  /// In en, this message translates to:
  /// **'Relative Name'**
  String get detailEmployee_relativeName;

  /// No description provided for @detailEmployee_relativePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get detailEmployee_relativePhoneNumber;

  /// No description provided for @detailEmployee_relativeCitizenID.
  ///
  /// In en, this message translates to:
  /// **'Citizen ID'**
  String get detailEmployee_relativeCitizenID;

  /// No description provided for @detailEmployee_relativeIssueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue Date'**
  String get detailEmployee_relativeIssueDate;

  /// No description provided for @detailEmployee_relativeIssuePlace.
  ///
  /// In en, this message translates to:
  /// **'Issue Place'**
  String get detailEmployee_relativeIssuePlace;

  /// No description provided for @detailEmployee_relativeDependant.
  ///
  /// In en, this message translates to:
  /// **'Dependant?'**
  String get detailEmployee_relativeDependant;

  /// No description provided for @detailEmployee_relativeTaxCode.
  ///
  /// In en, this message translates to:
  /// **'Tax Code'**
  String get detailEmployee_relativeTaxCode;

  /// No description provided for @detailEmployee_workExp.
  ///
  /// In en, this message translates to:
  /// **'Work Experiences'**
  String get detailEmployee_workExp;

  /// No description provided for @detailEmployee_workExpCompany.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get detailEmployee_workExpCompany;

  /// No description provided for @detailEmployee_workExpRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get detailEmployee_workExpRole;

  /// No description provided for @detailEmployee_workExpFrom.
  ///
  /// In en, this message translates to:
  /// **'From Date'**
  String get detailEmployee_workExpFrom;

  /// No description provided for @detailEmployee_workExpTo.
  ///
  /// In en, this message translates to:
  /// **'To Date'**
  String get detailEmployee_workExpTo;

  /// No description provided for @detailEmployee_workExpLeave.
  ///
  /// In en, this message translates to:
  /// **'Reason for Leaving'**
  String get detailEmployee_workExpLeave;

  /// No description provided for @detailEmployee_cert.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get detailEmployee_cert;

  /// No description provided for @detailEmployee_certName.
  ///
  /// In en, this message translates to:
  /// **'Certificate Name'**
  String get detailEmployee_certName;

  /// No description provided for @detailEmployee_certClass.
  ///
  /// In en, this message translates to:
  /// **'Classification'**
  String get detailEmployee_certClass;

  /// No description provided for @detailEmployee_certIssueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue Date'**
  String get detailEmployee_certIssueDate;

  /// No description provided for @detailEmployee_certAttachment.
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get detailEmployee_certAttachment;

  /// No description provided for @documentPage_title.
  ///
  /// In en, this message translates to:
  /// **'Document Page'**
  String get documentPage_title;

  /// No description provided for @documentPage_searchBar.
  ///
  /// In en, this message translates to:
  /// **'Search files and folders'**
  String get documentPage_searchBar;

  /// No description provided for @documentPage_storage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get documentPage_storage;

  /// No description provided for @documentPage_upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get documentPage_upload;

  /// No description provided for @documentPage_newFolder.
  ///
  /// In en, this message translates to:
  /// **'New Folder'**
  String get documentPage_newFolder;

  /// No description provided for @documentPage_download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get documentPage_download;

  /// No description provided for @documentPage_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get documentPage_share;

  /// No description provided for @documentPage_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get documentPage_delete;

  /// No description provided for @documentPage_rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get documentPage_rename;

  /// No description provided for @documentPage_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get documentPage_back;

  /// No description provided for @loginScreen_rights.
  ///
  /// In en, this message translates to:
  /// **'@ 2025 Intechno. All rights reserved'**
  String get loginScreen_rights;

  /// No description provided for @loginScreen_version.
  ///
  /// In en, this message translates to:
  /// **'Version alpha 0.0.1'**
  String get loginScreen_version;

  /// No description provided for @filePicker_selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select File'**
  String get filePicker_selectFile;

  /// No description provided for @filePicker_selectedFile.
  ///
  /// In en, this message translates to:
  /// **'Selected File'**
  String get filePicker_selectedFile;

  /// No description provided for @filePicker_upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get filePicker_upload;

  /// No description provided for @filePicker_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get filePicker_name;

  /// No description provided for @filePicker_size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get filePicker_size;

  /// No description provided for @filePicker_parentId.
  ///
  /// In en, this message translates to:
  /// **'Uploading to folder with ID'**
  String get filePicker_parentId;

  /// No description provided for @filePicker_changeFile.
  ///
  /// In en, this message translates to:
  /// **'Change File'**
  String get filePicker_changeFile;

  /// No description provided for @documentPage_getSharableLink.
  ///
  /// In en, this message translates to:
  /// **'Get Sharable Link'**
  String get documentPage_getSharableLink;

  /// No description provided for @documentPage_info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get documentPage_info;

  /// No description provided for @documentPage_tag.
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get documentPage_tag;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

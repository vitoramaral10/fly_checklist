// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Fly Checklist';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonCreate => 'Create';

  @override
  String get commonUpdate => 'Update';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonSend => 'Send';

  @override
  String get commonClose => 'Close';

  @override
  String get commonOk => 'OK';

  @override
  String get commonGotIt => 'Got it';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get commonOr => 'OR';

  @override
  String get errorDialogTitle => 'Something went wrong';

  @override
  String get successDialogTitle => 'Success!';

  @override
  String get confirmationDialogTitle => 'Confirmation';

  @override
  String get confirmationDialogContent => 'Are you sure you want to continue?';

  @override
  String get successSnackbarTitle => 'Success';

  @override
  String get successSnackbarMessage => 'Done.';

  @override
  String get errorUnexpected =>
      'Something unexpected happened. Please try again later.';

  @override
  String get errorInvalidEmail =>
      'That email address is not valid. Please check it and try again.';

  @override
  String get errorEmailInUse =>
      'This email is already in use. Please try a different one.';

  @override
  String get errorWeakPassword =>
      'That password is too weak. Please pick a stronger one.';

  @override
  String get errorInvalidCredential =>
      'Those credentials are not valid. Please check them and try again.';

  @override
  String get errorEmailNotVerified =>
      'Your email has not been verified yet. Please check your inbox and follow the instructions to activate your account.';

  @override
  String get errorInvalidDueDate =>
      'The due date cannot be earlier than today.';

  @override
  String get errorCancelled => 'Operation cancelled.';

  @override
  String get fieldEmailLabel => 'Email';

  @override
  String get fieldPasswordLabel => 'Password';

  @override
  String get fieldConfirmPasswordLabel => 'Confirm your password';

  @override
  String get fieldFullNameLabel => 'Full name';

  @override
  String get fieldCurrentPasswordLabel => 'Current password';

  @override
  String get fieldNewPasswordLabel => 'New password';

  @override
  String get fieldConfirmNewPasswordLabel => 'Confirm new password';

  @override
  String get passwordShowTooltip => 'Show password';

  @override
  String get passwordHideTooltip => 'Hide password';

  @override
  String get validatorEmailRequired => 'Please enter your email.';

  @override
  String get validatorEmailInvalid => 'Please enter a valid email.';

  @override
  String get validatorEmailInvalidShort => 'Invalid email.';

  @override
  String get validatorPasswordRequired => 'Please enter your password.';

  @override
  String get validatorPasswordMinLength =>
      'The password must be at least 6 characters long.';

  @override
  String get validatorConfirmPasswordRequired =>
      'Please confirm your password.';

  @override
  String get validatorPasswordsDoNotMatch => 'The passwords do not match.';

  @override
  String get validatorFullNameRequired => 'Please enter your full name.';

  @override
  String get validatorCurrentPasswordRequired =>
      'Please enter your current password.';

  @override
  String get validatorNewPasswordRequired => 'Please enter the new password.';

  @override
  String get validatorNewPasswordMinLength =>
      'The new password must be at least 6 characters long.';

  @override
  String get validatorConfirmNewPasswordRequired =>
      'Please confirm the new password.';

  @override
  String get validatorGroupNameRequired => 'Please enter the group name.';

  @override
  String get validatorTaskTitleRequired => 'Please enter the task title.';

  @override
  String get validatorDueDateInPast => 'The date cannot be earlier than today.';

  @override
  String get validatorDueDateInvalid => 'Invalid date.';

  @override
  String get validatorPriorityRequired => 'Please select the task priority.';

  @override
  String get validatorPriorityRange => 'Priority must be between 0 and 4.';

  @override
  String get homeTagline => 'Organize your tasks and reach your goals, simply.';

  @override
  String get homeSignIn => 'Sign in to my account';

  @override
  String get homeSignUp => 'Create account';

  @override
  String get signInAppBarTitle => 'Sign in';

  @override
  String get signInWelcomeTitle => 'Welcome back!';

  @override
  String get signInWelcomeSubtitle => 'Sign in to continue.';

  @override
  String get signInForgotPassword => 'I forgot my password';

  @override
  String get signInSubmit => 'Sign in';

  @override
  String get signInGoToSignUp => 'No account yet? Sign up';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get signUpAppBarTitle => 'Create account';

  @override
  String get signUpWelcomeTitle => 'Welcome!';

  @override
  String get signUpWelcomeSubtitle =>
      'Fill in the fields below to create your account.';

  @override
  String get signUpSubmit => 'CREATE ACCOUNT';

  @override
  String get signUpSubmitLoading => 'Creating...';

  @override
  String get signUpGoToSignIn => 'Already have an account? Sign in';

  @override
  String get signUpOrContinueWith => 'Or continue with';

  @override
  String get forgotPasswordTitle => 'Reset password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email to receive recovery instructions.';

  @override
  String get forgotPasswordSuccess =>
      'Recovery instructions sent to your email.';

  @override
  String get emailVerificationTitle => 'Check your email';

  @override
  String get emailVerificationMessage =>
      'We sent a verification link to your email. Please check your inbox and follow the instructions to activate your account.';

  @override
  String get emailVerificationContinue => 'I verified it, continue';

  @override
  String get emailVerificationResend => 'Resend verification email';

  @override
  String get emailVerificationResentSuccess =>
      'Verification email sent again. Please check your inbox.';

  @override
  String get emailVerificationBackToLogin => 'Back to sign in';

  @override
  String get dashboardGreeting => 'Hi,';

  @override
  String get dashboardLoadErrorTitle => 'We could not load your data';

  @override
  String get dashboardQuickTasksTitle => 'Quick tasks';

  @override
  String get dashboardNoQuickTasksTitle => 'No quick tasks';

  @override
  String get dashboardNoQuickTasksMessage =>
      'Create a new task to get started.';

  @override
  String get dashboardGroupsTitle => 'Task groups';

  @override
  String get dashboardNewGroup => 'New group';

  @override
  String get addTaskButtonLabel => 'Add task';

  @override
  String get addGroupButtonLabel => 'Add group';

  @override
  String groupCardTasksCount(int completed, int total) {
    return '$completed/$total tasks';
  }

  @override
  String get taskSheetCreateTitle => 'New task';

  @override
  String get taskSheetEditTitle => 'Edit task';

  @override
  String get taskSheetSubtitle => 'Enter the details of the new task here.';

  @override
  String get taskFieldTitleLabel => 'Task title';

  @override
  String get taskFieldDescriptionLabel => 'Task description';

  @override
  String get taskFieldDueDateLabel => 'Due date';

  @override
  String get taskFieldGroupLabel => 'Group (optional)';

  @override
  String get taskGroupNone => 'No group';

  @override
  String get taskFieldPriorityLabel => 'Priority';

  @override
  String get taskPriorityNone => 'No priority';

  @override
  String get taskPriorityLow => 'Low';

  @override
  String get taskPriorityMedium => 'Medium';

  @override
  String get taskPriorityHigh => 'High';

  @override
  String get taskPriorityCritical => 'Critical';

  @override
  String taskPrioritySemanticLabel(String priority) {
    return 'Priority: $priority';
  }

  @override
  String taskCheckboxLabelDone(String title) {
    return '$title, done';
  }

  @override
  String taskCheckboxLabelPending(String title) {
    return '$title, pending';
  }

  @override
  String get taskCreatedSuccess => 'Task created.';

  @override
  String get taskUpdatedSuccess => 'Task updated.';

  @override
  String get taskDeletedSuccess => 'Task deleted.';

  @override
  String get taskDeleteConfirmTitle => 'Delete task';

  @override
  String get taskDeleteConfirmContent =>
      'Are you sure you want to delete this task? This action cannot be undone.';

  @override
  String get taskDeletedSnackbarTitle => 'Task deleted';

  @override
  String taskDeletedSnackbarMessage(String title) {
    return 'Task \"$title\" was deleted.';
  }

  @override
  String get taskDeleteErrorTitle => 'Could not delete the task';

  @override
  String get taskDeleteErrorMessage =>
      'We could not delete the task. Please try again later.';

  @override
  String get taskUpdateErrorTitle => 'Could not update the task';

  @override
  String get taskUpdateErrorMessage =>
      'We could not update the task status. Please try again later.';

  @override
  String get groupSheetCreateTitle => 'New group';

  @override
  String get groupSheetEditTitle => 'Edit group';

  @override
  String get groupSheetSubtitle => 'Set up the details of your task group.';

  @override
  String get groupFieldNameLabel => 'Group name';

  @override
  String get groupFieldDescriptionLabel => 'Description (optional)';

  @override
  String get groupColorLabel => 'Group color';

  @override
  String get groupIconLabel => 'Group icon';

  @override
  String get groupColorThemeName => 'Theme color';

  @override
  String get groupColorRed => 'Red';

  @override
  String get groupColorGreen => 'Green';

  @override
  String get groupColorBlue => 'Blue';

  @override
  String get groupColorOrange => 'Orange';

  @override
  String get groupColorPurple => 'Purple';

  @override
  String get groupColorTeal => 'Teal';

  @override
  String get groupColorPink => 'Pink';

  @override
  String get groupColorIndigo => 'Indigo';

  @override
  String get groupColorBrown => 'Brown';

  @override
  String get groupIconChecklist => 'Checklist';

  @override
  String get groupIconList => 'List';

  @override
  String get groupIconTask => 'Completed task';

  @override
  String get groupIconAssignment => 'Form';

  @override
  String get groupIconWork => 'Work';

  @override
  String get groupIconHome => 'Home';

  @override
  String get groupIconSchool => 'School';

  @override
  String get groupIconFitness => 'Fitness';

  @override
  String get groupIconShopping => 'Shopping';

  @override
  String get groupIconRestaurant => 'Restaurant';

  @override
  String get groupIconCarRepair => 'Car maintenance';

  @override
  String get groupIconFlight => 'Travel';

  @override
  String get groupIconMedical => 'Health';

  @override
  String get groupIconPets => 'Pets';

  @override
  String get groupIconSports => 'Sports';

  @override
  String get groupMenuTooltip => 'Group options';

  @override
  String get groupSaveCheckStateTitle => 'Keep checked items';

  @override
  String get groupSaveCheckStateOn =>
      'Checked items stay checked between sessions';

  @override
  String get groupSaveCheckStateOff =>
      'Checked items reset on every new session';

  @override
  String get groupSheetCreateButton => 'Create group';

  @override
  String get groupSheetUpdateButton => 'Update group';

  @override
  String get groupCreatedSuccess => 'Group created.';

  @override
  String get groupUpdatedSuccess => 'Group updated.';

  @override
  String get groupSaveUnexpectedError =>
      'Unexpected error while saving the group';

  @override
  String get groupDelete => 'Delete group';

  @override
  String get groupDeleteConfirmContent =>
      'Are you sure you want to delete this group? All tasks in it will be removed too. This action cannot be undone.';

  @override
  String get groupDeletedSuccess => 'Group deleted.';

  @override
  String get groupDeleteError => 'Could not delete the group';

  @override
  String groupLoadError(String message) {
    return 'Could not load the group: $message';
  }

  @override
  String get groupNotFound => 'Group not found.';

  @override
  String get groupEdit => 'Edit group';

  @override
  String get groupDescriptionLabel => 'Description';

  @override
  String get groupTasksTitle => 'Tasks';

  @override
  String get groupNewTask => 'New task';

  @override
  String get groupNoTasksTitle => 'Nothing here yet';

  @override
  String get groupNoTasksMessage =>
      'Start by adding the first task to this group.';

  @override
  String get groupReusableChecklistBadge =>
      'Reusable checklist: the checks reset every day.';

  @override
  String get groupResetChecklist => 'Reset checklist';

  @override
  String groupResetConfirmContent(String name) {
    return 'Every task in \"$name\" will be unchecked. The tasks themselves are not deleted.';
  }

  @override
  String get groupResetConfirmAction => 'Reset';

  @override
  String get groupResetSuccessTitle => 'Checklist reset';

  @override
  String groupResetSuccessMessage(String name) {
    return 'The tasks in \"$name\" were unchecked.';
  }

  @override
  String get groupResetErrorTitle => 'Could not reset the checklist';

  @override
  String get groupResetErrorMessage =>
      'We could not uncheck the tasks. Please try again later.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLoadErrorTitle => 'We could not load your settings';

  @override
  String get settingsUserFallbackName => 'User';

  @override
  String get settingsEmailUnavailable => 'Email unavailable';

  @override
  String get settingsSectionAccount => 'Account';

  @override
  String get settingsChangePassword => 'Change password';

  @override
  String get settingsManageAccount => 'Manage account';

  @override
  String get settingsSectionPreferences => 'Preferences';

  @override
  String get settingsThemeLabel => 'Theme';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsSectionOther => 'Other';

  @override
  String get settingsAbout => 'About the app';

  @override
  String get settingsPrivacyPolicy => 'Privacy policy';

  @override
  String get settingsTermsOfService => 'Terms of service';

  @override
  String get settingsLogout => 'Sign out';

  @override
  String get settingsLogoutErrorTitle => 'Could not sign out';

  @override
  String get changePasswordSubmit => 'Save changes';

  @override
  String get changePasswordSuccess => 'Password changed.';

  @override
  String get aboutIntro =>
      'Fly Checklist is a fresh take on task management that borrows the aviation checklist methodology to streamline your day.\n\nThe trick is being able to create groups of \"non-persistent\" checklists. While a traditional to-do list saves your check marks, Fly Checklist lets certain lists go back to their original state after use, which makes it perfect for recurring routines.';

  @override
  String get aboutFeaturesTitle => 'Key features:';

  @override
  String get aboutFeatureReusableTitle => 'Reusable checklists:';

  @override
  String get aboutFeatureReusableDescription =>
      'The core feature. Create a list for a routine (making breakfast, your workout routine) and it will always be ready and unchecked for next time, saving you time and effort.';

  @override
  String get aboutFeatureAviationTitle => 'Aviation methodology:';

  @override
  String get aboutFeatureAviationDescription =>
      'Brings discipline and precision to make sure no step of an important process gets skipped.';

  @override
  String get aboutFeatureGroupingTitle => 'Smart grouping:';

  @override
  String get aboutFeatureGroupingDescription =>
      'Organize several checklists into themed groups (\"Morning\", \"End of day\", \"Project X\") and keep your personal and professional life perfectly in order.';

  @override
  String get aboutFeatureFlexibilityTitle => 'Full flexibility:';

  @override
  String get aboutFeatureFlexibilityDescription =>
      'Great for a simple to-do list and just as good for complex processes that need a verified sequence of steps.';

  @override
  String get aboutClosing =>
      'Fly Checklist is the definitive tool for turning routines into solid, efficient habits.';

  @override
  String aboutVersion(String version) {
    return 'Version $version';
  }

  @override
  String get aboutDeveloper => 'Developed by Vitor Melo';

  @override
  String aboutCopyright(String year) {
    return '© $year Fly Checklist. All rights reserved.';
  }
}

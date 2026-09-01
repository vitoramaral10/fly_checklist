import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// Nome do aplicativo, exibido no título da janela e na home
  ///
  /// In pt, this message translates to:
  /// **'Fly Checklist'**
  String get appTitle;

  /// No description provided for @commonCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get commonConfirm;

  /// No description provided for @commonCreate.
  ///
  /// In pt, this message translates to:
  /// **'Criar'**
  String get commonCreate;

  /// No description provided for @commonUpdate.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar'**
  String get commonUpdate;

  /// No description provided for @commonDelete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get commonDelete;

  /// No description provided for @commonSend.
  ///
  /// In pt, this message translates to:
  /// **'Enviar'**
  String get commonSend;

  /// No description provided for @commonClose.
  ///
  /// In pt, this message translates to:
  /// **'Fechar'**
  String get commonClose;

  /// No description provided for @commonOk.
  ///
  /// In pt, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonGotIt.
  ///
  /// In pt, this message translates to:
  /// **'Entendi'**
  String get commonGotIt;

  /// No description provided for @commonRetry.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get commonRetry;

  /// No description provided for @commonLoading.
  ///
  /// In pt, this message translates to:
  /// **'Carregando...'**
  String get commonLoading;

  /// No description provided for @commonOr.
  ///
  /// In pt, this message translates to:
  /// **'OU'**
  String get commonOr;

  /// No description provided for @errorDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro'**
  String get errorDialogTitle;

  /// No description provided for @successDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sucesso!'**
  String get successDialogTitle;

  /// No description provided for @confirmationDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Confirmação'**
  String get confirmationDialogTitle;

  /// No description provided for @confirmationDialogContent.
  ///
  /// In pt, this message translates to:
  /// **'Você tem certeza que deseja continuar?'**
  String get confirmationDialogContent;

  /// No description provided for @successSnackbarTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sucesso'**
  String get successSnackbarTitle;

  /// No description provided for @successSnackbarMessage.
  ///
  /// In pt, this message translates to:
  /// **'Ação realizada com sucesso.'**
  String get successSnackbarMessage;

  /// No description provided for @errorUnexpected.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro inesperado. Por favor, tente novamente mais tarde.'**
  String get errorUnexpected;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In pt, this message translates to:
  /// **'O e-mail informado é inválido. Por favor, verifique e tente novamente.'**
  String get errorInvalidEmail;

  /// No description provided for @errorEmailInUse.
  ///
  /// In pt, this message translates to:
  /// **'Este e-mail já está em uso. Por favor, tente com outro e-mail.'**
  String get errorEmailInUse;

  /// No description provided for @errorWeakPassword.
  ///
  /// In pt, this message translates to:
  /// **'A senha informada é muito fraca. Por favor, escolha uma senha mais forte.'**
  String get errorWeakPassword;

  /// No description provided for @errorInvalidCredential.
  ///
  /// In pt, this message translates to:
  /// **'As credenciais informadas são inválidas. Por favor, verifique e tente novamente.'**
  String get errorInvalidCredential;

  /// No description provided for @errorEmailNotVerified.
  ///
  /// In pt, this message translates to:
  /// **'Seu e-mail ainda não foi verificado. Por favor, verifique sua caixa de entrada e siga as instruções para ativar sua conta.'**
  String get errorEmailNotVerified;

  /// No description provided for @errorInvalidDueDate.
  ///
  /// In pt, this message translates to:
  /// **'A data de vencimento não pode ser anterior a hoje.'**
  String get errorInvalidDueDate;

  /// No description provided for @errorCancelled.
  ///
  /// In pt, this message translates to:
  /// **'Operação cancelada.'**
  String get errorCancelled;

  /// No description provided for @fieldEmailLabel.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get fieldEmailLabel;

  /// No description provided for @fieldPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get fieldPasswordLabel;

  /// No description provided for @fieldConfirmPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Confirme sua senha'**
  String get fieldConfirmPasswordLabel;

  /// No description provided for @fieldFullNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome completo'**
  String get fieldFullNameLabel;

  /// No description provided for @fieldCurrentPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Senha Atual'**
  String get fieldCurrentPasswordLabel;

  /// No description provided for @fieldNewPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nova Senha'**
  String get fieldNewPasswordLabel;

  /// No description provided for @fieldConfirmNewPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Nova Senha'**
  String get fieldConfirmNewPasswordLabel;

  /// No description provided for @validatorEmailRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, insira seu e-mail.'**
  String get validatorEmailRequired;

  /// No description provided for @validatorEmailInvalid.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, insira um e-mail válido.'**
  String get validatorEmailInvalid;

  /// No description provided for @validatorEmailInvalidShort.
  ///
  /// In pt, this message translates to:
  /// **'E-mail inválido.'**
  String get validatorEmailInvalidShort;

  /// No description provided for @validatorPasswordRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, insira sua senha.'**
  String get validatorPasswordRequired;

  /// No description provided for @validatorPasswordMinLength.
  ///
  /// In pt, this message translates to:
  /// **'A senha deve ter pelo menos 6 caracteres.'**
  String get validatorPasswordMinLength;

  /// No description provided for @validatorConfirmPasswordRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, confirme sua senha.'**
  String get validatorConfirmPasswordRequired;

  /// No description provided for @validatorPasswordsDoNotMatch.
  ///
  /// In pt, this message translates to:
  /// **'As senhas não coincidem.'**
  String get validatorPasswordsDoNotMatch;

  /// No description provided for @validatorFullNameRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, insira seu nome completo.'**
  String get validatorFullNameRequired;

  /// No description provided for @validatorCurrentPasswordRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, insira sua senha atual.'**
  String get validatorCurrentPasswordRequired;

  /// No description provided for @validatorNewPasswordRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, insira a nova senha.'**
  String get validatorNewPasswordRequired;

  /// No description provided for @validatorNewPasswordMinLength.
  ///
  /// In pt, this message translates to:
  /// **'A nova senha deve ter pelo menos 6 caracteres.'**
  String get validatorNewPasswordMinLength;

  /// No description provided for @validatorConfirmNewPasswordRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, confirme a nova senha.'**
  String get validatorConfirmNewPasswordRequired;

  /// No description provided for @validatorGroupNameRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, insira o nome do grupo.'**
  String get validatorGroupNameRequired;

  /// No description provided for @validatorTaskTitleRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, insira o título da tarefa.'**
  String get validatorTaskTitleRequired;

  /// No description provided for @validatorDueDateInPast.
  ///
  /// In pt, this message translates to:
  /// **'A data não pode ser anterior a hoje.'**
  String get validatorDueDateInPast;

  /// No description provided for @validatorDueDateInvalid.
  ///
  /// In pt, this message translates to:
  /// **'Data inválida.'**
  String get validatorDueDateInvalid;

  /// No description provided for @validatorPriorityRequired.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, selecione a prioridade da tarefa.'**
  String get validatorPriorityRequired;

  /// No description provided for @validatorPriorityRange.
  ///
  /// In pt, this message translates to:
  /// **'Prioridade deve estar entre 0 e 4.'**
  String get validatorPriorityRange;

  /// No description provided for @homeTagline.
  ///
  /// In pt, this message translates to:
  /// **'Organize suas tarefas e alcance seus objetivos com simplicidade.'**
  String get homeTagline;

  /// No description provided for @homeSignIn.
  ///
  /// In pt, this message translates to:
  /// **'Acessar minha conta'**
  String get homeSignIn;

  /// No description provided for @homeSignUp.
  ///
  /// In pt, this message translates to:
  /// **'Criar conta'**
  String get homeSignUp;

  /// No description provided for @signInAppBarTitle.
  ///
  /// In pt, this message translates to:
  /// **'Login'**
  String get signInAppBarTitle;

  /// No description provided for @signInWelcomeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo(a) de volta!'**
  String get signInWelcomeTitle;

  /// No description provided for @signInWelcomeSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Faça login para continuar.'**
  String get signInWelcomeSubtitle;

  /// No description provided for @signInForgotPassword.
  ///
  /// In pt, this message translates to:
  /// **'Esqueci minha senha'**
  String get signInForgotPassword;

  /// No description provided for @signInSubmit.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get signInSubmit;

  /// No description provided for @signInGoToSignUp.
  ///
  /// In pt, this message translates to:
  /// **'Não tem uma conta? Cadastre-se'**
  String get signInGoToSignUp;

  /// No description provided for @signInWithGoogle.
  ///
  /// In pt, this message translates to:
  /// **'Entrar com Google'**
  String get signInWithGoogle;

  /// No description provided for @signUpAppBarTitle.
  ///
  /// In pt, this message translates to:
  /// **'Criar conta'**
  String get signUpAppBarTitle;

  /// No description provided for @signUpWelcomeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo(a)!'**
  String get signUpWelcomeTitle;

  /// No description provided for @signUpWelcomeSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Preencha os campos abaixo para criar sua conta.'**
  String get signUpWelcomeSubtitle;

  /// No description provided for @signUpSubmit.
  ///
  /// In pt, this message translates to:
  /// **'CRIAR CONTA'**
  String get signUpSubmit;

  /// No description provided for @signUpSubmitLoading.
  ///
  /// In pt, this message translates to:
  /// **'Criando...'**
  String get signUpSubmitLoading;

  /// No description provided for @signUpGoToSignIn.
  ///
  /// In pt, this message translates to:
  /// **'Já tem uma conta? Faça login'**
  String get signUpGoToSignIn;

  /// No description provided for @signUpOrContinueWith.
  ///
  /// In pt, this message translates to:
  /// **'Ou continue com'**
  String get signUpOrContinueWith;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In pt, this message translates to:
  /// **'Recuperar Senha'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Insira seu e-mail para receber instruções de recuperação.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @forgotPasswordSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Instruções de recuperação enviadas para o e-mail.'**
  String get forgotPasswordSuccess;

  /// No description provided for @emailVerificationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Verifique seu e-mail'**
  String get emailVerificationTitle;

  /// No description provided for @emailVerificationMessage.
  ///
  /// In pt, this message translates to:
  /// **'Enviamos um link de verificação para o seu e-mail. Por favor, verifique sua caixa de entrada e siga as instruções para ativar sua conta.'**
  String get emailVerificationMessage;

  /// No description provided for @emailVerificationContinue.
  ///
  /// In pt, this message translates to:
  /// **'Já verifiquei, continuar'**
  String get emailVerificationContinue;

  /// No description provided for @emailVerificationResend.
  ///
  /// In pt, this message translates to:
  /// **'Reenviar e-mail de verificação'**
  String get emailVerificationResend;

  /// No description provided for @emailVerificationResentSuccess.
  ///
  /// In pt, this message translates to:
  /// **'E-mail de verificação reenviado com sucesso. Por favor, verifique sua caixa de entrada.'**
  String get emailVerificationResentSuccess;

  /// No description provided for @emailVerificationBackToLogin.
  ///
  /// In pt, this message translates to:
  /// **'Voltar para o login'**
  String get emailVerificationBackToLogin;

  /// No description provided for @dashboardGreeting.
  ///
  /// In pt, this message translates to:
  /// **'Olá,'**
  String get dashboardGreeting;

  /// No description provided for @dashboardLoadErrorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar seus dados'**
  String get dashboardLoadErrorTitle;

  /// No description provided for @dashboardQuickTasksTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tarefas Rápidas'**
  String get dashboardQuickTasksTitle;

  /// No description provided for @dashboardNoQuickTasksTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma tarefa rápida'**
  String get dashboardNoQuickTasksTitle;

  /// No description provided for @dashboardNoQuickTasksMessage.
  ///
  /// In pt, this message translates to:
  /// **'Crie uma nova tarefa para começar.'**
  String get dashboardNoQuickTasksMessage;

  /// No description provided for @dashboardGroupsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Grupos de Tarefas'**
  String get dashboardGroupsTitle;

  /// No description provided for @dashboardNewGroup.
  ///
  /// In pt, this message translates to:
  /// **'Novo grupo'**
  String get dashboardNewGroup;

  /// No description provided for @addTaskButtonLabel.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar tarefa'**
  String get addTaskButtonLabel;

  /// No description provided for @addGroupButtonLabel.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar grupo'**
  String get addGroupButtonLabel;

  /// Progresso do grupo no card do dashboard
  ///
  /// In pt, this message translates to:
  /// **'{completed}/{total} tarefas'**
  String groupCardTasksCount(int completed, int total);

  /// No description provided for @taskSheetCreateTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nova Tarefa'**
  String get taskSheetCreateTitle;

  /// No description provided for @taskSheetEditTitle.
  ///
  /// In pt, this message translates to:
  /// **'Editar Tarefa'**
  String get taskSheetEditTitle;

  /// No description provided for @taskSheetSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Insira os detalhes da nova tarefa aqui.'**
  String get taskSheetSubtitle;

  /// No description provided for @taskFieldTitleLabel.
  ///
  /// In pt, this message translates to:
  /// **'Título da Tarefa'**
  String get taskFieldTitleLabel;

  /// No description provided for @taskFieldDescriptionLabel.
  ///
  /// In pt, this message translates to:
  /// **'Descrição da Tarefa'**
  String get taskFieldDescriptionLabel;

  /// No description provided for @taskFieldDueDateLabel.
  ///
  /// In pt, this message translates to:
  /// **'Data de Vencimento'**
  String get taskFieldDueDateLabel;

  /// No description provided for @taskFieldGroupLabel.
  ///
  /// In pt, this message translates to:
  /// **'Grupo (opcional)'**
  String get taskFieldGroupLabel;

  /// No description provided for @taskGroupNone.
  ///
  /// In pt, this message translates to:
  /// **'Sem grupo'**
  String get taskGroupNone;

  /// No description provided for @taskFieldPriorityLabel.
  ///
  /// In pt, this message translates to:
  /// **'Prioridade'**
  String get taskFieldPriorityLabel;

  /// No description provided for @taskPriorityNone.
  ///
  /// In pt, this message translates to:
  /// **'Sem prioridade'**
  String get taskPriorityNone;

  /// No description provided for @taskPriorityLow.
  ///
  /// In pt, this message translates to:
  /// **'Baixa'**
  String get taskPriorityLow;

  /// No description provided for @taskPriorityMedium.
  ///
  /// In pt, this message translates to:
  /// **'Média'**
  String get taskPriorityMedium;

  /// No description provided for @taskPriorityHigh.
  ///
  /// In pt, this message translates to:
  /// **'Alta'**
  String get taskPriorityHigh;

  /// No description provided for @taskPriorityCritical.
  ///
  /// In pt, this message translates to:
  /// **'Crítica'**
  String get taskPriorityCritical;

  /// No description provided for @taskCreatedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Tarefa criada com sucesso!'**
  String get taskCreatedSuccess;

  /// No description provided for @taskUpdatedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Tarefa atualizada com sucesso!'**
  String get taskUpdatedSuccess;

  /// No description provided for @taskDeletedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Tarefa excluída com sucesso!'**
  String get taskDeletedSuccess;

  /// No description provided for @taskDeleteConfirmTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir Tarefa'**
  String get taskDeleteConfirmTitle;

  /// No description provided for @taskDeleteConfirmContent.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja excluir esta tarefa? Esta ação não pode ser desfeita.'**
  String get taskDeleteConfirmContent;

  /// No description provided for @taskDeletedSnackbarTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tarefa excluída'**
  String get taskDeletedSnackbarTitle;

  /// No description provided for @taskDeletedSnackbarMessage.
  ///
  /// In pt, this message translates to:
  /// **'A tarefa \"{title}\" foi excluída com sucesso.'**
  String taskDeletedSnackbarMessage(String title);

  /// No description provided for @taskDeleteErrorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao excluir tarefa'**
  String get taskDeleteErrorTitle;

  /// No description provided for @taskDeleteErrorMessage.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível excluir a tarefa. Tente novamente mais tarde.'**
  String get taskDeleteErrorMessage;

  /// No description provided for @taskUpdateErrorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao atualizar tarefa'**
  String get taskUpdateErrorTitle;

  /// No description provided for @taskUpdateErrorMessage.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível atualizar o status da tarefa. Tente novamente mais tarde.'**
  String get taskUpdateErrorMessage;

  /// No description provided for @groupSheetCreateTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novo Grupo'**
  String get groupSheetCreateTitle;

  /// No description provided for @groupSheetEditTitle.
  ///
  /// In pt, this message translates to:
  /// **'Editar Grupo'**
  String get groupSheetEditTitle;

  /// No description provided for @groupSheetSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Configure os detalhes do seu grupo de tarefas.'**
  String get groupSheetSubtitle;

  /// No description provided for @groupFieldNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome do Grupo'**
  String get groupFieldNameLabel;

  /// No description provided for @groupFieldDescriptionLabel.
  ///
  /// In pt, this message translates to:
  /// **'Descrição (opcional)'**
  String get groupFieldDescriptionLabel;

  /// No description provided for @groupColorLabel.
  ///
  /// In pt, this message translates to:
  /// **'Cor do Grupo'**
  String get groupColorLabel;

  /// No description provided for @groupIconLabel.
  ///
  /// In pt, this message translates to:
  /// **'Ícone do Grupo'**
  String get groupIconLabel;

  /// No description provided for @groupSaveCheckStateTitle.
  ///
  /// In pt, this message translates to:
  /// **'Salvar Estado dos Checks'**
  String get groupSaveCheckStateTitle;

  /// No description provided for @groupSaveCheckStateOn.
  ///
  /// In pt, this message translates to:
  /// **'Os checks marcados serão mantidos entre sessões'**
  String get groupSaveCheckStateOn;

  /// No description provided for @groupSaveCheckStateOff.
  ///
  /// In pt, this message translates to:
  /// **'Os checks serão resetados a cada nova sessão'**
  String get groupSaveCheckStateOff;

  /// No description provided for @groupSheetCreateButton.
  ///
  /// In pt, this message translates to:
  /// **'Criar Grupo'**
  String get groupSheetCreateButton;

  /// No description provided for @groupSheetUpdateButton.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar Grupo'**
  String get groupSheetUpdateButton;

  /// No description provided for @groupCreatedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Grupo criado com sucesso!'**
  String get groupCreatedSuccess;

  /// No description provided for @groupUpdatedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Grupo atualizado com sucesso!'**
  String get groupUpdatedSuccess;

  /// No description provided for @groupSaveUnexpectedError.
  ///
  /// In pt, this message translates to:
  /// **'Erro inesperado ao salvar grupo'**
  String get groupSaveUnexpectedError;

  /// No description provided for @groupDelete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir grupo'**
  String get groupDelete;

  /// No description provided for @groupDeleteConfirmContent.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja excluir este grupo? Todas as tarefas associadas também serão removidas. Esta ação não pode ser desfeita.'**
  String get groupDeleteConfirmContent;

  /// No description provided for @groupDeletedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Grupo excluído com sucesso!'**
  String get groupDeletedSuccess;

  /// No description provided for @groupDeleteError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao excluir grupo'**
  String get groupDeleteError;

  /// No description provided for @groupLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar o grupo: {message}'**
  String groupLoadError(String message);

  /// No description provided for @groupNotFound.
  ///
  /// In pt, this message translates to:
  /// **'Grupo não encontrado.'**
  String get groupNotFound;

  /// No description provided for @groupEdit.
  ///
  /// In pt, this message translates to:
  /// **'Editar grupo'**
  String get groupEdit;

  /// No description provided for @groupDescriptionLabel.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get groupDescriptionLabel;

  /// No description provided for @groupTasksTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tarefas'**
  String get groupTasksTitle;

  /// No description provided for @groupNewTask.
  ///
  /// In pt, this message translates to:
  /// **'Nova tarefa'**
  String get groupNewTask;

  /// No description provided for @groupNoTasksTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sem tarefas por aqui'**
  String get groupNoTasksTitle;

  /// No description provided for @groupNoTasksMessage.
  ///
  /// In pt, this message translates to:
  /// **'Comece adicionando a primeira tarefa para este grupo.'**
  String get groupNoTasksMessage;

  /// No description provided for @groupReusableChecklistBadge.
  ///
  /// In pt, this message translates to:
  /// **'Checklist reutilizável: os checks são reiniciados a cada dia.'**
  String get groupReusableChecklistBadge;

  /// No description provided for @groupResetChecklist.
  ///
  /// In pt, this message translates to:
  /// **'Reiniciar checklist'**
  String get groupResetChecklist;

  /// No description provided for @groupResetConfirmContent.
  ///
  /// In pt, this message translates to:
  /// **'Todas as tarefas de \"{name}\" voltarão a ficar desmarcadas. As tarefas em si não são excluídas.'**
  String groupResetConfirmContent(String name);

  /// No description provided for @groupResetConfirmAction.
  ///
  /// In pt, this message translates to:
  /// **'Reiniciar'**
  String get groupResetConfirmAction;

  /// No description provided for @groupResetSuccessTitle.
  ///
  /// In pt, this message translates to:
  /// **'Checklist reiniciado'**
  String get groupResetSuccessTitle;

  /// No description provided for @groupResetSuccessMessage.
  ///
  /// In pt, this message translates to:
  /// **'As tarefas de \"{name}\" foram desmarcadas.'**
  String groupResetSuccessMessage(String name);

  /// No description provided for @groupResetErrorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao reiniciar checklist'**
  String get groupResetErrorTitle;

  /// No description provided for @groupResetErrorMessage.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível desmarcar as tarefas. Tente novamente mais tarde.'**
  String get groupResetErrorMessage;

  /// No description provided for @settingsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settingsTitle;

  /// No description provided for @settingsLoadErrorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar suas configurações'**
  String get settingsLoadErrorTitle;

  /// No description provided for @settingsUserFallbackName.
  ///
  /// In pt, this message translates to:
  /// **'Usuário'**
  String get settingsUserFallbackName;

  /// No description provided for @settingsEmailUnavailable.
  ///
  /// In pt, this message translates to:
  /// **'E-mail não disponível'**
  String get settingsEmailUnavailable;

  /// No description provided for @settingsSectionAccount.
  ///
  /// In pt, this message translates to:
  /// **'Conta'**
  String get settingsSectionAccount;

  /// No description provided for @settingsChangePassword.
  ///
  /// In pt, this message translates to:
  /// **'Alterar Senha'**
  String get settingsChangePassword;

  /// No description provided for @settingsManageAccount.
  ///
  /// In pt, this message translates to:
  /// **'Gerenciar Conta'**
  String get settingsManageAccount;

  /// No description provided for @settingsSectionPreferences.
  ///
  /// In pt, this message translates to:
  /// **'Preferências'**
  String get settingsSectionPreferences;

  /// No description provided for @settingsThemeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Tema'**
  String get settingsThemeLabel;

  /// No description provided for @settingsNotifications.
  ///
  /// In pt, this message translates to:
  /// **'Notificações'**
  String get settingsNotifications;

  /// No description provided for @settingsSectionOther.
  ///
  /// In pt, this message translates to:
  /// **'Outros'**
  String get settingsSectionOther;

  /// No description provided for @settingsAbout.
  ///
  /// In pt, this message translates to:
  /// **'Sobre o App'**
  String get settingsAbout;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In pt, this message translates to:
  /// **'Política de Privacidade'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsTermsOfService.
  ///
  /// In pt, this message translates to:
  /// **'Termos de Serviço'**
  String get settingsTermsOfService;

  /// No description provided for @settingsLogout.
  ///
  /// In pt, this message translates to:
  /// **'Sair da Conta'**
  String get settingsLogout;

  /// No description provided for @settingsLogoutErrorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao Sair'**
  String get settingsLogoutErrorTitle;

  /// No description provided for @changePasswordSubmit.
  ///
  /// In pt, this message translates to:
  /// **'Salvar Alterações'**
  String get changePasswordSubmit;

  /// No description provided for @changePasswordSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Senha alterada com sucesso!'**
  String get changePasswordSuccess;

  /// No description provided for @aboutIntro.
  ///
  /// In pt, this message translates to:
  /// **'O Fly Checklist é uma solução inovadora para gerenciamento de tarefas, que aplica a metodologia dos checklists de aviação para otimizar seu dia a dia.\n\nO segredo está na capacidade de criar grupos de checklists \"não persistentes\". Enquanto um To-Do list tradicional salva suas marcações, o Fly Checklist permite que certas listas voltem ao estado original após o uso, tornando-o perfeito para tarefas recorrentes.'**
  String get aboutIntro;

  /// No description provided for @aboutFeaturesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Principais Funcionalidades:'**
  String get aboutFeaturesTitle;

  /// No description provided for @aboutFeatureReusableTitle.
  ///
  /// In pt, this message translates to:
  /// **'Checklists Reutilizáveis:'**
  String get aboutFeatureReusableTitle;

  /// No description provided for @aboutFeatureReusableDescription.
  ///
  /// In pt, this message translates to:
  /// **'O recurso principal. Crie uma lista para sua rotina (ex: preparar o café da manhã, rotina de exercícios) e ela estará sempre pronta e desmarcada para a próxima vez, economizando seu tempo e esforço.'**
  String get aboutFeatureReusableDescription;

  /// No description provided for @aboutFeatureAviationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Metodologia da Aviação:'**
  String get aboutFeatureAviationTitle;

  /// No description provided for @aboutFeatureAviationDescription.
  ///
  /// In pt, this message translates to:
  /// **'Traz um conceito de disciplina e precisão para garantir que nenhuma etapa de um processo importante seja pulada.'**
  String get aboutFeatureAviationDescription;

  /// No description provided for @aboutFeatureGroupingTitle.
  ///
  /// In pt, this message translates to:
  /// **'Agrupamento Inteligente:'**
  String get aboutFeatureGroupingTitle;

  /// No description provided for @aboutFeatureGroupingDescription.
  ///
  /// In pt, this message translates to:
  /// **'Organize múltiplos checklists em grupos temáticos (ex: \"Manhã\", \"Fim do Dia\", \"Projeto X\"), mantendo sua vida pessoal e profissional perfeitamente ordenada.'**
  String get aboutFeatureGroupingDescription;

  /// No description provided for @aboutFeatureFlexibilityTitle.
  ///
  /// In pt, this message translates to:
  /// **'Flexibilidade Total:'**
  String get aboutFeatureFlexibilityTitle;

  /// No description provided for @aboutFeatureFlexibilityDescription.
  ///
  /// In pt, this message translates to:
  /// **'Ideal tanto para uma simples lista de tarefas quanto para processos complexos que exigem uma sequência de ações verificadas.'**
  String get aboutFeatureFlexibilityDescription;

  /// No description provided for @aboutClosing.
  ///
  /// In pt, this message translates to:
  /// **'Fly Checklist é a ferramenta definitiva para quem busca transformar rotinas em hábitos sólidos e eficientes.'**
  String get aboutClosing;

  /// No description provided for @aboutVersion.
  ///
  /// In pt, this message translates to:
  /// **'Versão {version}'**
  String aboutVersion(String version);

  /// No description provided for @aboutDeveloper.
  ///
  /// In pt, this message translates to:
  /// **'Desenvolvido por Vitor Melo'**
  String get aboutDeveloper;

  /// No description provided for @aboutCopyright.
  ///
  /// In pt, this message translates to:
  /// **'© {year} Fly Checklist. Todos os direitos reservados.'**
  String aboutCopyright(String year);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

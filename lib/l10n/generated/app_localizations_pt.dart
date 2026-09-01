// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Fly Checklist';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get commonCreate => 'Criar';

  @override
  String get commonUpdate => 'Atualizar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonSend => 'Enviar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonOk => 'OK';

  @override
  String get commonGotIt => 'Entendi';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonLoading => 'Carregando...';

  @override
  String get commonOr => 'OU';

  @override
  String get errorDialogTitle => 'Ocorreu um erro';

  @override
  String get successDialogTitle => 'Sucesso!';

  @override
  String get confirmationDialogTitle => 'Confirmação';

  @override
  String get confirmationDialogContent =>
      'Você tem certeza que deseja continuar?';

  @override
  String get successSnackbarTitle => 'Sucesso';

  @override
  String get successSnackbarMessage => 'Ação realizada com sucesso.';

  @override
  String get errorUnexpected =>
      'Ocorreu um erro inesperado. Por favor, tente novamente mais tarde.';

  @override
  String get errorInvalidEmail =>
      'O e-mail informado é inválido. Por favor, verifique e tente novamente.';

  @override
  String get errorEmailInUse =>
      'Este e-mail já está em uso. Por favor, tente com outro e-mail.';

  @override
  String get errorWeakPassword =>
      'A senha informada é muito fraca. Por favor, escolha uma senha mais forte.';

  @override
  String get errorInvalidCredential =>
      'As credenciais informadas são inválidas. Por favor, verifique e tente novamente.';

  @override
  String get errorEmailNotVerified =>
      'Seu e-mail ainda não foi verificado. Por favor, verifique sua caixa de entrada e siga as instruções para ativar sua conta.';

  @override
  String get errorInvalidDueDate =>
      'A data de vencimento não pode ser anterior a hoje.';

  @override
  String get errorCancelled => 'Operação cancelada.';

  @override
  String get fieldEmailLabel => 'E-mail';

  @override
  String get fieldPasswordLabel => 'Senha';

  @override
  String get fieldConfirmPasswordLabel => 'Confirme sua senha';

  @override
  String get fieldFullNameLabel => 'Nome completo';

  @override
  String get fieldCurrentPasswordLabel => 'Senha Atual';

  @override
  String get fieldNewPasswordLabel => 'Nova Senha';

  @override
  String get fieldConfirmNewPasswordLabel => 'Confirmar Nova Senha';

  @override
  String get passwordShowTooltip => 'Mostrar senha';

  @override
  String get passwordHideTooltip => 'Ocultar senha';

  @override
  String get validatorEmailRequired => 'Por favor, insira seu e-mail.';

  @override
  String get validatorEmailInvalid => 'Por favor, insira um e-mail válido.';

  @override
  String get validatorEmailInvalidShort => 'E-mail inválido.';

  @override
  String get validatorPasswordRequired => 'Por favor, insira sua senha.';

  @override
  String get validatorPasswordMinLength =>
      'A senha deve ter pelo menos 6 caracteres.';

  @override
  String get validatorConfirmPasswordRequired =>
      'Por favor, confirme sua senha.';

  @override
  String get validatorPasswordsDoNotMatch => 'As senhas não coincidem.';

  @override
  String get validatorFullNameRequired =>
      'Por favor, insira seu nome completo.';

  @override
  String get validatorCurrentPasswordRequired =>
      'Por favor, insira sua senha atual.';

  @override
  String get validatorNewPasswordRequired => 'Por favor, insira a nova senha.';

  @override
  String get validatorNewPasswordMinLength =>
      'A nova senha deve ter pelo menos 6 caracteres.';

  @override
  String get validatorConfirmNewPasswordRequired =>
      'Por favor, confirme a nova senha.';

  @override
  String get validatorGroupNameRequired => 'Por favor, insira o nome do grupo.';

  @override
  String get validatorTaskTitleRequired =>
      'Por favor, insira o título da tarefa.';

  @override
  String get validatorDueDateInPast => 'A data não pode ser anterior a hoje.';

  @override
  String get validatorDueDateInvalid => 'Data inválida.';

  @override
  String get validatorPriorityRequired =>
      'Por favor, selecione a prioridade da tarefa.';

  @override
  String get validatorPriorityRange => 'Prioridade deve estar entre 0 e 4.';

  @override
  String get homeTagline =>
      'Organize suas tarefas e alcance seus objetivos com simplicidade.';

  @override
  String get homeSignIn => 'Acessar minha conta';

  @override
  String get homeSignUp => 'Criar conta';

  @override
  String get signInAppBarTitle => 'Login';

  @override
  String get signInWelcomeTitle => 'Bem-vindo(a) de volta!';

  @override
  String get signInWelcomeSubtitle => 'Faça login para continuar.';

  @override
  String get signInForgotPassword => 'Esqueci minha senha';

  @override
  String get signInSubmit => 'Entrar';

  @override
  String get signInGoToSignUp => 'Não tem uma conta? Cadastre-se';

  @override
  String get signInWithGoogle => 'Entrar com Google';

  @override
  String get signUpAppBarTitle => 'Criar conta';

  @override
  String get signUpWelcomeTitle => 'Bem-vindo(a)!';

  @override
  String get signUpWelcomeSubtitle =>
      'Preencha os campos abaixo para criar sua conta.';

  @override
  String get signUpSubmit => 'CRIAR CONTA';

  @override
  String get signUpSubmitLoading => 'Criando...';

  @override
  String get signUpGoToSignIn => 'Já tem uma conta? Faça login';

  @override
  String get signUpOrContinueWith => 'Ou continue com';

  @override
  String get forgotPasswordTitle => 'Recuperar Senha';

  @override
  String get forgotPasswordSubtitle =>
      'Insira seu e-mail para receber instruções de recuperação.';

  @override
  String get forgotPasswordSuccess =>
      'Instruções de recuperação enviadas para o e-mail.';

  @override
  String get emailVerificationTitle => 'Verifique seu e-mail';

  @override
  String get emailVerificationMessage =>
      'Enviamos um link de verificação para o seu e-mail. Por favor, verifique sua caixa de entrada e siga as instruções para ativar sua conta.';

  @override
  String get emailVerificationContinue => 'Já verifiquei, continuar';

  @override
  String get emailVerificationResend => 'Reenviar e-mail de verificação';

  @override
  String get emailVerificationResentSuccess =>
      'E-mail de verificação reenviado com sucesso. Por favor, verifique sua caixa de entrada.';

  @override
  String get emailVerificationBackToLogin => 'Voltar para o login';

  @override
  String get dashboardGreeting => 'Olá,';

  @override
  String get dashboardLoadErrorTitle => 'Não foi possível carregar seus dados';

  @override
  String get dashboardQuickTasksTitle => 'Tarefas Rápidas';

  @override
  String get dashboardNoQuickTasksTitle => 'Nenhuma tarefa rápida';

  @override
  String get dashboardNoQuickTasksMessage =>
      'Crie uma nova tarefa para começar.';

  @override
  String get dashboardGroupsTitle => 'Grupos de Tarefas';

  @override
  String get dashboardNewGroup => 'Novo grupo';

  @override
  String get addTaskButtonLabel => 'Adicionar tarefa';

  @override
  String get addGroupButtonLabel => 'Adicionar grupo';

  @override
  String groupCardTasksCount(int completed, int total) {
    return '$completed/$total tarefas';
  }

  @override
  String get taskSheetCreateTitle => 'Nova Tarefa';

  @override
  String get taskSheetEditTitle => 'Editar Tarefa';

  @override
  String get taskSheetSubtitle => 'Insira os detalhes da nova tarefa aqui.';

  @override
  String get taskFieldTitleLabel => 'Título da Tarefa';

  @override
  String get taskFieldDescriptionLabel => 'Descrição da Tarefa';

  @override
  String get taskFieldDueDateLabel => 'Data de Vencimento';

  @override
  String get taskFieldGroupLabel => 'Grupo (opcional)';

  @override
  String get taskGroupNone => 'Sem grupo';

  @override
  String get taskFieldPriorityLabel => 'Prioridade';

  @override
  String get taskPriorityNone => 'Sem prioridade';

  @override
  String get taskPriorityLow => 'Baixa';

  @override
  String get taskPriorityMedium => 'Média';

  @override
  String get taskPriorityHigh => 'Alta';

  @override
  String get taskPriorityCritical => 'Crítica';

  @override
  String taskPrioritySemanticLabel(String priority) {
    return 'Prioridade: $priority';
  }

  @override
  String taskCheckboxLabelDone(String title) {
    return '$title, concluída';
  }

  @override
  String taskCheckboxLabelPending(String title) {
    return '$title, pendente';
  }

  @override
  String get taskCreatedSuccess => 'Tarefa criada com sucesso!';

  @override
  String get taskUpdatedSuccess => 'Tarefa atualizada com sucesso!';

  @override
  String get taskDeletedSuccess => 'Tarefa excluída com sucesso!';

  @override
  String get taskDeleteConfirmTitle => 'Excluir Tarefa';

  @override
  String get taskDeleteConfirmContent =>
      'Tem certeza que deseja excluir esta tarefa? Esta ação não pode ser desfeita.';

  @override
  String get taskDeletedSnackbarTitle => 'Tarefa excluída';

  @override
  String taskDeletedSnackbarMessage(String title) {
    return 'A tarefa \"$title\" foi excluída com sucesso.';
  }

  @override
  String get taskDeleteErrorTitle => 'Erro ao excluir tarefa';

  @override
  String get taskDeleteErrorMessage =>
      'Não foi possível excluir a tarefa. Tente novamente mais tarde.';

  @override
  String get taskUpdateErrorTitle => 'Erro ao atualizar tarefa';

  @override
  String get taskUpdateErrorMessage =>
      'Não foi possível atualizar o status da tarefa. Tente novamente mais tarde.';

  @override
  String get groupSheetCreateTitle => 'Novo Grupo';

  @override
  String get groupSheetEditTitle => 'Editar Grupo';

  @override
  String get groupSheetSubtitle =>
      'Configure os detalhes do seu grupo de tarefas.';

  @override
  String get groupFieldNameLabel => 'Nome do Grupo';

  @override
  String get groupFieldDescriptionLabel => 'Descrição (opcional)';

  @override
  String get groupColorLabel => 'Cor do Grupo';

  @override
  String get groupIconLabel => 'Ícone do Grupo';

  @override
  String get groupColorThemeName => 'Cor do tema';

  @override
  String get groupColorRed => 'Vermelho';

  @override
  String get groupColorGreen => 'Verde';

  @override
  String get groupColorBlue => 'Azul';

  @override
  String get groupColorOrange => 'Laranja';

  @override
  String get groupColorPurple => 'Roxo';

  @override
  String get groupColorTeal => 'Verde-azulado';

  @override
  String get groupColorPink => 'Rosa';

  @override
  String get groupColorIndigo => 'Índigo';

  @override
  String get groupColorBrown => 'Marrom';

  @override
  String get groupIconChecklist => 'Checklist';

  @override
  String get groupIconList => 'Lista';

  @override
  String get groupIconTask => 'Tarefa concluída';

  @override
  String get groupIconAssignment => 'Formulário';

  @override
  String get groupIconWork => 'Trabalho';

  @override
  String get groupIconHome => 'Casa';

  @override
  String get groupIconSchool => 'Escola';

  @override
  String get groupIconFitness => 'Academia';

  @override
  String get groupIconShopping => 'Compras';

  @override
  String get groupIconRestaurant => 'Restaurante';

  @override
  String get groupIconCarRepair => 'Manutenção automotiva';

  @override
  String get groupIconFlight => 'Viagem';

  @override
  String get groupIconMedical => 'Saúde';

  @override
  String get groupIconPets => 'Pets';

  @override
  String get groupIconSports => 'Esportes';

  @override
  String get groupMenuTooltip => 'Mais opções do grupo';

  @override
  String get groupSaveCheckStateTitle => 'Salvar Estado dos Checks';

  @override
  String get groupSaveCheckStateOn =>
      'Os checks marcados serão mantidos entre sessões';

  @override
  String get groupSaveCheckStateOff =>
      'Os checks serão resetados a cada nova sessão';

  @override
  String get groupSheetCreateButton => 'Criar Grupo';

  @override
  String get groupSheetUpdateButton => 'Atualizar Grupo';

  @override
  String get groupCreatedSuccess => 'Grupo criado com sucesso!';

  @override
  String get groupUpdatedSuccess => 'Grupo atualizado com sucesso!';

  @override
  String get groupSaveUnexpectedError => 'Erro inesperado ao salvar grupo';

  @override
  String get groupDelete => 'Excluir grupo';

  @override
  String get groupDeleteConfirmContent =>
      'Tem certeza que deseja excluir este grupo? Todas as tarefas associadas também serão removidas. Esta ação não pode ser desfeita.';

  @override
  String get groupDeletedSuccess => 'Grupo excluído com sucesso!';

  @override
  String get groupDeleteError => 'Erro ao excluir grupo';

  @override
  String groupLoadError(String message) {
    return 'Erro ao carregar o grupo: $message';
  }

  @override
  String get groupNotFound => 'Grupo não encontrado.';

  @override
  String get groupEdit => 'Editar grupo';

  @override
  String get groupDescriptionLabel => 'Descrição';

  @override
  String get groupTasksTitle => 'Tarefas';

  @override
  String get groupNewTask => 'Nova tarefa';

  @override
  String get groupNoTasksTitle => 'Sem tarefas por aqui';

  @override
  String get groupNoTasksMessage =>
      'Comece adicionando a primeira tarefa para este grupo.';

  @override
  String get groupReusableChecklistBadge =>
      'Checklist reutilizável: os checks são reiniciados a cada dia.';

  @override
  String get groupResetChecklist => 'Reiniciar checklist';

  @override
  String groupResetConfirmContent(String name) {
    return 'Todas as tarefas de \"$name\" voltarão a ficar desmarcadas. As tarefas em si não são excluídas.';
  }

  @override
  String get groupResetConfirmAction => 'Reiniciar';

  @override
  String get groupResetSuccessTitle => 'Checklist reiniciado';

  @override
  String groupResetSuccessMessage(String name) {
    return 'As tarefas de \"$name\" foram desmarcadas.';
  }

  @override
  String get groupResetErrorTitle => 'Erro ao reiniciar checklist';

  @override
  String get groupResetErrorMessage =>
      'Não foi possível desmarcar as tarefas. Tente novamente mais tarde.';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsLoadErrorTitle =>
      'Não foi possível carregar suas configurações';

  @override
  String get settingsUserFallbackName => 'Usuário';

  @override
  String get settingsEmailUnavailable => 'E-mail não disponível';

  @override
  String get settingsSectionAccount => 'Conta';

  @override
  String get settingsChangePassword => 'Alterar Senha';

  @override
  String get settingsManageAccount => 'Gerenciar Conta';

  @override
  String get settingsSectionPreferences => 'Preferências';

  @override
  String get settingsThemeLabel => 'Tema';

  @override
  String get settingsNotifications => 'Notificações';

  @override
  String get settingsSectionOther => 'Outros';

  @override
  String get settingsAbout => 'Sobre o App';

  @override
  String get settingsPrivacyPolicy => 'Política de Privacidade';

  @override
  String get settingsTermsOfService => 'Termos de Serviço';

  @override
  String get settingsLogout => 'Sair da Conta';

  @override
  String get settingsLogoutErrorTitle => 'Erro ao Sair';

  @override
  String get changePasswordSubmit => 'Salvar Alterações';

  @override
  String get changePasswordSuccess => 'Senha alterada com sucesso!';

  @override
  String get aboutIntro =>
      'O Fly Checklist é uma solução inovadora para gerenciamento de tarefas, que aplica a metodologia dos checklists de aviação para otimizar seu dia a dia.\n\nO segredo está na capacidade de criar grupos de checklists \"não persistentes\". Enquanto um To-Do list tradicional salva suas marcações, o Fly Checklist permite que certas listas voltem ao estado original após o uso, tornando-o perfeito para tarefas recorrentes.';

  @override
  String get aboutFeaturesTitle => 'Principais Funcionalidades:';

  @override
  String get aboutFeatureReusableTitle => 'Checklists Reutilizáveis:';

  @override
  String get aboutFeatureReusableDescription =>
      'O recurso principal. Crie uma lista para sua rotina (ex: preparar o café da manhã, rotina de exercícios) e ela estará sempre pronta e desmarcada para a próxima vez, economizando seu tempo e esforço.';

  @override
  String get aboutFeatureAviationTitle => 'Metodologia da Aviação:';

  @override
  String get aboutFeatureAviationDescription =>
      'Traz um conceito de disciplina e precisão para garantir que nenhuma etapa de um processo importante seja pulada.';

  @override
  String get aboutFeatureGroupingTitle => 'Agrupamento Inteligente:';

  @override
  String get aboutFeatureGroupingDescription =>
      'Organize múltiplos checklists em grupos temáticos (ex: \"Manhã\", \"Fim do Dia\", \"Projeto X\"), mantendo sua vida pessoal e profissional perfeitamente ordenada.';

  @override
  String get aboutFeatureFlexibilityTitle => 'Flexibilidade Total:';

  @override
  String get aboutFeatureFlexibilityDescription =>
      'Ideal tanto para uma simples lista de tarefas quanto para processos complexos que exigem uma sequência de ações verificadas.';

  @override
  String get aboutClosing =>
      'Fly Checklist é a ferramenta definitiva para quem busca transformar rotinas em hábitos sólidos e eficientes.';

  @override
  String aboutVersion(String version) {
    return 'Versão $version';
  }

  @override
  String get aboutDeveloper => 'Desenvolvido por Vitor Melo';

  @override
  String aboutCopyright(String year) {
    return '© $year Fly Checklist. Todos os direitos reservados.';
  }
}

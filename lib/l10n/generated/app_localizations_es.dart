// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Fly Checklist';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get commonCreate => 'Crear';

  @override
  String get commonUpdate => 'Actualizar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonSend => 'Enviar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonOk => 'OK';

  @override
  String get commonGotIt => 'Entendido';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonLoading => 'Cargando...';

  @override
  String get commonOr => 'O';

  @override
  String get errorDialogTitle => 'Se produjo un error';

  @override
  String get successDialogTitle => '¡Listo!';

  @override
  String get confirmationDialogTitle => 'Confirmación';

  @override
  String get confirmationDialogContent => '¿Seguro que quieres continuar?';

  @override
  String get successSnackbarTitle => 'Listo';

  @override
  String get successSnackbarMessage => 'Acción realizada con éxito.';

  @override
  String get errorUnexpected =>
      'Ocurrió un error inesperado. Vuelve a intentarlo más tarde.';

  @override
  String get errorInvalidEmail =>
      'El correo indicado no es válido. Revísalo e inténtalo de nuevo.';

  @override
  String get errorEmailInUse => 'Este correo ya está en uso. Prueba con otro.';

  @override
  String get errorWeakPassword =>
      'La contraseña es demasiado débil. Elige una más segura.';

  @override
  String get errorInvalidCredential =>
      'Las credenciales no son válidas. Revísalas e inténtalo de nuevo.';

  @override
  String get errorEmailNotVerified =>
      'Tu correo aún no ha sido verificado. Revisa tu bandeja de entrada y sigue las instrucciones para activar tu cuenta.';

  @override
  String get errorInvalidDueDate =>
      'La fecha de vencimiento no puede ser anterior a hoy.';

  @override
  String get errorCancelled => 'Operación cancelada.';

  @override
  String get fieldEmailLabel => 'Correo electrónico';

  @override
  String get fieldPasswordLabel => 'Contraseña';

  @override
  String get fieldConfirmPasswordLabel => 'Confirma tu contraseña';

  @override
  String get fieldFullNameLabel => 'Nombre completo';

  @override
  String get fieldCurrentPasswordLabel => 'Contraseña actual';

  @override
  String get fieldNewPasswordLabel => 'Contraseña nueva';

  @override
  String get fieldConfirmNewPasswordLabel => 'Confirmar contraseña nueva';

  @override
  String get passwordShowTooltip => 'Mostrar contraseña';

  @override
  String get passwordHideTooltip => 'Ocultar contraseña';

  @override
  String get validatorEmailRequired => 'Introduce tu correo electrónico.';

  @override
  String get validatorEmailInvalid => 'Introduce un correo electrónico válido.';

  @override
  String get validatorEmailInvalidShort => 'Correo no válido.';

  @override
  String get validatorPasswordRequired => 'Introduce tu contraseña.';

  @override
  String get validatorPasswordMinLength =>
      'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get validatorConfirmPasswordRequired => 'Confirma tu contraseña.';

  @override
  String get validatorPasswordsDoNotMatch => 'Las contraseñas no coinciden.';

  @override
  String get validatorFullNameRequired => 'Introduce tu nombre completo.';

  @override
  String get validatorCurrentPasswordRequired =>
      'Introduce tu contraseña actual.';

  @override
  String get validatorNewPasswordRequired => 'Introduce la contraseña nueva.';

  @override
  String get validatorNewPasswordMinLength =>
      'La contraseña nueva debe tener al menos 6 caracteres.';

  @override
  String get validatorConfirmNewPasswordRequired =>
      'Confirma la contraseña nueva.';

  @override
  String get validatorGroupNameRequired => 'Introduce el nombre del grupo.';

  @override
  String get validatorTaskTitleRequired => 'Introduce el título de la tarea.';

  @override
  String get validatorDueDateInPast => 'La fecha no puede ser anterior a hoy.';

  @override
  String get validatorDueDateInvalid => 'Fecha no válida.';

  @override
  String get validatorPriorityRequired =>
      'Selecciona la prioridad de la tarea.';

  @override
  String get validatorPriorityRange => 'La prioridad debe estar entre 0 y 4.';

  @override
  String get homeTagline =>
      'Organiza tus tareas y alcanza tus objetivos con sencillez.';

  @override
  String get homeSignIn => 'Entrar en mi cuenta';

  @override
  String get homeSignUp => 'Crear cuenta';

  @override
  String get signInAppBarTitle => 'Iniciar sesión';

  @override
  String get signInWelcomeTitle => '¡Bienvenido de nuevo!';

  @override
  String get signInWelcomeSubtitle => 'Inicia sesión para continuar.';

  @override
  String get signInForgotPassword => 'Olvidé mi contraseña';

  @override
  String get signInSubmit => 'Entrar';

  @override
  String get signInGoToSignUp => '¿Aún no tienes cuenta? Regístrate';

  @override
  String get signInWithGoogle => 'Entrar con Google';

  @override
  String get signUpAppBarTitle => 'Crear cuenta';

  @override
  String get signUpWelcomeTitle => '¡Bienvenido!';

  @override
  String get signUpWelcomeSubtitle =>
      'Completa los campos para crear tu cuenta.';

  @override
  String get signUpSubmit => 'CREAR CUENTA';

  @override
  String get signUpSubmitLoading => 'Creando...';

  @override
  String get signUpGoToSignIn => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get signUpOrContinueWith => 'O continúa con';

  @override
  String get forgotPasswordTitle => 'Recuperar contraseña';

  @override
  String get forgotPasswordSubtitle =>
      'Introduce tu correo para recibir las instrucciones de recuperación.';

  @override
  String get forgotPasswordSuccess =>
      'Instrucciones de recuperación enviadas a tu correo.';

  @override
  String get emailVerificationTitle => 'Verifica tu correo';

  @override
  String get emailVerificationMessage =>
      'Te enviamos un enlace de verificación a tu correo. Revisa tu bandeja de entrada y sigue las instrucciones para activar tu cuenta.';

  @override
  String get emailVerificationContinue => 'Ya lo verifiqué, continuar';

  @override
  String get emailVerificationResend => 'Reenviar correo de verificación';

  @override
  String get emailVerificationResentSuccess =>
      'Correo de verificación reenviado. Revisa tu bandeja de entrada.';

  @override
  String get emailVerificationBackToLogin => 'Volver al inicio de sesión';

  @override
  String get dashboardGreeting => 'Hola,';

  @override
  String get dashboardLoadErrorTitle => 'No pudimos cargar tus datos';

  @override
  String get dashboardQuickTasksTitle => 'Tareas rápidas';

  @override
  String get dashboardNoQuickTasksTitle => 'Ninguna tarea rápida';

  @override
  String get dashboardNoQuickTasksMessage =>
      'Crea una tarea nueva para empezar.';

  @override
  String get dashboardGroupsTitle => 'Grupos de tareas';

  @override
  String get dashboardNewGroup => 'Grupo nuevo';

  @override
  String get addTaskButtonLabel => 'Añadir tarea';

  @override
  String get addGroupButtonLabel => 'Añadir grupo';

  @override
  String groupCardTasksCount(int completed, int total) {
    return '$completed/$total tareas';
  }

  @override
  String get taskSheetCreateTitle => 'Tarea nueva';

  @override
  String get taskSheetEditTitle => 'Editar tarea';

  @override
  String get taskSheetSubtitle => 'Introduce aquí los datos de la tarea nueva.';

  @override
  String get taskFieldTitleLabel => 'Título de la tarea';

  @override
  String get taskFieldDescriptionLabel => 'Descripción de la tarea';

  @override
  String get taskFieldDueDateLabel => 'Fecha de vencimiento';

  @override
  String get taskFieldGroupLabel => 'Grupo (opcional)';

  @override
  String get taskGroupNone => 'Sin grupo';

  @override
  String get taskFieldPriorityLabel => 'Prioridad';

  @override
  String get taskPriorityNone => 'Sin prioridad';

  @override
  String get taskPriorityLow => 'Baja';

  @override
  String get taskPriorityMedium => 'Media';

  @override
  String get taskPriorityHigh => 'Alta';

  @override
  String get taskPriorityCritical => 'Crítica';

  @override
  String taskPrioritySemanticLabel(String priority) {
    return 'Prioridad: $priority';
  }

  @override
  String taskCheckboxLabelDone(String title) {
    return '$title, completada';
  }

  @override
  String taskCheckboxLabelPending(String title) {
    return '$title, pendiente';
  }

  @override
  String get taskCreatedSuccess => 'Tarea creada.';

  @override
  String get taskUpdatedSuccess => 'Tarea actualizada.';

  @override
  String get taskDeletedSuccess => 'Tarea eliminada.';

  @override
  String get taskDeleteConfirmTitle => 'Eliminar tarea';

  @override
  String get taskDeleteConfirmContent =>
      '¿Seguro que quieres eliminar esta tarea? Esta acción no se puede deshacer.';

  @override
  String get taskDeletedSnackbarTitle => 'Tarea eliminada';

  @override
  String taskDeletedSnackbarMessage(String title) {
    return 'La tarea \"$title\" se eliminó correctamente.';
  }

  @override
  String get taskDeleteErrorTitle => 'No se pudo eliminar la tarea';

  @override
  String get taskDeleteErrorMessage =>
      'No pudimos eliminar la tarea. Vuelve a intentarlo más tarde.';

  @override
  String get taskUpdateErrorTitle => 'No se pudo actualizar la tarea';

  @override
  String get taskUpdateErrorMessage =>
      'No pudimos actualizar el estado de la tarea. Vuelve a intentarlo más tarde.';

  @override
  String get groupSheetCreateTitle => 'Grupo nuevo';

  @override
  String get groupSheetEditTitle => 'Editar grupo';

  @override
  String get groupSheetSubtitle => 'Configura los datos de tu grupo de tareas.';

  @override
  String get groupFieldNameLabel => 'Nombre del grupo';

  @override
  String get groupFieldDescriptionLabel => 'Descripción (opcional)';

  @override
  String get groupColorLabel => 'Color del grupo';

  @override
  String get groupIconLabel => 'Icono del grupo';

  @override
  String get groupColorThemeName => 'Color del tema';

  @override
  String get groupColorRed => 'Rojo';

  @override
  String get groupColorGreen => 'Verde';

  @override
  String get groupColorBlue => 'Azul';

  @override
  String get groupColorOrange => 'Naranja';

  @override
  String get groupColorPurple => 'Morado';

  @override
  String get groupColorTeal => 'Verde azulado';

  @override
  String get groupColorPink => 'Rosa';

  @override
  String get groupColorIndigo => 'Índigo';

  @override
  String get groupColorBrown => 'Marrón';

  @override
  String get groupIconChecklist => 'Lista de verificación';

  @override
  String get groupIconList => 'Lista';

  @override
  String get groupIconTask => 'Tarea completada';

  @override
  String get groupIconAssignment => 'Formulario';

  @override
  String get groupIconWork => 'Trabajo';

  @override
  String get groupIconHome => 'Casa';

  @override
  String get groupIconSchool => 'Escuela';

  @override
  String get groupIconFitness => 'Gimnasio';

  @override
  String get groupIconShopping => 'Compras';

  @override
  String get groupIconRestaurant => 'Restaurante';

  @override
  String get groupIconCarRepair => 'Mantenimiento del auto';

  @override
  String get groupIconFlight => 'Viaje';

  @override
  String get groupIconMedical => 'Salud';

  @override
  String get groupIconPets => 'Mascotas';

  @override
  String get groupIconSports => 'Deportes';

  @override
  String get groupMenuTooltip => 'Opciones del grupo';

  @override
  String get groupSaveCheckStateTitle => 'Guardar el estado de las marcas';

  @override
  String get groupSaveCheckStateOn => 'Las marcas se mantienen entre sesiones';

  @override
  String get groupSaveCheckStateOff => 'Las marcas se reinician en cada sesión';

  @override
  String get groupSheetCreateButton => 'Crear grupo';

  @override
  String get groupSheetUpdateButton => 'Actualizar grupo';

  @override
  String get groupCreatedSuccess => 'Grupo creado.';

  @override
  String get groupUpdatedSuccess => 'Grupo actualizado.';

  @override
  String get groupSaveUnexpectedError => 'Error inesperado al guardar el grupo';

  @override
  String get groupDelete => 'Eliminar grupo';

  @override
  String get groupDeleteConfirmContent =>
      '¿Seguro que quieres eliminar este grupo? También se eliminarán todas sus tareas. Esta acción no se puede deshacer.';

  @override
  String get groupDeletedSuccess => 'Grupo eliminado.';

  @override
  String get groupDeleteError => 'No se pudo eliminar el grupo';

  @override
  String groupLoadError(String message) {
    return 'Error al cargar el grupo: $message';
  }

  @override
  String get groupNotFound => 'Grupo no encontrado.';

  @override
  String get groupEdit => 'Editar grupo';

  @override
  String get groupDescriptionLabel => 'Descripción';

  @override
  String get groupTasksTitle => 'Tareas';

  @override
  String get groupNewTask => 'Tarea nueva';

  @override
  String get groupNoTasksTitle => 'Aquí no hay tareas';

  @override
  String get groupNoTasksMessage =>
      'Empieza añadiendo la primera tarea de este grupo.';

  @override
  String get groupReusableChecklistBadge =>
      'Checklist reutilizable: las marcas se reinician cada día.';

  @override
  String get groupResetChecklist => 'Reiniciar checklist';

  @override
  String groupResetConfirmContent(String name) {
    return 'Todas las tareas de \"$name\" volverán a quedar sin marcar. Las tareas no se eliminan.';
  }

  @override
  String get groupResetConfirmAction => 'Reiniciar';

  @override
  String get groupResetSuccessTitle => 'Checklist reiniciado';

  @override
  String groupResetSuccessMessage(String name) {
    return 'Las tareas de \"$name\" quedaron sin marcar.';
  }

  @override
  String get groupResetErrorTitle => 'No se pudo reiniciar el checklist';

  @override
  String get groupResetErrorMessage =>
      'No pudimos desmarcar las tareas. Vuelve a intentarlo más tarde.';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsLoadErrorTitle => 'No pudimos cargar tus ajustes';

  @override
  String get settingsUserFallbackName => 'Usuario';

  @override
  String get settingsEmailUnavailable => 'Correo no disponible';

  @override
  String get settingsSectionAccount => 'Cuenta';

  @override
  String get settingsChangePassword => 'Cambiar contraseña';

  @override
  String get settingsManageAccount => 'Gestionar cuenta';

  @override
  String get settingsSectionPreferences => 'Preferencias';

  @override
  String get settingsThemeLabel => 'Tema';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get settingsSectionOther => 'Otros';

  @override
  String get settingsAbout => 'Acerca de la app';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidad';

  @override
  String get settingsTermsOfService => 'Términos del servicio';

  @override
  String get settingsLogout => 'Cerrar sesión';

  @override
  String get settingsLogoutErrorTitle => 'Error al cerrar sesión';

  @override
  String get changePasswordSubmit => 'Guardar cambios';

  @override
  String get changePasswordSuccess => 'Contraseña cambiada.';

  @override
  String get aboutIntro =>
      'Fly Checklist es una solución innovadora para gestionar tareas que aplica la metodología de los checklists de aviación para optimizar tu día a día.\n\nLa clave está en poder crear grupos de checklists \"no persistentes\". Mientras que una lista de tareas tradicional guarda tus marcas, Fly Checklist permite que ciertas listas vuelvan a su estado original después de usarlas, lo que la hace perfecta para rutinas recurrentes.';

  @override
  String get aboutFeaturesTitle => 'Funciones principales:';

  @override
  String get aboutFeatureReusableTitle => 'Checklists reutilizables:';

  @override
  String get aboutFeatureReusableDescription =>
      'La función estrella. Crea una lista para tu rutina (preparar el desayuno, la rutina de ejercicio) y siempre estará lista y sin marcar para la próxima vez, ahorrándote tiempo y esfuerzo.';

  @override
  String get aboutFeatureAviationTitle => 'Metodología de la aviación:';

  @override
  String get aboutFeatureAviationDescription =>
      'Aporta disciplina y precisión para garantizar que no se salte ningún paso de un proceso importante.';

  @override
  String get aboutFeatureGroupingTitle => 'Agrupación inteligente:';

  @override
  String get aboutFeatureGroupingDescription =>
      'Organiza varios checklists en grupos temáticos (\"Mañana\", \"Fin del día\", \"Proyecto X\") y mantén tu vida personal y profesional perfectamente ordenada.';

  @override
  String get aboutFeatureFlexibilityTitle => 'Flexibilidad total:';

  @override
  String get aboutFeatureFlexibilityDescription =>
      'Ideal tanto para una simple lista de tareas como para procesos complejos que exigen una secuencia de acciones verificadas.';

  @override
  String get aboutClosing =>
      'Fly Checklist es la herramienta definitiva para quien quiere convertir rutinas en hábitos sólidos y eficientes.';

  @override
  String aboutVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get aboutDeveloper => 'Desarrollado por Vitor Melo';

  @override
  String aboutCopyright(String year) {
    return '© $year Fly Checklist. Todos los derechos reservados.';
  }
}

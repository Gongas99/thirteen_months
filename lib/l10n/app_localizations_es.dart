// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get tabToday => 'Hoy';

  @override
  String get tabCalendar => 'Calendario';

  @override
  String get tabConverter => 'Conversor';

  @override
  String get tabLearn => 'Aprender';

  @override
  String get label13MonthCalendar => 'Calendario de 13 meses';

  @override
  String get yearDay => 'Día del Año';

  @override
  String get leapDay => 'Día Bisiesto';

  @override
  String get todayInIfc => 'Hoy en el IFC';

  @override
  String get todayIsAlso => 'En el calendario Gregoriano';

  @override
  String get labelGregorian => 'Gregoriano';

  @override
  String get birthdayPromptTitle => '¿Cuándo es tu cumpleaños?';

  @override
  String get birthdayPromptSubtitle =>
      'Descubre tu cumpleaños en el calendario de 13 meses';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsWidget => 'Widget';

  @override
  String get settingsTransparentBg => 'Fondo transparente';

  @override
  String get settingsTransparentBgDesc =>
      'El widget flota sobre tu fondo de pantalla';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get languageSystem => 'Predeterminado del sistema';

  @override
  String get languageEn => 'English';

  @override
  String get languagePt => 'Português';

  @override
  String get languageEs => 'Español';

  @override
  String get languageFr => 'Français';

  @override
  String get languageDe => 'Deutsch';

  @override
  String get languageIt => 'Italiano';

  @override
  String get monthJanuary => 'Enero';

  @override
  String get monthFebruary => 'Febrero';

  @override
  String get monthMarch => 'Marzo';

  @override
  String get monthApril => 'Abril';

  @override
  String get monthMay => 'Mayo';

  @override
  String get monthJune => 'Junio';

  @override
  String get monthSol => 'Sol';

  @override
  String get monthJuly => 'Julio';

  @override
  String get monthAugust => 'Agosto';

  @override
  String get monthSeptember => 'Septiembre';

  @override
  String get monthOctober => 'Octubre';

  @override
  String get monthNovember => 'Noviembre';

  @override
  String get monthDecember => 'Diciembre';

  @override
  String get weekdaySunday => 'Domingo';

  @override
  String get weekdayMonday => 'Lunes';

  @override
  String get weekdayTuesday => 'Martes';

  @override
  String get weekdayWednesday => 'Miércoles';

  @override
  String get weekdayThursday => 'Jueves';

  @override
  String get weekdayFriday => 'Viernes';

  @override
  String get weekdaySaturday => 'Sábado';

  @override
  String get weekdayAbbrSun => 'Dom';

  @override
  String get weekdayAbbrMon => 'Lun';

  @override
  String get weekdayAbbrTue => 'Mar';

  @override
  String get weekdayAbbrWed => 'Mié';

  @override
  String get weekdayAbbrThu => 'Jue';

  @override
  String get weekdayAbbrFri => 'Vie';

  @override
  String get weekdayAbbrSat => 'Sáb';

  @override
  String get gregWeekdayMonday => 'Lunes';

  @override
  String get gregWeekdayTuesday => 'Martes';

  @override
  String get gregWeekdayWednesday => 'Miércoles';

  @override
  String get gregWeekdayThursday => 'Jueves';

  @override
  String get gregWeekdayFriday => 'Viernes';

  @override
  String get gregWeekdaySaturday => 'Sábado';

  @override
  String get gregWeekdaySunday => 'Domingo';

  @override
  String get gregMonthJanuary => 'Enero';

  @override
  String get gregMonthFebruary => 'Febrero';

  @override
  String get gregMonthMarch => 'Marzo';

  @override
  String get gregMonthApril => 'Abril';

  @override
  String get gregMonthMay => 'Mayo';

  @override
  String get gregMonthJune => 'Junio';

  @override
  String get gregMonthJuly => 'Julio';

  @override
  String get gregMonthAugust => 'Agosto';

  @override
  String get gregMonthSeptember => 'Septiembre';

  @override
  String get gregMonthOctober => 'Octubre';

  @override
  String get gregMonthNovember => 'Noviembre';

  @override
  String get gregMonthDecember => 'Diciembre';

  @override
  String get specialDays => 'Días Especiales';

  @override
  String get yearDayDesc =>
      'Después del 28 de diciembre — fuera de cualquier mes o semana';

  @override
  String get leapDayDesc =>
      'Entre el 28 de junio y el 1 de Sol — fuera de la semana';

  @override
  String get calendarFunFact =>
      'El mes 13, Sol, lleva el nombre de la palabra latina para Sol.';

  @override
  String get plusYearDay => '+ Día del Año';

  @override
  String get plusLeapDay => '+ Día Bisiesto';

  @override
  String daysLabel(int count) {
    return '$count días';
  }

  @override
  String monthXOfY(int month) {
    return 'Mes $month de 13';
  }

  @override
  String get swipeToNavigate => 'Desliza para navegar entre meses';

  @override
  String get gregorianColon => 'Gregoriano:';

  @override
  String get weekOfMonthColon => 'Semana del mes:';

  @override
  String xOfY(int x, int y) {
    return '$x de $y';
  }

  @override
  String get gregorianRange => 'Rango gregoriano';

  @override
  String get labelDays => 'Días';

  @override
  String get labelWeeks => 'Semanas';

  @override
  String get gregorianToIfc => 'Gregoriano → IFC';

  @override
  String get ifcToGregorian => 'IFC → Gregoriano';

  @override
  String get gregorianDate => 'Fecha gregoriana';

  @override
  String get ifcDate => 'Fecha IFC';

  @override
  String monthXOfYWeekXOfY(int month, int week) {
    return 'Mes $month de 13  •  Semana $week de 4';
  }

  @override
  String get yearDaySpecialDesc =>
      'Fuera de cualquier mes — un día festivo universal';

  @override
  String get leapDaySpecialDesc => 'Entre junio y Sol — fuera de la semana';

  @override
  String get labelYear => 'Año';

  @override
  String get labelType => 'Tipo';

  @override
  String get regularDay => 'Día regular';

  @override
  String get labelMonth => 'Mes';

  @override
  String get labelDay => 'Día';

  @override
  String get converterFunFact =>
      'Dato curioso: En el IFC, tu cumpleaños siempre cae en el mismo día de la semana, todos los años.';

  @override
  String get yourCalendar => 'Tu calendario';

  @override
  String get dayOutsideCalendar =>
      'Un día fuera del calendario — un día festivo universal';

  @override
  String get extraDayBetween => 'Un día extra entre junio y Sol';

  @override
  String get daysEveryMonth => '28 días cada mes';

  @override
  String get learnHeader => 'La idea completa\nen 30 segundos';

  @override
  String get everyMonthLooksLikeThis => 'Todos los meses se ven así';

  @override
  String get historyTitle => 'Historia';

  @override
  String get faqTitle => 'Preguntas frecuentes';

  @override
  String get quickFact1 =>
      'Cada mes tiene exactamente 28 días — 4 semanas perfectas.';

  @override
  String get quickFact2 =>
      'Hay 13 meses: el mes extra se llama Sol, entre junio y julio.';

  @override
  String get quickFact3 =>
      'El Día del Año (29 de diciembre) queda fuera de cualquier mes o semana — un día festivo universal.';

  @override
  String get quickFact4 =>
      'En los años bisiestos, el Día Bisiesto cae entre junio y Sol — también fuera de la semana.';

  @override
  String get timelineYear1 => '1902';

  @override
  String get timelineTitle1 => 'Moses Cotsworth propone el IFC';

  @override
  String get timelineDesc1 =>
      'El contable británico Moses B. Cotsworth publica \"The Rational Almanac\", proponiendo un calendario de 13 meses para simplificar la contabilidad empresarial.';

  @override
  String get timelineYear2 => '1922';

  @override
  String get timelineTitle2 =>
      'La Sociedad de Naciones considera la reforma del calendario';

  @override
  String get timelineDesc2 =>
      'La Sociedad de Naciones establece un comité para estudiar la reforma del calendario, con el IFC como candidato principal.';

  @override
  String get timelineYear3 => '1928';

  @override
  String get timelineTitle3 => 'George Eastman adopta el IFC';

  @override
  String get timelineDesc3 =>
      'El fundador de Kodak, George Eastman, adopta el IFC para la contabilidad interna de Kodak. La empresa lo usa hasta 1989.';

  @override
  String get timelineYear4 => '1937';

  @override
  String get timelineTitle4 => 'La votación en la ONU no prospera';

  @override
  String get timelineDesc4 =>
      'La votación de la Sociedad de Naciones sobre el IFC no logra la aprobación unánime, en gran parte debido a objeciones religiosas sobre la ruptura del ciclo sabático de 7 días.';

  @override
  String get timelineYear5 => '1989';

  @override
  String get timelineTitle5 => 'Kodak deja de usar el IFC';

  @override
  String get timelineDesc5 =>
      'Después de más de 60 años, Kodak deja de usar el Calendario Fijo Internacional para operaciones internas.';

  @override
  String get timelineYear6 => 'Ahora';

  @override
  String get timelineTitle6 => 'Creciente interés en línea';

  @override
  String get timelineDesc6 =>
      'El IFC ha encontrado nueva popularidad a través de redes sociales y sitios web como 13months.net, con defensores que destacan su simplicidad.';

  @override
  String get faq1Question => '¿Por qué 13 meses?';

  @override
  String get faq1Answer =>
      '13 × 28 = 364 días, solo uno menos que un año normal. Cada mes tiene exactamente 4 semanas, haciendo que la planificación, facturación y organización sean perfectamente regulares. El día restante se convierte en el Día del Año, un día festivo especial.';

  @override
  String get faq2Question => '¿Qué es Sol?';

  @override
  String get faq2Answer =>
      'Sol es el séptimo mes, insertado entre junio y julio. Lleva el nombre del Sol (del latín \"sol\"). En el IFC, los meses después de junio cambian: Sol, julio, agosto, septiembre, octubre, noviembre, diciembre.';

  @override
  String get faq3Question => '¿Qué es el Día del Año?';

  @override
  String get faq3Answer =>
      'El Día del Año cae después del 28 de diciembre (el último día regular) y antes del 1 de enero del año siguiente. No pertenece a ningún mes ni día de la semana — es un día libre universal, asegurando que cada año comience en domingo.';

  @override
  String get faq4Question => '¿Cómo funcionan los años bisiestos?';

  @override
  String get faq4Answer =>
      'Los años bisiestos siguen las mismas reglas que el calendario gregoriano (cada 4 años, excepto los siglos no divisibles por 400). El día extra, el Día Bisiesto, se inserta entre el 28 de junio y el 1 de Sol. Como el Día del Año, no tiene día de la semana.';

  @override
  String get faq5Question => '¿Qué día de la semana es mi cumpleaños?';

  @override
  String get faq5Answer =>
      '¡En el IFC, cada fecha cae en el mismo día de la semana todos los años! Si tu cumpleaños IFC es el 15, siempre es domingo. Usa la pestaña Conversor para encontrar tu cumpleaños IFC.';

  @override
  String get faq6Question => '¿Podría adoptarse realmente este calendario?';

  @override
  String get faq6Answer =>
      'El mayor obstáculo es la tradición y la interrupción del ciclo sabático continuo de 7 días. El Día del Año y el Día Bisiesto rompen el patrón semanal, lo que algunas tradiciones religiosas consideran inaceptable. A pesar de esto, el IFC sigue siendo una de las propuestas de reforma del calendario más prácticas.';

  @override
  String get onboardingWelcomeTitle => '¿Y si cada mes\nfuera perfecto?';

  @override
  String get onboardingWelcomeBody =>
      'Descubre un calendario donde cada mes tiene exactamente 28 días — simple, equilibrado y armonioso.';

  @override
  String get onboardingTitle1 => '13 Meses Perfectos';

  @override
  String get onboardingBody1 =>
      'Cada mes tiene exactamente 28 días — 4 semanas perfectas. No más preguntarse en qué día cae el 15.';

  @override
  String get onboardingTitle2 => 'Conoce a Sol';

  @override
  String get onboardingBody2 =>
      'El séptimo mes, Sol, se sitúa entre junio y julio. Nombrado en honor al Sol, completa el año de 13 meses.';

  @override
  String get onboardingTitle3 => 'Día del Año y Día Bisiesto';

  @override
  String get onboardingBody3 =>
      'El Día del Año (después del 28 de dic.) no pertenece a ningún mes ni semana — un día festivo universal. El Día Bisiesto funciona de la misma manera, cayendo entre junio y Sol.';

  @override
  String get onboardingTitle4 => 'Explora el Calendario';

  @override
  String get onboardingBody4 =>
      'Consulta la fecha IFC de hoy, navega por los 13 meses, convierte fechas y aprende la historia. ¡Comencemos!';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get next => 'Siguiente';

  @override
  String get skip => 'Omitir';

  @override
  String get funFact1 =>
      'En el IFC, cada mes comienza en domingo y termina en sábado.';

  @override
  String get funFact2 => '¡Viernes 13 ocurre todos los meses en el IFC!';

  @override
  String get funFact3 =>
      'Tu cumpleaños IFC siempre cae en el mismo día de la semana, todos los años.';

  @override
  String get funFact4 =>
      'Kodak usó el IFC internamente durante más de 60 años (1928–1989).';

  @override
  String get funFact5 =>
      'El mes 13, Sol, lleva el nombre de la palabra latina para Sol.';

  @override
  String get funFact6 =>
      '13 × 28 = 364. Añade el Día del Año (y el Día Bisiesto) para completar el año.';

  @override
  String get funFact7 =>
      'George Eastman fue el mayor defensor corporativo del IFC.';

  @override
  String get funFact8 =>
      'Cada trimestre IFC tiene exactamente 91 días (13 semanas).';

  @override
  String get funFactLabel => '¿Sabías que?';

  @override
  String get tapForNewFact => 'Toca para otro dato';

  @override
  String get visitWebsite => 'Visitar Sitio Web';
}

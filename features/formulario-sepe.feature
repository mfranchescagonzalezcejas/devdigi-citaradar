# language: en
# Synthetic portal only. Does not call the real SEPE service.
Feature: Formulario dinámico SEPE

  @smoke @FORM-001 @CITA-104
  Scenario: FORM-001 — Código postal y tipo de oficina
    Given Código postal ficticio válido y portal simulado
    And Tipo de oficina permitido por el fixture
    When Introducir el código postal y esperar a que aparezca el tipo de oficina
    Then El portal acepta el código postal y ofrece tipos de oficina válidos
    When Seleccionar el tipo de oficina ofrecido
    Then Se habilita el paso siguiente sin selección inválida
    When Continuar con la selección
    Then La aplicación alcanza el estado siguiente sin error

  @smoke @FORM-002 @CITA-105
  Scenario: FORM-002 — Trámite con un único subtrámite
    Given Trámite con exactamente un subtrámite
    When Seleccionar el trámite en el formulario dinámico simulado
    Then El desplegable dependiente contiene exactamente una opción válida
    When Inspeccionar las opciones e ignorar la opción placeholder
    Then La única opción válida se selecciona automáticamente
    When Continuar
    Then No se ha solicitado una elección redundante al usuario

  @regression @FORM-003 @CITA-106
  Scenario: FORM-003 — Trámite con múltiples subtrámites
    Given Fixture de trámite con tres subtrámites válidos
    And Preferencia configurada para un subtrámite válido
    When Elegir el trámite
    Then Se muestran las tres opciones dependientes
    When Seleccionar el subtrámite correspondiente
    Then Se conserva el subtrámite solicitado por el usuario
    When Volver a leer el control antes de continuar
    Then La opción continúa habilitada y no hay selección obsoleta

  @regression @FORM-004 @CITA-107
  Scenario: FORM-004 — Trámite sin campo de subtrámite
    Given Fixture de trámite sin campo de subtrámite
    When Elegir el trámite
    Then No se presenta campo adicional
    When Validar los controles requeridos
    Then No se exige un subtrámite inexistente
    When Continuar
    Then El flujo avanza sin error

  @regression @FORM-005 @CITA-108
  Scenario: FORM-005 — Trámite cambia opciones disponibles
    Given Fixture con dos trámites y distintos subtrámites
    And Segundo trámite configurado
    When Seleccionar el primer trámite y su subtrámite
    Then La selección inicial es válida
    When Cambiar de trámite y esperar la nueva carga
    Then Se descartan las opciones anteriores
    When Examinar la selección dependiente
    Then No queda seleccionado un subtrámite del trámite anterior

  @smoke @FORM-006 @CITA-109
  Scenario: FORM-006 — NIF/NIE no aparece en logs
    Given Documento sintético de pruebas, nunca un DNI/NIE real
    When Introducir el documento en el formulario simulado
    Then El campo contiene el identificador de prueba
    When Realizar la transición y capturar logs de prueba
    Then El flujo se completa o muestra validación controlada
    When Buscar el identificador en logs, trazas y capturas
    Then El identificador no aparece en ningún artefacto

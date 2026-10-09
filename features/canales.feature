# language: en
# Synthetic portal only. Does not call the real SEPE service.
Feature: Descubrimiento de canal

  @smoke @CHANNEL-001 @CITA-110
  Scenario: CHANNEL-001 — Canales presencial y telefónica
    Given Canal con placeholder, Presencial y Telefónica habilitados
    When Inspeccionar el desplegable al llegar al mapa
    Then Se detectan exactamente dos opciones válidas
    When Solicitar modalidad al usuario
    Then La preferencia se pregunta una sola vez
    When el usuario elige Presencial
    When Guardar elección para la sesión y aplicar al canal objetivo
    Then El canal objetivo es Presencial; Telefónica no se interpreta como cita deseada

  @smoke @CHANNEL-002 @CITA-111
  Scenario: CHANNEL-002 — Solo presencial
    Given Solo Presencial habilitado; placeholder adicional
    When Inspeccionar las opciones válidas del desplegable
    Then Se detecta exactamente Presencial
    When Aplicar automáticamente la única opción
    Then Se selecciona Presencial sin pedir preferencia
    When Verificar el estado de monitorización
    Then El objetivo de la consulta es Presencial

  @smoke @CHANNEL-003 @CITA-112
  Scenario: CHANNEL-003 — Solo telefónica
    Given Solo Telefónica habilitado; placeholder adicional
    When Inspeccionar las opciones válidas del desplegable
    Then Se detecta exactamente Telefónica
    When Aplicar automáticamente la única opción
    Then Se selecciona Telefónica sin pedir preferencia
    When Verificar el estado de monitorización
    Then El objetivo de la consulta es Telefónica

  @regression @CHANNEL-004 @CITA-113
  Scenario: CHANNEL-004 — Sin canales habilitados
    Given Desplegable con solo un placeholder
    When Enumerar todas las opciones
    Then No se detecta ninguna modalidad válida
    When Intentar resolver el objetivo de búsqueda
    Then Se devuelve estado bloqueado o sin opciones
    When Comprobar controles y registros
    Then No se selecciona el placeholder ni se produce un bucle

  @regression @CHANNEL-005 @CITA-114
  Scenario: CHANNEL-005 — Ignorar placeholder y disabled
    Given Fixture con placeholder y una opción deshabilitada
    When Enumerar las opciones del desplegable
    Then Las opciones inválidas se identifican correctamente
    When Filtrar valores vacíos, placeholders y disabled
    Then Solo permanecen modalidades habilitadas
    When Contar modalidades disponibles
    Then El total no incluye las opciones descartadas

  @regression @CHANNEL-006 @CITA-115
  Scenario: CHANNEL-006 — Canal objetivo no mezclado en refresh
    Given Se elige Presencial; también existe Telefónica
    And Cita solo telefónica en fixture
    When Seleccionar Telefónica como canal técnico de refresco
    Then No se consideran los resultados telefónicos como objetivo
    When Analizar el panel temporal de resultados
    Then No se genera alerta de cita presencial
    When Regresar al objetivo Presencial y analizar su resultado
    Then Solo una cita presencial válida puede disparar alerta

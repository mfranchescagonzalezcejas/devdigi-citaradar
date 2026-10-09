# language: en
# Synthetic portal only. Does not call the real SEPE service.
Feature: Disponibilidad y municipio

  @smoke @OFFICE-001 @CITA-116
  Scenario: OFFICE-001 — Sin citas disponibles
    Given Fixture sin citas para canal elegido
    When Seleccionar canal objetivo y esperar a estado estable
    Then El panel muestra ausencia de disponibilidad
    When Clasificar estado del panel
    Then Se detecta NO_AVAILABILITY y no AVAILABLE
    When Iniciar planificación de siguiente intento
    Then Se programa espera controlada, sin bucle intensivo

  @smoke @OFFICE-002 @CITA-117
  Scenario: OFFICE-002 — Oficina válida en Barcelona ciudad
    Given Fixture con oficina cuyo municipio verificado es Barcelona
    And Municipio aceptado: Barcelona
    When Extraer oficina y primer hueco
    Then El detector reconoce una cita con datos de oficina
    When Aplicar filtro geográfico exacto
    Then La oficina cumple el filtro
    When Emitir notificación y pausar monitor
    Then Se muestra oficina y horario; no se confirma ni reserva la cita

  @smoke @OFFICE-003 @CITA-118
  Scenario: OFFICE-003 — Oficina en Terrassa descartada
    Given Fixture con oficina de Terrassa y franja disponible
    And Municipio aceptado: Barcelona
    When Extraer el resultado y municipio
    Then El parser reconoce la oficina de Terrassa
    When Aplicar filtro de municipio
    Then La oficina queda excluida
    When Evaluar necesidad de alerta
    Then No se notifica como coincidencia válida

  @regression @OFFICE-004 @CITA-119
  Scenario: OFFICE-004 — Barcelona provincia no equivale a municipio
    Given Oficina ubicada en Sabadell, provincia Barcelona
    And Municipio aceptado: Barcelona
    When Extraer provincia y municipio por separado
    Then La provincia es Barcelona y el municipio es Sabadell
    When Aplicar coincidencia por municipio, no provincia
    Then La oficina queda excluida
    When Revisar el resultado final
    Then No se genera falso positivo

  @regression @OFFICE-005 @CITA-120
  Scenario: OFFICE-005 — Oficina con municipio desconocido
    Given Fixture con municipio ausente o no verificable
    When Extraer la oficina y metadatos
    Then El municipio se representa como desconocido
    When Evaluar filtro geográfico
    Then No se valida de manera automática
    When Presentar el estado al usuario
    Then Solicita revisión manual y no genera coincidencia verificada

# language: en
# Synthetic portal only. Does not call the real SEPE service.
Feature: Monitorización controlada

  @regression @MONITOR-001 @CITA-121
  Scenario: MONITOR-001 — Refresco espera actualización efectiva
    Given El panel de resultados tiene una instantánea estable
    And Fixture sin evento de actualización
    When Guardar estado previo antes de cambiar el canal
    Then Existe un estado anterior de referencia
    When Cambiar canal una vez y esperar señal de actualización del DOM
    Then No se interpreta el mero clic como resultado renovado
    When Agotar el timeout de espera
    Then Devuelve timeout controlado sin reintentos intensivos

  @regression @MONITOR-002 @CITA-122
  Scenario: MONITOR-002 — Canal único no alternable
    Given Desplegable con solo canal Presencial
    When Evaluar canales disponibles
    Then No hay un segundo canal para alternar
    When Solicitar un reintento
    Then No se pulsa repetidamente la misma opción
    When Aplicar política de refresco
    Then Solo se emplea mecanismo legítimo permitido o se requiere intervención manual

  @smoke @MONITOR-003 @CITA-123
  Scenario: MONITOR-003 — Sesión caducada
    Given Fixture con sesión expirada
    When Iniciar la comprobación
    Then El monitor identifica la falta de autenticación
    When Detener la secuencia automática
    Then Se pausa y solicita nueva identificación manual
    When Inspeccionar trazas
    Then No se intenta enviar contraseña ni superar mecanismos de autenticación

  @regression @MONITOR-004 @CITA-124
  Scenario: MONITOR-004 — Error de red / portal
    Given Fixture con error HTTP 5xx o red fallida
    When Ejecutar una comprobación
    Then El error no se confunde con falta de citas
    When Ejecutar política de backoff y límites
    Then El tiempo de espera aumenta de forma controlada
    When Alcanzar límite de errores
    Then El monitor se pausa o detiene e informa al usuario

  @smoke @MONITOR-005 @CITA-125
  Scenario: MONITOR-005 — Detención manual
    Given Fixture con monitor activo
    When Pulsar Detener en la UI
    Then Se solicita cancelación
    When Esperar al estado STOPPED
    Then No hay nuevas consultas ni acciones posteriores
    When Revisar navegador
    Then El usuario conserva control y no se pulsa Continuar/Reservar

  @regression @MONITOR-006 @CITA-126
  Scenario: MONITOR-006 — Alerta duplicada
    Given Una misma cita aparece en consultas consecutivas
    When Registrar primera coincidencia
    Then Se emite una sola alerta de la cita
    When Volver a procesar la misma oficina, canal y horario
    Then La clave de deduplicación coincide
    When Revisar notificaciones
    Then No se emite una segunda alerta idéntica

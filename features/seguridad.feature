# language: en
# Synthetic portal only. Does not call the real SEPE service.
Feature: Privacidad y seguridad

  @regression @SEC-001 @CITA-127
  Scenario: SEC-001 — Perfil seguro en disco
    Given Perfil con un identificador completamente ficticio
    When Guardar la configuración de prueba
    Then Las preferencias no sensibles se almacenan localmente
    When Inspeccionar configuración en texto plano y logs
    Then No hay DNI/NIE en TOML, logs ni repo
    When Recuperar identificador por mecanismo de credenciales del sistema
    Then El identificador se recupera desde almacenamiento protegido

  @regression @SEC-002 @CITA-128
  Scenario: SEC-002 — No usar claves permanentes
    Given Fixture de sesión caducada y sin credenciales guardadas
    When Detectar expiración
    Then Se informa de sesión no válida
    When Solicitar reanudación del flujo
    Then Se pide al usuario autenticarse manualmente
    When Inspeccionar peticiones y estado del monitor
    Then No se envía Cl@ve Permanente ni se eluden controles

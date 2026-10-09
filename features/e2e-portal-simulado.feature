# language: en
# Synthetic portal only. Does not call the real SEPE service.
Feature: E2E con portal simulado

  @smoke @E2E-001 @CITA-129
  Scenario: E2E-001 — Portal simulado sin tráfico externo
    Given Portal SEPE simulado mediante fixture offline
    When Configurar Playwright para usar exclusivamente fixture local
    Then Se inicializa entorno sin dependencia real de SEPE
    When Ejecutar flujo E2E y registrar tráfico
    Then El flujo completo se valida con datos inventados
    When Inspeccionar hosts solicitados
    Then No hay solicitudes a sede.sepe.gob.es ni credenciales reales

# INFORME EJECUTIVO — ENTENDIMIENTO DEL ALCANCE SICOM

**Para:** Luis Felipe Herrera y Luis Marentes — CI2  
**De:** Jelkin Zair Carrillo Franco — Gerente de Proyecto, Innovadataco  
**Fecha:** 13 de mayo de 2026  
**Asunto:** Comprensión del alcance, operación y características de la plataforma SICOM

---

## 1. RESUMEN EJECUTIVO

Se realizó revisión exhaustiva del Anexo Técnico del contrato SICOM (196,091 caracteres, ~76 páginas) y del Plan de Empalme preparado por CI2. Este documento consolida el entendimiento técnico y operativo de la plataforma para soporte de la transición con Internexa.

**Veredicto:** SICOM es una plataforma de misión nacional con 100,000+ transacciones mensuales, 25,000-45,000 usuarios, y arquitectura crítica (Oracle RAC, VMware, nube privada Tier III). El empalme requiere disciplina extrema.

---

## 2. ¿QUÉ ES SICOM?

**SICOM** = Sistema de Información de Combustibles del Ministerio de Minas y Energía (MME).

No es solo un repositorio de datos. Es el **Administrador Oficial de la Información del Mercado de Combustibles Líquidos de Colombia**.

### 2.1 Funciones Estratégicas

| Función | Descripción |
|---------|-------------|
| **Registro de agentes** | Censo nacional de productores, refinadores, importadores, mayoristas, minoristas (EDS), grandes consumidores |
| **Trazabilidad transaccional** | Cada litro de combustible reportado y rastreado desde origen hasta consumidor final |
| **Balances volumétricos** | Control de cupos por zona, frontera, electrificadoras. Prevención de desvío |
| **Administración de subsidios** | Fiscalización de beneficios tributarios por combustible/región |
| **Estadísticas sectoriales** | Datos para diseño de política pública energética |
| **Control de precios** | Registro y seguimiento de precios en toda la cadena |

### 2.2 Segmentos del Mercado

| Segmento | Combustibles | Actores Clave |
|----------|-------------|---------------|
| **Líquidos** | Gasolina, diésel, biocombustibles, derivados | PRIMA (Productores, Refinadores, Importadores, Mayoristas), EDS, grandes consumidores (transporte, aviación, térmicas, industria) |
| **Gas Combustible** | GNCV (Gas Natural Comprimido Vehicular), Auto GLP | Distribuidores, estaciones GNCV, flotas |

---

## 3. ARQUITECTURA TÉCNICA

### 3.1 Stack Tecnológico

| Capa | Tecnología |
|------|-----------|
| **Backend** | Java |
| **BPM** | Bizagi (flujos de proceso de negocio) |
| **Base de Datos** | Oracle 19c en Clúster (Oracle RAC) + SQL Server |
| **Virtualización** | VMware |
| **Control de Versiones** | Git |
| **BI** | Cubos y tableros (pendiente confirmar herramienta específica) |
| **Web** | Portal web + aplicaciones móviles |

### 3.2 Infraestructura

| Componente | Especificación |
|------------|---------------|
| **DC Principal** | Zona metropolitana Bogotá (máximo 40 km de sede MME) |
| **DC Alterno** | Ciudad colombiana distinta a Bogotá |
| **Nube** | Privada, propiedad del oferente o modelo de servicio con control total del oferente |
| **Balanceo** | Balanceadores de carga para alta disponibilidad |
| **Almacenamiento** | Crecimiento de capacidad de cómputo: 4% mensual |
| **RAC Oracle** | Clúster activo-pasivo garantizando alta disponibilidad |

### 3.3 Seguridad Mínima Exigida

| Control | Requerimiento |
|---------|---------------|
| **Autenticación** | Multifactor (MFA) para mínimo 45,000 usuarios nombrados |
| **Autorización** | RBAC (Role-Based Access Control) |
| **Red** | Firewall de red + Firewall de Aplicaciones Web (WAF) |
| **Endpoints** | Antivirus sobre plataforma de virtualización |
| **Cifrado** | Protocolos de cifrado en tránsito y en reposo |
| **Logs** | Trazabilidad de transacciones y conexiones (6 meses mínimo) |
| **Acceso supervisor** | 40 usuarios consulta MME, 4 usuarios supervisión código en repositorio |

---

## 4. OPERACIÓN EN NÚMEROS

### 4.1 Volumetría de Procesos (mensual)

| Proceso | Casos Instanciados/Mes |
|---------|------------------------|
| Orden de Pedido Simple | **100,017** |
| Recibir Guía Digital | **89,223** |
| Orden de Pedido Transferencia | **6,854** |
| Registro de Precios | **5,060** |
| Gestionar Solicitudes OP Programada | **1,610** |
| Validación Documentos Vehículo | **1,751** |
| Validar Datos | **1,104** |
| Reasignación de Casos | **432** |
| Orden de Pedido Traslado | **384** |
| Orden de Pedido Programada | **783** |
| Gestionar Usuarios | **189** |
| Notificar Vigencia Documentos Agente | **27** |
| Replicación Agentes Sicom | **17** |
| Orden de Pedido Anticipada Nominal | **84** |
| Orden de Pedido Anticipada Individual | **316** |

**Total procesos transaccionales mensuales: ~210,000+ casos**

### 4.2 Usuarios y Licencias

| Tipo | Cantidad |
|------|----------|
| Usuarios nombrados (inicial) | 25,000 |
| Usuarios nombrados (crecimiento estimado) | 45,000 |
| Licencias administración | 40 |
| Licencias seguimiento/control MME | 15 |
| Usuarios externos concurrentes | 15,000 |

### 4.3 Centros de Contacto

| Servicio | Descripción |
|----------|-------------|
| **Call Center** | Atención telefónica con herramientas tipo XCALLY, Primo Dialler, Kixie, Wolkvox o equivalente |
| **Portal Autogestión** | Atención de incidentes y requerimientos sin intervención humana |
| **Mesa de Servicio** | Primer nivel de atención con herramienta de ticketing |
| **Cobertura** | 25,000 usuarios iniciales, escalable a 45,000 |

---

## 5. ACUERDOS DE NIVELES DE SERVICIO (ANS)

| Línea de Servicio | Meta | Multa por Incumplimiento |
|-------------------|------|--------------------------|
| **Disponibilidad Plataforma SICOM Líquidos** | > 99.90% (Tier III) | 0.5% descuento en facturación mensual por cada 0.1% por debajo |
| **Disponibilidad Plataforma SICOM GNCV** | > 99.90% (Tier III) | 0.5% descuento en facturación mensual por cada 0.1% por debajo |
| **Tiempo de Respuesta Centro de Contacto** | Definido en anexo | Penalización por incumplimiento |
| **Resolución Incidentes** | Definido por severidad | Penalización por incumplimiento |

**Nota:** Las evidencias de cumplimiento deben ser verificables por el equipo supervisor del MME mediante acceso a herramientas y reportes de monitoreo.

---

## 6. CONTINUIDAD Y RECUPERACIÓN

| Parámetro | Requerimiento |
|-----------|---------------|
| **RPO (Punto de Recuperación Objetivo)** | Máximo 30 minutos |
| **RTO (Tiempo de Recuperación Objetivo)** | Según estrategia de recuperación numeral 8 |
| **Replicación** | Real-time entre DC Principal y DC Alterno, sin afectar desempeño |
| **Backup** | VMs, BD, logs, código fuente. Incremental diario, full mensual, especial bajo solicitud |
| **Contingencia** | DC Alterno opera con misma tecnología que DC Principal. Activación bajo demanda. Retorno acordado con MME |
| **Crecimiento** | 4% mensual de capacidad de cómputo |

---

## 7. ENTREGABLES DEL CONTRATO

### 7.1 Fases de Ejecución

| Fase | Periodo | Actividades |
|------|---------|-------------|
| **Empalme / Transferencia** | Previo al 1 julio 2026 | Recibo de sistema, migración datos, accesos, capacitación, pruebas, actas |
| **Administración, Operación, Soporte, Mantenimiento** | 1 julio → 30 noviembre 2026 | Operación 24/7, soporte, mantenimiento preventivo/correctivo, evolutivos |
| **Acompañamiento Operacional** | Últimos 2 meses + inicio nuevo contrato | Análisis técnico, evaluación evolutivos, estrategia futura |

### 7.2 Informes Mensuales Obligatorios

| Informe | Periodicidad | Contenido |
|---------|-------------|-----------|
| **Informe Mensual de Gestión** | Mensual (5 días hábiles del mes siguiente) | Cumplimiento ANS, infraestructura, BI, seguridad, centro de datos, backup, comunicaciones, call center, mesa de servicio, formación, operación estadística, avance evolutivos |
| **Informe Ejecutivo** | Mensual | Máximo 8 páginas. Comparativos históricos por servicio. Acciones de mejora |
| **Informe Final** | Al cierre del contrato | Estado del sistema, lecciones aprendidas, recomendaciones |
| **Informe de Empalme** | Único (inicio) | Estado de recepción del sistema, actividades ejecutadas, condiciones de recibo |

---

## 8. REQUERIMIENTOS DE CAPACITACIÓN Y FORMACIÓN

| Actividad | Alcance |
|-----------|---------|
| **Formación a usuarios** | Agentes, actores, involucrados en uso del sistema |
| **Evaluación** | Encuestas satisfacción 1-5. Puntaje considerado para evaluación ANS |
| **Modalidad** | Interactiva, presencial o virtual |
| **Materiales** | Manuales, guías, videos tutoriales |

---

## 9. ENTENDIMIENTO DE LA CADENA DE VALOR

```
[Productores/Refinadores/Importadores] → [Mayoristas] → [Minoristas (EDS)] → [Consumidor Final]
                                    ↓
                              [Grandes Consumidores] → [Transporte, Aviación, Térmicas, Industria]
                                    ↓
                           [SICOM] ← Registro, Trazabilidad, Balances, Precios, Subsidios
                                    ↓
                           [MME] ← Toma de decisiones, Política pública, Fiscalización
```

**Todos los agentes deben estar registrados en SICOM con código único.** Cada transacción física de combustible debe reflejarse en la plataforma. El incumplimiento tiene sanciones regulatorias.

---

## 10. RIESGOS ESTRATÉGICOS IDENTIFICADOS

| Riesgo | Impacto | Mitigación Propuesta |
|--------|---------|---------------------|
| **Corte de servicio durante empalme** | 🔴 Crítico | Operación en sombra, checklist Go/No-Go, contingencia lista |
| **Falta de documentación de Internexa** | 🔴 Crítico | Exigir en comité directivo, actas formales, matriz de entregables |
| **Deuda técnica del sistema** | 🟡 Alto | Inventario técnico, evaluación de librerías obsoletas, plan de remediación |
| **Crecimiento 4% mensual de capacidad** | 🟡 Alto | Monitoreo proactivo, escalamiento anticipado |
| **45,000 usuarios MFA** | 🟡 Alto | Pruebas de carga, licenciamiento correcto, plan de rollout |
| **RPO 30 min / RTO implícito** | 🟡 Alto | Validar con pruebas reales antes del corte |

---

## 11. CONCLUSIONES Y RECOMENDACIONES

1. **SICOM no es un sistema más.** Es infraestructura crítica nacional. Cualquier falla afecta directamente la operación del mercado de combustibles de Colombia.

2. **La magnitud es considerable.** 210,000+ procesos mensuales, 45,000 usuarios, dos data centers, arquitectura Oracle RAC + VMware. Requiere equipo técnico sólido.

3. **El empalme es la fase más riesgosa.** Con Internexa quedan ~5-6 semanas para recibir un sistema vivo sin interrupción. La operación en sombra y la validación cruzada son no negociables.

4. **Innovadataco debe priorizar:**
   - Conformación inmediata del equipo técnico (arquitecto, DBA, DevOps, seguridad)
   - Primera reunión con Internexa esta semana (mes técnica diaria)
   - Validación de infraestructura nube privada (¿existe? ¿hay que construirla?)
   - Accesos de lectura progresivos a sistemas de Internexa

5. **CI2 debe presionar al MME** para que Internexa coopere con el empalme. Sin presión contractual, el saliente puede retrasar entregables.

---

**Preparado por:** ZEUS — Sistema de Inteligencia Empresarial, Innovadataco  
**Fecha:** 13 de mayo de 2026

---

*Este informe se basa exclusivamente en la revisión del Anexo Técnico del contrato SICOM y el Plan de Empalme preparado por CI2. No incluye información no revisada ni suposiciones sin base documental.*

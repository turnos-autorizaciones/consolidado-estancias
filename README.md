# Consolidado de Estancias · Programa Hospitalario

Programa web de un solo archivo para **subir turnos quirúrgicos (TQ)** y **notas operatorias (N.O.)**
con los encabezados de cada ítem, capturar registros a mano, importar/exportar Excel o CSV y
sincronizar con Supabase.

## Archivos

| Archivo | Qué es |
|---|---|
| `programa-hospitalario.html` | El programa. Se abre con doble clic en Chrome/Edge (PC, tablet o móvil). No necesita instalación. |
| `supabase-hospitalario.sql` | Crea las tablas `turnos_quirurgicos` y `notas_operatorias` con sus políticas de seguridad. Ya fue ejecutado en el proyecto. |
| `.gitignore` | Evita subir por error Excel, CSV, PDF o imágenes con datos de pacientes. |

## Cómo se usa

1. Abre `programa-hospitalario.html` en el navegador (o descárgalo y ábrelo).
2. Entra con el correo del hospital y su contraseña. La sesión queda recordada 12 horas en ese equipo.
3. Pestañas **TQ · Turnos Quirúrgicos** y **N.O. · Notas Operatorias**:
   - **Subir Excel/CSV**: detecta la hoja, la fila de encabezados y mapea los campos; muestra una vista previa antes de importar. Si un registro ya existe (misma fecha + hora + documento, o fecha + hora + folio) lo actualiza en vez de duplicarlo.
   - **Nuevo registro / Editar**: formulario campo por campo.
   - **Exportar Excel / CSV**: genera un libro con las hojas `TQ`, `N.O.` y `Listas`.
   - Columnas con desplegable: **AUTORIZADOR** y **ESTADO**; se guardan al instante al cambiarlas.
4. Barra superior: buscador, filtro por fechas, por autorizador y **Sincronizar** con Supabase.
5. **Listas**: catálogos que alimentan los desplegables (EPS, autorizadores, servicios, especialidades…).
6. **Configuración**: proyecto de Supabase, acceso, exportación y respaldo.

## Proyecto Supabase

- Nombre: **Consolidado de Estancias**
- Referencia: `cfpsjqrpulyqkyglhynv`
- URL: `https://cfpsjqrpulyqkyglhynv.supabase.co`
- Usuario de acceso: `autorizacioneshospitalarias@hospitalsanjose.gov.co`
  (la contraseña **no** se guarda en este repositorio)
- Tablas: `turnos_quirurgicos` (TQ) y `notas_operatorias` (N.O.), con RLS que permite
  leer y guardar solo a usuarios con sesión iniciada.

## Advertencias importantes

- **Nunca subir archivos con datos de pacientes** a este repositorio (Excel, CSV, capturas, PDF).
  Los datos viven en Supabase; en el navegador solo queda un respaldo local del propio equipo.
- La clave que va dentro del HTML es la **pública (anon)**, que está pensada para ir en el cliente.
  La contraseña del usuario de acceso nunca se escribe en el archivo: se pide al abrir.
- Si se pierde la contraseña del usuario, se restablece en Supabase → Authentication → Users.
- Si algún día hay que reinstalar el esquema en otro proyecto: Supabase → SQL Editor →
  pegar todo `supabase-hospitalario.sql` → Run (debe responder “Success. No rows returned”).

## Conectarlo a este repositorio con git (opcional)

```bash
git init
git add .
git commit -m "Programa hospitalario: TQ y N.O."
git branch -M main
git remote add origin https://github.com/turnos-autorizaciones/consolidado-estancias.git
git push -u origin main
```

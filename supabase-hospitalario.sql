-- PROGRAMA HOSPITALARIO · TQ (Turnos Quirúrgicos) y N.O. (Notas Operatorias)
-- Proyecto Supabase: "Consolidado de Estancias"  (ref: cfpsjqrpulyqkyglhynv)
-- URL: https://cfpsjqrpulyqkyglhynv.supabase.co
--
-- YA EJECUTADO y verificado en ese proyecto (tablas creadas, usuario de acceso creado).
-- Este archivo sirve igual para reinstalar el esquema o duplicarlo en otro proyecto:
--   Supabase -> SQL Editor -> pegar completo -> Run  (debe decir "Success. No rows returned")
--
-- Las políticas dejan leer y guardar SOLO a usuarios con sesión iniciada
-- (usuario: autorizacioneshospitalarias@hospitalsanjose.gov.co).
-- Si prefieres entrar sin iniciar sesión, descomenta las dos políticas "anon" del final.

-- ============================================================
-- TQ · TURNOS QUIRÚRGICO
-- ============================================================
create table if not exists public.turnos_quirurgicos (
  id text primary key,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  fecha date,
  hora text,
  documento text,
  nom_paciente text,
  procedimiento text,
  codigo text,
  eps text,
  ingreso text,
  tipo_ingr text,
  cie10 text,
  autorizacion text,
  num_autorizacion text,
  estado text,
  observacion text,
  autorizador text
);

-- Por si la tabla ya existía antes de agregar el campo ESTADO:
alter table public.turnos_quirurgicos add column if not exists estado text;

alter table public.turnos_quirurgicos enable row level security;
drop policy if exists "acceso_turnos_quirurgicos" on public.turnos_quirurgicos;
create policy "acceso_turnos_quirurgicos" on public.turnos_quirurgicos
  for all to authenticated using (true) with check (true);
create index if not exists idx_turnos_quirurgicos_fecha on public.turnos_quirurgicos(fecha desc);

-- ============================================================
-- N.O. · NOTAS OPERATORIAS
-- ============================================================
create table if not exists public.notas_operatorias (
  id text primary key,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  fecha date,
  hora text,
  folio_dgh text,
  id_paciente text,
  eps text,
  cups text,
  cups_descripcion text,
  paciente text,
  servicio_actual text,
  cama text,
  especialidad text,
  prioridad text,
  ac_evento text,
  autorizador text,
  observacion text
);

alter table public.notas_operatorias enable row level security;
drop policy if exists "acceso_notas_operatorias" on public.notas_operatorias;
create policy "acceso_notas_operatorias" on public.notas_operatorias
  for all to authenticated using (true) with check (true);
create index if not exists idx_notas_operatorias_fecha on public.notas_operatorias(fecha desc);

-- ============================================================
-- OPCIONAL (menos seguro): permitir acceso SIN iniciar sesión.
-- Al descomentarlas, cualquiera que tenga el enlace y la clave pública
-- podría leer y editar datos de pacientes. No se recomienda.
-- ============================================================
-- create policy "anon_turnos" on public.turnos_quirurgicos for all to anon using (true) with check (true);
-- create policy "anon_notas"   on public.notas_operatorias  for all to anon using (true) with check (true);

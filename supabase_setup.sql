create table if not exists public.service_orders (
    user_id uuid not null references auth.users (id) on delete cascade,
    os_num text not null,
    data jsonb not null,
    updated_at timestamptz not null default now(),
    primary key (user_id, os_num)
);

alter table public.service_orders enable row level security;

drop policy if exists "Users can read their own service orders" on public.service_orders;
create policy "Users can read their own service orders"
    on public.service_orders for select to authenticated
    using ((select auth.uid()) = user_id);

drop policy if exists "Users can insert their own service orders" on public.service_orders;
create policy "Users can insert their own service orders"
    on public.service_orders for insert to authenticated
    with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own service orders" on public.service_orders;
create policy "Users can update their own service orders"
    on public.service_orders for update to authenticated
    using ((select auth.uid()) = user_id)
    with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own service orders" on public.service_orders;
create policy "Users can delete their own service orders"
    on public.service_orders for delete to authenticated
    using ((select auth.uid()) = user_id);

grant select, insert, update, delete on public.service_orders to authenticated;

create or replace function public.set_service_orders_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
    new.updated_at = pg_catalog.now();
    return new;
end;
$$;

drop trigger if exists set_service_orders_updated_at on public.service_orders;
create trigger set_service_orders_updated_at
    before update on public.service_orders
    for each row execute function public.set_service_orders_updated_at();

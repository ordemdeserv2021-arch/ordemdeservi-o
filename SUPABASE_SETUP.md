# Sincronização das ordens entre aparelhos

O aplicativo continua salvando uma cópia local e sincroniza o histórico com Supabase quando há conexão. A sincronização é por conta: entre no computador e no celular com o mesmo e-mail e senha para ver as mesmas ordens. Contas diferentes não compartilham ordens.

## Configurar o Supabase

1. Crie um projeto em [supabase.com](https://supabase.com/).
2. Abra o **SQL Editor**, cole o conteúdo de [`supabase_setup.sql`](./supabase_setup.sql) e execute. A tabela habilita Row Level Security; cada conta só pode ler, criar, editar ou excluir as próprias ordens.
3. No painel do Supabase, deixe a autenticação por e-mail habilitada. Com confirmação de e-mail ativa, confirme a mensagem recebida ao criar a conta antes de entrar.
4. Em **Project Settings → API**, copie a **Project URL** e a chave pública **anon** ou **publishable**. Nunca use nem publique a chave `service_role`.
5. Abra o sistema em cada aparelho, informe a URL e a chave pública e escolha **Salvar conexão**. Depois, crie uma conta e use a mesma conta nos outros aparelhos.

No primeiro acesso da primeira conta em um aparelho que já tenha ordens salvas localmente, o aplicativo envia para a nuvem as ordens que ainda não existem nessa conta. Se já existir uma ordem com o mesmo número na nuvem, a versão da nuvem é mantida. A cópia local fica separada por conta neste aparelho. O sistema também oferece exportação JSON como cópia de segurança.

## Hospedagem

O projeto continua sendo uma página estática e pode ser publicado na Vercel. A URL e a chave pública são configuradas no próprio navegador; portanto, não é necessário inserir uma chave secreta nas configurações da Vercel. A biblioteca Supabase é carregada por CDN, então o navegador precisa de acesso à internet.

## Limites da sincronização

- Ordens e fotos anexadas à OS são sincronizadas como dados da ordem.
- Modelos de equipamento, chave do Gemini e pastas locais/Drive permanecem específicos de cada aparelho.
- O app sincroniza ao entrar, salvar, excluir ou importar ordens. Alterações e exclusões feitas sem conexão ficam em uma fila local por conta e são reenviadas na próxima sincronização.
- O banco é separado por usuário autenticado. Para várias contas compartilharem o mesmo conjunto de ordens, é necessário adicionar organizações/equipes e permissões próprias.

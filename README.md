# sdd-kit

Kit pessoal de Spec-Driven Development (SDD), baseado no [github/spec-kit](https://github.com/github/spec-kit), adaptado para uso exclusivo com [Claude Code](https://claude.com/claude-code) e com todo o conteúdo em português.

Este repositório **não é um projeto executável** — é um template para trazer o fluxo SDD para dentro de qualquer projeto novo.

## O que é SDD

Spec-Driven Development inverte a ordem usual: em vez de código guiando a especificação, a especificação (o que o sistema deve fazer e por quê) guia o código. O fluxo completo tem 8 fases, cada uma com seu comando Claude Code (mais etapas opcionais de design e de ambiente local):

| Fase | Comando | O que faz |
|---|---|---|
| 0 | `/constitution` | Define os princípios não-negociáveis do projeto |
| 0.5 | `/architecture` | Detecta (projeto existente) ou define (projeto novo) a arquitetura e convenções de desenvolvimento |
| 0.6 | `/localdev` | (opcional) Analisa o projeto e prepara o ambiente para rodar/testar localmente: guia em `.specify/memory/local-dev.md` + `docker-compose.dev.yml`, `.env.example`, scripts de seed |
| 0.75 | `/design-import` | (opcional) Importa um design do Claude Design e documenta Design System, telas e componentes em `design/` |
| 1 | `/specify` | Transforma uma descrição em linguagem natural numa especificação de feature |
| 2 | `/clarify` | Identifica ambiguidades na spec e resolve via perguntas direcionadas |
| 3 | `/plan` | Gera o plano técnico: pesquisa, modelo de dados, contratos — seguindo `architecture.md` |
| 4 | `/tasks` | Quebra o plano em tarefas executáveis, ordenadas por dependência e fase |
| 5 | `/analyze` | Checagem de consistência entre spec/plan/tasks (somente leitura) |
| 6 | `/implement` | Executa as tarefas na ordem, com TDD |

Cada feature vive em `specs/NNN-nome-da-feature/`, numa branch git própria (`NNN-nome-da-feature`), com seus próprios `spec.md`, `plan.md`, `tasks.md` e artefatos de design.

`/constitution` e `/architecture` rodam uma vez por projeto (não por feature) e alimentam `.specify/memory/`: a constituição define POR QUÊ/O QUÊ é inegociável; `architecture.md` define COMO o código é organizado — stack, estrutura de diretórios, convenções de nomenclatura, e onde cada tipo de código novo deve ir. `/plan` e `/tasks` leem `architecture.md` e seguem essas convenções em vez de reinventar a estrutura a cada feature.

`/localdev` também roda uma vez por projeto (e de novo quando a infra local mudar). Ele varre a stack (`architecture.md`, `docker-compose*`, `.env*`, clientes no código) para inventariar tudo que a aplicação precisa para subir — runtime, bancos, brokers, caches, integrações externas — e, para cada dependência que dá para containerizar (Mongo, Kafka, Redis, Postgres, S3...), **pergunta ao usuário** como quer simulá-la, com sugestões e trade-offs. O que **não** roda fiel na máquina (gateway de pagamento, SSO corporativo, API de terceiro) vai para uma seção "Não roda localmente" explícita, com o workaround de cada um (sandbox do fornecedor, feature flag, stub local opcional). No fim grava o guia em `.specify/memory/local-dev.md` e cria os arquivos de infra (`docker-compose.dev.yml`, `.env.example`, scripts de seed/tópicos) — **sem** subir nada e **sem** tocar no código da aplicação. É diferente do `quickstart.md` que `/plan` gera por-feature: `/localdev` é o ambiente inteiro, uma vez.

`/design-import` também roda uma vez por projeto (e de novo quando o design mudar). Ele recebe o caminho de um export do Claude Design já baixado — imagens PNG/PDF, o `.html` do canvas publicado, ou arquivos `.dc.html` — copia os brutos para `design/assets/` e gera documentação em `design/`: `design-system.md` (tokens), `screens/*.md` (uma por tela), `components.md` (inventário de componentes reutilizáveis), `manifest.md` (índice + rastreio tela → feature) e `tokens.*` no formato de estilo do projeto. É opcional; depois que `design/` existe, o fluxo passa a consumi-lo automaticamente em features com UI: `/specify` identifica as telas que a feature realiza e preenche a coluna "Feature" do `manifest.md`; `/plan` mapeia cada tela a uma rota/página e a componentes de `components.md` e usa `tokens.*` como fonte visual; `/tasks` cita o arquivo de design em cada tarefa de UI; `/implement` lê esses arquivos antes de construir a tela. O design nunca sobrepõe a spec — se divergirem, a spec vence e o comando reporta a divergência.

Além dessas fases, o kit traz dois comandos de apoio para git:

| Comando | O que faz |
|---|---|
| `/commit` | Cria um commit com as mudanças atuais do working tree |
| `/push` | Envia os commits da branch atual para o remoto |

### Regras de comportamento do fluxo

- **`/specify` nunca segue em frente com dúvida.** Sempre que surgir qualquer ambiguidade real sobre o que a feature deve fazer, o comando para e pergunta na conversa — não importa quantas perguntas sejam necessárias. Não usa `[NEEDS CLARIFICATION]` como forma de adiar a decisão e continuar escrevendo.
- **`/specify` sempre pergunta a Definição de Pronto (DoD).** Em toda spec — feature, correção de bug, análise, validação, o que for — uma das perguntas obrigatórias é "quais pontos são primordiais para isto estar DONE?". A resposta vira uma checklist verificável em `spec.md`, que `/analyze` confere ter cobertura em `tasks.md` e que `/implement` confirma item a item ao final.
- **`/architecture` segue a mesma regra.** Se o código existente for ambíguo/inconsistente, ou se for um projeto novo, pergunta ao usuário em vez de assumir uma convenção — e confirma o resumo detectado antes de gravar.
- **`/design-import` também segue a regra de dúvida bloqueia.** Se o export estiver ambíguo, incompleto ou não reconhecível, pergunta em vez de inventar valores de token/tela/componente. Se `architecture.md` não deixar claro o formato de tokens em código, pergunta qual gerar.
- **`/localdev` nunca escolhe sozinho como simular uma dependência.** Para cada banco/broker/cache/storage, para e pergunta (uma de cada vez, com opções e trade-offs) como o usuário quer rodá-lo localmente. Nunca escreve um `.env` real nem valores de segredo, nunca sobrescreve `docker-compose*`/`Makefile` existentes (propõe o diff ou um arquivo `*.dev` separado), nunca sobe os serviços, e deixa explícito no guia tudo que **não** roda localmente.
- **`/tasks` organiza o trabalho em fases coerentes** com a feature real (ex.: "Fase 1: Autenticação básica", "Fase 2: Recuperação de senha"), não só num esqueleto genérico fixo repetido sempre igual, e usa `architecture.md` para decidir os caminhos de arquivo.
- **`/push` nunca força push** e sempre confirma o que vai ser enviado antes de rodar `git push`.

## Estrutura do kit

```
.specify/
├── memory/
│   ├── constitution.md         # template da constituição do projeto (princípios)
│   ├── architecture.md         # NÃO existe até rodar /architecture — arquitetura/convenções do projeto
│   └── local-dev.md            # NÃO existe até rodar /localdev — como subir o ambiente local
├── templates/                  # templates de spec, plan, tasks, architecture, design-*, local-dev e do CLAUDE.md
└── scripts/bash/                # scripts que os slash commands chamam (inclui import-design.sh e setup-localdev.sh)
.claude/commands/                # os 12 slash commands (/constitution, /architecture, /localdev, /design-import, /specify, ..., /commit, /push)
specs/                           # onde as specs de cada feature são criadas (vazio aqui)
design/                          # NÃO existe até rodar /design-import — Design System, telas e componentes do projeto
```

## Como usar em um projeto novo

**Opção A — GitHub template**: clique em "Use this template" neste repositório no GitHub para criar um novo repositório já com essa estrutura.

**Opção B — copiar para um projeto existente**:

```bash
# dentro do projeto-alvo, com este kit clonado ao lado
cp -r /caminho/para/sdd-kit/.specify ./
cp -r /caminho/para/sdd-kit/.claude ./
mkdir -p specs
chmod +x .specify/scripts/bash/*.sh
```

Depois, dentro de uma sessão do Claude Code no projeto:

```
/constitution         # defina os princípios do projeto (uma vez, no início)
/architecture         # detecta ou define a arquitetura/convenções (uma vez, no início)
/localdev             # opcional: prepara o ambiente para rodar/testar localmente
/design-import ~/Downloads/<export do Claude Design>   # opcional: importa e documenta o design
/specify "descrição da primeira feature em linguagem natural"
/clarify              # se a spec tiver ambiguidades
/plan
/tasks
/analyze              # opcional, antes de implementar
/implement
/commit               # empacota o que foi feito
/push                 # envia para o remoto
```

## Pré-requisitos

- `git`
- `bash` (os scripts em `.specify/scripts/bash/` usam apenas bash/coreutils padrão)
- Claude Code

## Por que sem CLI/bootstrap script

O spec-kit original tem uma CLI Python (`specify init`) para automatizar a cópia da estrutura. Este kit, por ser de uso pessoal e via GitHub template, dispensa esse passo: "Use this template" (ou um `cp -r` manual) já resolve, sem mais uma ferramenta pra manter atualizada.

## Licença

MIT — veja [LICENSE](LICENSE).

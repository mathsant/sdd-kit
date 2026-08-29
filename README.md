# sdd-kit

Kit pessoal de Spec-Driven Development (SDD), baseado no [github/spec-kit](https://github.com/github/spec-kit), adaptado para uso exclusivo com [Claude Code](https://claude.com/claude-code) e com todo o conteúdo em português.

Este repositório **não é um projeto executável** — é um template para trazer o fluxo SDD para dentro de qualquer projeto novo.

## O que é SDD

Spec-Driven Development inverte a ordem usual: em vez de código guiando a especificação, a especificação (o que o sistema deve fazer e por quê) guia o código. O fluxo completo tem 8 fases, cada uma com seu comando Claude Code:

| Fase | Comando | O que faz |
|---|---|---|
| 0 | `/constitution` | Define os princípios não-negociáveis do projeto |
| 0.5 | `/architecture` | Detecta (projeto existente) ou define (projeto novo) a arquitetura e convenções de desenvolvimento |
| 1 | `/specify` | Transforma uma descrição em linguagem natural numa especificação de feature |
| 2 | `/clarify` | Identifica ambiguidades na spec e resolve via perguntas direcionadas |
| 3 | `/plan` | Gera o plano técnico: pesquisa, modelo de dados, contratos — seguindo `architecture.md` |
| 4 | `/tasks` | Quebra o plano em tarefas executáveis, ordenadas por dependência e fase |
| 5 | `/analyze` | Checagem de consistência entre spec/plan/tasks (somente leitura) |
| 6 | `/implement` | Executa as tarefas na ordem, com TDD |

Cada feature vive em `specs/NNN-nome-da-feature/`, numa branch git própria (`NNN-nome-da-feature`), com seus próprios `spec.md`, `plan.md`, `tasks.md` e artefatos de design.

`/constitution` e `/architecture` rodam uma vez por projeto (não por feature) e alimentam `.specify/memory/`: a constituição define POR QUÊ/O QUÊ é inegociável; `architecture.md` define COMO o código é organizado — stack, estrutura de diretórios, convenções de nomenclatura, e onde cada tipo de código novo deve ir. `/plan` e `/tasks` leem `architecture.md` e seguem essas convenções em vez de reinventar a estrutura a cada feature.

Além dessas fases, o kit traz dois comandos de apoio para git:

| Comando | O que faz |
|---|---|
| `/commit` | Cria um commit com as mudanças atuais do working tree |
| `/push` | Envia os commits da branch atual para o remoto |

### Regras de comportamento do fluxo

- **`/specify` nunca segue em frente com dúvida.** Sempre que surgir qualquer ambiguidade real sobre o que a feature deve fazer, o comando para e pergunta na conversa — não importa quantas perguntas sejam necessárias. Não usa `[NEEDS CLARIFICATION]` como forma de adiar a decisão e continuar escrevendo.
- **`/specify` sempre pergunta a Definição de Pronto (DoD).** Em toda spec — feature, correção de bug, análise, validação, o que for — uma das perguntas obrigatórias é "quais pontos são primordiais para isto estar DONE?". A resposta vira uma checklist verificável em `spec.md`, que `/analyze` confere ter cobertura em `tasks.md` e que `/implement` confirma item a item ao final.
- **`/architecture` segue a mesma regra.** Se o código existente for ambíguo/inconsistente, ou se for um projeto novo, pergunta ao usuário em vez de assumir uma convenção — e confirma o resumo detectado antes de gravar.
- **`/tasks` organiza o trabalho em fases coerentes** com a feature real (ex.: "Fase 1: Autenticação básica", "Fase 2: Recuperação de senha"), não só num esqueleto genérico fixo repetido sempre igual, e usa `architecture.md` para decidir os caminhos de arquivo.
- **`/push` nunca força push** e sempre confirma o que vai ser enviado antes de rodar `git push`.

## Estrutura do kit

```
.specify/
├── memory/
│   ├── constitution.md         # template da constituição do projeto (princípios)
│   └── architecture.md         # NÃO existe até rodar /architecture — arquitetura/convenções do projeto
├── templates/                  # templates de spec, plan, tasks, architecture e do CLAUDE.md
└── scripts/bash/                # scripts que os slash commands chamam
.claude/commands/                # os 10 slash commands (/constitution, /architecture, /specify, ..., /commit, /push)
specs/                           # onde as specs de cada feature são criadas (vazio aqui)
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

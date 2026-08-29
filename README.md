# sdd-kit

Kit pessoal de Spec-Driven Development (SDD), baseado no [github/spec-kit](https://github.com/github/spec-kit), adaptado para uso exclusivo com [Claude Code](https://claude.com/claude-code) e com todo o conteúdo em português.

Este repositório **não é um projeto executável** — é um template para trazer o fluxo SDD para dentro de qualquer projeto novo.

## O que é SDD

Spec-Driven Development inverte a ordem usual: em vez de código guiando a especificação, a especificação (o que o sistema deve fazer e por quê) guia o código. O fluxo completo tem 7 fases, cada uma com seu comando Claude Code:

| Fase | Comando | O que faz |
|---|---|---|
| 0 | `/constitution` | Define os princípios não-negociáveis do projeto |
| 1 | `/specify` | Transforma uma descrição em linguagem natural numa especificação de feature |
| 2 | `/clarify` | Identifica ambiguidades na spec e resolve via perguntas direcionadas |
| 3 | `/plan` | Gera o plano técnico: pesquisa, modelo de dados, contratos |
| 4 | `/tasks` | Quebra o plano em tarefas executáveis, ordenadas por dependência |
| 5 | `/analyze` | Checagem de consistência entre spec/plan/tasks (somente leitura) |
| 6 | `/implement` | Executa as tarefas na ordem, com TDD |

Cada feature vive em `specs/NNN-nome-da-feature/`, numa branch git própria (`NNN-nome-da-feature`), com seus próprios `spec.md`, `plan.md`, `tasks.md` e artefatos de design.

## Estrutura do kit

```
.specify/
├── memory/constitution.md      # template da constituição do projeto
├── templates/                  # templates de spec, plan, tasks e do CLAUDE.md
└── scripts/bash/                # scripts que os slash commands chamam
.claude/commands/                # os 7 slash commands (/constitution, /specify, ...)
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
/constitution        # defina os princípios do projeto (uma vez, no início)
/specify "descrição da primeira feature em linguagem natural"
/clarify              # se a spec tiver ambiguidades
/plan
/tasks
/analyze              # opcional, antes de implementar
/implement
```

## Pré-requisitos

- `git`
- `bash` (os scripts em `.specify/scripts/bash/` usam apenas bash/coreutils padrão)
- Claude Code

## Por que sem CLI/bootstrap script

O spec-kit original tem uma CLI Python (`specify init`) para automatizar a cópia da estrutura. Este kit, por ser de uso pessoal e via GitHub template, dispensa esse passo: "Use this template" (ou um `cp -r` manual) já resolve, sem mais uma ferramenta pra manter atualizada.

## Licença

MIT — veja [LICENSE](LICENSE).

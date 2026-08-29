# Plano de Implementação: [NOME DA FEATURE]

**Branch**: `[###-nome-da-feature]` | **Data**: [DATA] | **Spec**: [link para spec.md]
**Entrada**: especificação de feature em `specs/[###-nome-da-feature]/spec.md`

## Resumo

[Extraído da spec: a necessidade principal + a abordagem técnica escolhida na pesquisa (Fase 0).]

## Contexto Técnico

<!-- Esta seção é lida pelo update-agent-context.sh para atualizar o CLAUDE.md do projeto. -->

**Linguagem/versão**: [ex.: TypeScript 5.x / NEEDS CLARIFICATION]
**Dependências principais**: [ex.: Vue 3, Vite / NEEDS CLARIFICATION]
**Armazenamento**: [se aplicável, ex.: Postgres / N/A]
**Testes**: [ex.: Vitest / NEEDS CLARIFICATION]
**Plataforma-alvo**: [ex.: navegador, servidor Linux, iOS / NEEDS CLARIFICATION]
**Tipo de projeto**: [single / web (frontend+backend) / mobile]
**Metas de performance**: [se houver requisito específico, senão N/A]
**Restrições**: [se houver, senão N/A]
**Escala/escopo**: [ex.: número de usuários, telas, entidades]

## Verificação da Constituição

*Gate obrigatório: rodado antes da Fase 0 e novamente após a Fase 1. Consulte `.specify/memory/constitution.md`.*

[Liste aqui cada princípio da constituição do projeto e se este plano está em conformidade. Se algum princípio for violado, documente a justificativa na seção "Rastreio de Complexidade" abaixo — não prossiga silenciosamente.]

- [ ] Princípio [N]: conforme / violação justificada abaixo

## Estrutura do Projeto

### Documentos desta feature (`specs/[###-nome-da-feature]/`)

```
specs/[###-nome-da-feature]/
├── spec.md
├── plan.md              # este arquivo
├── research.md          # saída da Fase 0
├── data-model.md         # saída da Fase 1
├── quickstart.md         # saída da Fase 1
├── contracts/            # saída da Fase 1
└── tasks.md               # saída da Fase 2 (gerado pelo /tasks, não pelo /plan)
```

### Código-fonte (raiz do repositório)

[Descreva a estrutura de diretórios real que será usada — escolha a opção que se aplica e apague as demais, ou descreva a estrutura específica do projeto se nenhuma se aplicar.]

## Fase 0: Pesquisa

1. Extraia todo `[NEEDS CLARIFICATION]` do Contexto Técnico acima.
2. Para cada incógnita, pesquise/decida a abordagem e registre em `research.md`:
   - Decisão: [o que foi escolhido]
   - Justificativa: [por quê]
   - Alternativas consideradas: [o que mais foi avaliado]

**Saída**: `research.md` com todas as incógnitas resolvidas.

## Fase 1: Design & Contratos

*Pré-requisito: `research.md` completo.*

1. Extraia entidades da spec → `data-model.md` (nome, campos, relações, regras de validação).
2. Gere contratos de API/interface a partir dos requisitos funcionais → `contracts/`.
3. Extraia cenários de teste dos cenários de usuário → casos de teste de integração.
4. Gere `quickstart.md` com os passos para rodar/validar a feature manualmente.
5. Rode `.specify/scripts/bash/update-agent-context.sh` para atualizar o CLAUDE.md do projeto com a stack decidida aqui.

**Saída**: `data-model.md`, `contracts/`, `quickstart.md`, `CLAUDE.md` atualizado.

## Fase 2: Abordagem de Planejamento de Tarefas

*Esta seção descreve o que o comando `/tasks` fará — NÃO execute isso agora, e NÃO gere `tasks.md` aqui.*

**Estratégia de geração de tarefas**:
- Carregar `.specify/templates/tasks-template.md` como base.
- Gerar tarefas a partir dos contratos (uma por endpoint/interface), do data-model (uma por entidade) e dos cenários de user story (uma por cenário de integração).
- Tarefas de TDD: teste antes de implementação, sempre que aplicável.

**Estratégia de ordenação**:
- Ordem TDD: testes antes do código que os satisfaz.
- Ordem de dependência: modelos antes de serviços antes de endpoints/UI.
- Marcar `[P]` para tarefas em arquivos independentes que podem rodar em paralelo.

## Rastreio de Complexidade

*Preencher SOMENTE se a Verificação da Constituição tiver violações que precisam de justificativa.*

| Violação | Por que é necessária | Alternativa mais simples rejeitada e por quê |
|---|---|---|
| [ex.: 4º projeto no monorepo] | [necessidade concreta] | [por que 3 projetos não bastam] |

## Progresso

- [ ] Fase 0: pesquisa completa (`research.md`)
- [ ] Fase 1: design completo (`data-model.md`, `contracts/`, `quickstart.md`, `CLAUDE.md`)
- [ ] Verificação da Constituição: inicial aprovada
- [ ] Verificação da Constituição: pós-design aprovada
- [ ] Nenhum `[NEEDS CLARIFICATION]` restante

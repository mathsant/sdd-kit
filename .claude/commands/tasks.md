---
description: Gera a lista de tarefas executáveis e ordenadas por dependência a partir do plan.md da feature atual.
---

Argumentos opcionais do usuário (ex.: priorizar uma área):
$ARGUMENTS

## Sua tarefa

1. Rode:
   ```
   .specify/scripts/bash/check-prerequisites.sh --json --include-tasks
   ```
   Capture `FEATURE_DIR`, `SPEC_FILE`, `PLAN_FILE`. Se `plan.md` não existir, avise o usuário para rodar `/plan` primeiro.

2. Leia `PLAN_FILE`, e se existirem, `data-model.md`, `contracts/*` e `quickstart.md` no mesmo diretório.

3. Gere `FEATURE_DIR/tasks.md` a partir de `.specify/templates/tasks-template.md`, substituindo os placeholders por tarefas reais:
   - Uma tarefa de teste de contrato por endpoint/interface em `contracts/`.
   - Uma tarefa de modelo por entidade em `data-model.md`.
   - Uma tarefa de teste de integração por cenário de aceitação da spec.
   - Tarefas de implementação core que fazem os testes acima passarem.
   - Tarefas de integração (storage, middleware, observabilidade) conforme o plano.
   - Tarefas de polimento (testes unitários, docs, rodar o `quickstart.md`).

4. Ordene por dependência real, não pela ordem do template:
   - Testes antes da implementação que eles cobrem (TDD).
   - Modelos antes de serviços antes de endpoints/UI.
   - Marque `[P]` **só** quando as tarefas tocam arquivos diferentes e não têm dependência entre si — nunca marque `[P]` em duas tarefas que escrevem no mesmo arquivo.

5. Cada tarefa deve ter: número sequencial (T001, T002, ...), descrição de uma linha, e o caminho de arquivo exato a criar/editar. Tarefas vagas ("melhorar performance") não são aceitáveis — reescreva com um alvo concreto.

6. Preencha a seção "Dependências" e o "Exemplo de execução em paralelo" com as tarefas reais geradas (não deixe o texto de exemplo do template).

7. Reporte ao usuário: quantas tarefas foram geradas, quantas são paralelizáveis, e se algo no `plan.md`/`data-model.md` estava incompleto demais para gerar uma tarefa concreta (nesse caso, marque a tarefa como bloqueada e explique o que falta).

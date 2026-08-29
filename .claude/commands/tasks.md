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

3. **Defina as fases antes de listar tarefas.** `.specify/templates/tasks-template.md` traz um esqueleto genérico (Setup / Testes / Core / Integração / Polimento) só como ponto de partida — não copie esses nomes/quantidade cegamente. Projete as fases que fazem sentido **para esta feature específica**:
   - Cada fase deve representar um marco coerente e entregável (ex.: "Fase 1: Autenticação básica", "Fase 2: Recuperação de senha", "Fase 3: Auditoria de login" — em vez de só "Core" genérico), agrupando as tarefas que pertencem à mesma capacidade ou subsistema.
   - Dentro de cada fase, ainda vale a ordem TDD (teste antes da implementação que ele cobre).
   - Se a feature for pequena e o esqueleto genérico já for coerente, tudo bem mantê-lo — o objetivo é fases que reflitam a estrutura real do trabalho, não sempre as mesmas 5 caixas.
   - Fases posteriores podem depender de fases anteriores estarem completas; deixe isso explícito na seção "Dependências".

4. Gere `FEATURE_DIR/tasks.md` com as fases definidas no passo 3, populando cada uma com tarefas reais derivadas de:
   - Uma tarefa de teste de contrato por endpoint/interface em `contracts/`.
   - Uma tarefa de modelo por entidade em `data-model.md`.
   - Uma tarefa de teste de integração por cenário de aceitação da spec.
   - Tarefas de implementação core que fazem os testes acima passarem.
   - Tarefas de integração (storage, middleware, observabilidade) conforme o plano.
   - Tarefas de polimento (testes unitários, docs, rodar o `quickstart.md`).

5. Ordene por dependência real, não pela ordem do template:
   - Testes antes da implementação que eles cobrem (TDD).
   - Modelos antes de serviços antes de endpoints/UI.
   - Marque `[P]` **só** quando as tarefas tocam arquivos diferentes e não têm dependência entre si — nunca marque `[P]` em duas tarefas que escrevem no mesmo arquivo.

6. Cada tarefa deve ter: número sequencial (T001, T002, ...), descrição de uma linha, e o caminho de arquivo exato a criar/editar. Tarefas vagas ("melhorar performance") não são aceitáveis — reescreva com um alvo concreto.

7. Preencha a seção "Dependências" e o "Exemplo de execução em paralelo" com as tarefas reais geradas (não deixe o texto de exemplo do template).

8. Reporte ao usuário: as fases definidas e o porquê do agrupamento, quantas tarefas foram geradas por fase, quantas são paralelizáveis, e se algo no `plan.md`/`data-model.md` estava incompleto demais para gerar uma tarefa concreta (nesse caso, marque a tarefa como bloqueada e explique o que falta).

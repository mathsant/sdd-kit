---
description: Gera o plano técnico de implementação (pesquisa, design, contratos) a partir do spec.md da feature atual.
---

Contexto/restrições técnicas adicionais fornecidas pelo usuário (opcional):
$ARGUMENTS

## Sua tarefa

1. Rode:
   ```
   .specify/scripts/bash/setup-plan.sh --json
   ```
   Capture do JSON: `PLAN_FILE`, `SPEC_FILE`, `RESEARCH_FILE`, `DATA_MODEL_FILE`, `QUICKSTART_FILE`, `CONTRACTS_DIR`, `FEATURE_DIR`.

2. Leia `SPEC_FILE` e `.specify/memory/constitution.md`.

3. Preencha o `PLAN_FILE` (copiado de `.specify/templates/plan-template.md`) seguindo suas próprias seções, na ordem:

   **Contexto Técnico**: preencha cada campo com a stack real do projeto (verifique `package.json`/`go.mod`/etc. se já existir código, ou use os argumentos do usuário). Marque `[NEEDS CLARIFICATION]` só onde realmente não dá pra decidir sem o usuário.

   **Verificação da Constituição**: para cada princípio em `.specify/memory/constitution.md`, avalie se este plano está em conformidade. Se a constituição ainda não foi inicializada (placeholders), pule este gate e avise o usuário para rodar `/constitution`.

   **Fase 0 — Pesquisa**: resolva cada `[NEEDS CLARIFICATION]` restante do Contexto Técnico. Escreva as decisões em `RESEARCH_FILE` (decisão / justificativa / alternativas consideradas).

   **Fase 1 — Design & Contratos**:
   - Escreva `DATA_MODEL_FILE` a partir das Entidades-Chave da spec.
   - Gere contratos de API/interface em `CONTRACTS_DIR/` a partir dos Requisitos Funcionais.
   - Escreva `QUICKSTART_FILE` com os passos manuais para validar a feature.
   - Rode `.specify/scripts/bash/update-agent-context.sh` para propagar a stack decidida ao `CLAUDE.md` do projeto.

   **Fase 2 — descrição da abordagem de tarefas**: só descreva a estratégia que o `/tasks` vai seguir. **Não gere `tasks.md` neste comando.**

   Repita a Verificação da Constituição após a Fase 1 — se alguma decisão de design violou um princípio, documente a justificativa em "Rastreio de Complexidade" ou reconsidere o design.

4. Marque a seção "Progresso" no fim do `plan.md` conforme cada fase é concluída.

5. Reporte ao usuário: o que foi decidido na pesquisa, quais artefatos foram gerados, e se algum gate da constituição ficou pendente de justificativa.

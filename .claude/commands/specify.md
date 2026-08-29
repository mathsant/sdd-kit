---
description: Cria a especificação de uma nova feature a partir de uma descrição em linguagem natural.
---

Descrição da feature fornecida pelo usuário:
$ARGUMENTS

## Sua tarefa

1. Rode:
   ```
   .specify/scripts/bash/create-new-feature.sh --json "$ARGUMENTS"
   ```
   Isso cria a branch `NNN-nome-curto`, o diretório `specs/NNN-nome-curto/` e um `spec.md` a partir do template. Capture do JSON de saída: `BRANCH_NAME`, `SPEC_FILE`, `FEATURE_DIR`.

2. Leia o `SPEC_FILE` recém-criado (é uma cópia de `.specify/templates/spec-template.md`).

3. Preencha o `spec.md` a partir da descrição do usuário, seguindo o "Fluxo de execução" descrito no próprio template:
   - Extraia atores, ações, dados, restrições.
   - Escreva a história principal e os cenários de aceitação no formato Dado/Quando/Então.
   - Escreva Requisitos Funcionais testáveis (RF-001, RF-002, ...).
   - Identifique Entidades-Chave, se aplicável.
   - **Toda ambiguidade real vira um marcador `[NEEDS CLARIFICATION: pergunta específica]`** — não assuma decisões de produto ou técnicas que o usuário não deu. Não é o mesmo que preencher tudo com genéricos; é melhor marcar 3 ambiguidades reais do que inventar 3 respostas.
   - Mantenha o foco em O QUÊ/POR QUÊ. Nada de stack, frameworks, nomes de tabela — isso é papel do `/plan`.

4. Rode o checklist de revisão no fim do template. Se algo não bater (detalhe de implementação vazou, requisito não-testável), corrija antes de terminar.

5. Reporte ao usuário: branch criada, caminho do spec.md, e a lista de `[NEEDS CLARIFICATION]` pendentes (se houver). Sugira rodar `/clarify` em seguida se houver pendências, ou `/plan` diretamente se a spec já estiver completa.

Não crie `plan.md` nem toque em código de implementação neste comando.

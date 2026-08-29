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
   - Mantenha o foco em O QUÊ/POR QUÊ. Nada de stack, frameworks, nomes de tabela — isso é papel do `/plan`.

4. **Regra crítica — dúvida bloqueia, não marca e segue**: este é o momento mais importante do fluxo SDD. Sempre que você tiver qualquer dúvida real sobre o que a feature deve fazer (ambiguidade de comportamento, escopo indefinido, requisito que admite mais de uma interpretação, regra de negócio não dada), **pare e pergunte ao usuário diretamente na conversa**, uma pergunta por vez, e espere a resposta antes de continuar escrevendo a spec.
   - Não existe limite de perguntas — se surgirem 10 dúvidas reais, faça as 10. Preferir poucas perguntas nunca é motivo para assumir uma resposta.
   - Não use `[NEEDS CLARIFICATION: ...]` como forma de "seguir em frente apesar da dúvida" — use a pergunta direta na conversa como primeira linha de ação. O marcador só deve aparecer no `spec.md` se, excepcionalmente, o usuário pedir explicitamente para deixar algo em aberto para decidir depois.
   - Depois de cada resposta, incorpore-a imediatamente no requisito/cenário afetado e continue preenchendo a spec.
   - Só considere a spec pronta quando não houver mais nenhuma dúvida real sua sobre o comportamento esperado.

5. Rode o checklist de revisão no fim do template. Se algo não bater (detalhe de implementação vazou, requisito não-testável), corrija antes de terminar.

6. Reporte ao usuário: branch criada, caminho do spec.md, e um resumo das decisões tomadas nas perguntas feitas. A spec só deve chegar a este ponto sem `[NEEDS CLARIFICATION]` pendente — se algum ficou (por pedido explícito do usuário), avise que `/clarify` pode ser rodado depois para revisitá-lo. Caso contrário, já pode seguir direto para `/plan`.

Não crie `plan.md` nem toque em código de implementação neste comando.

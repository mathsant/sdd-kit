# Constituição de [NOME DO PROJETO]

<!--
SYNC IMPACT REPORT (preenchido pelo /constitution a cada alteração)
Versão: [ANTIGA] → [NOVA]
Princípios: [adicionados/removidos/renomeados]
Templates que podem precisar de revisão: spec-template.md, plan-template.md, tasks-template.md
-->

## Princípios Centrais

### Idioma do código: inglês (regra fixa do kit — não editável)

Todo artefato técnico do projeto é escrito em **inglês**, sem exceção: nomes de arquivos e pastas, identificadores de código (variáveis, funções, classes, métodos, constantes, tipos, módulos, pacotes), nomes de branch, nomes de tabela/coluna/índice, chaves de configuração e de tradução, nomes de recursos de infra, mensagens de commit e comentários no código.

Português (ou outro idioma) é permitido **apenas** em conteúdo voltado ao usuário final (textos de interface, mensagens exibidas, documentação de produto) e na documentação do fluxo SDD em si (`spec.md`, `plan.md`, `tasks.md` e afins continuam em português).

**Justificativa**: mantém a base de código consistente, legível por qualquer ferramenta e colaborador, e evita mistura de idiomas em identificadores — que é fonte recorrente de bugs de digitação e de convenção. Esta regra vem do kit e vale para todo projeto; `/constitution` não deve removê-la nem transformá-la em placeholder. Se um projeto específico precisar de exceção, ela deve ser documentada explicitamente na seção "Restrições Adicionais" com justificativa.

### [PRINCÍPIO_1_NOME]

[Descrição do princípio em termos concretos e verificáveis — não uma platitude. Ex.: "Toda feature exposta ao usuário deve ter um teste de integração cobrindo o caminho feliz antes do merge."]

**Justificativa**: [por que este princípio existe, que problema ele previne]

### [PRINCÍPIO_2_NOME]

[Descrição]

**Justificativa**: [...]

### [PRINCÍPIO_3_NOME]

[Descrição]

**Justificativa**: [...]

## Restrições Adicionais

[Restrições de stack, compliance, performance ou segurança que valem para todas as features deste projeto. Ex.: "Nenhuma dependência nova sem justificativa em research.md." Apague se não houver.]

## Fluxo de Desenvolvimento

[Requisitos de revisão de código, portões de teste, padrões de PR que este projeto exige além do fluxo SDD padrão. Apague se não houver nada além do fluxo padrão.]

## Governança

Esta constituição tem precedência sobre qualquer outra prática do projeto. Alterações exigem:

1. Documentação da mudança e justificativa.
2. Atualização do Sync Impact Report no topo deste arquivo.
3. Verificação de que `plan-template.md` ainda reflete os princípios vigentes (seção "Verificação da Constituição").

Toda revisão de PR/plano deve confirmar conformidade com estes princípios. Complexidade não justificada deve ser rejeitada ou documentada em "Rastreio de Complexidade" no `plan.md`.

**Versão**: 0.0.0 (ainda não inicializada — rode `/constitution` para preencher) | **Ratificada em**: [DATA] | **Última alteração**: [DATA]

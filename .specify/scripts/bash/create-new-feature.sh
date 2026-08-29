#!/usr/bin/env bash
# Cria uma nova feature: calcula o próximo número, cria a branch NNN-nome-curto,
# cria specs/NNN-nome-curto/spec.md a partir do template e imprime o resultado em JSON.
#
# Uso: create-new-feature.sh [--json] "descrição da feature em linguagem natural"

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

JSON_MODE=false
ARGS=()
for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        *) ARGS+=("$arg") ;;
    esac
done

if [[ ${#ARGS[@]} -eq 0 ]]; then
    echo "ERRO: descreva a feature. Uso: create-new-feature.sh [--json] \"descrição\"" >&2
    exit 1
fi

DESCRIPTION="${ARGS[*]}"
REPO_ROOT=$(get_repo_root)
SPECS_DIR="$REPO_ROOT/specs"
mkdir -p "$SPECS_DIR"

# Próximo número: maior NNN existente em specs/ + 1.
LAST_NUM=0
if [[ -d "$SPECS_DIR" ]]; then
    for dir in "$SPECS_DIR"/*/; do
        [[ -d "$dir" ]] || continue
        base=$(basename "$dir")
        if [[ "$base" =~ ^([0-9]{3})- ]]; then
            num=$((10#${BASH_REMATCH[1]}))
            if (( num > LAST_NUM )); then
                LAST_NUM=$num
            fi
        fi
    done
fi
NEXT_NUM=$(printf "%03d" $((LAST_NUM + 1)))

# Slug curto (até 4 palavras, minúsculo, separado por hífen) a partir da descrição.
SLUG=$(echo "$DESCRIPTION" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9 ]//g' \
    | tr -s ' ' '\n' \
    | head -n 4 \
    | tr '\n' '-' \
    | sed -E 's/-+$//')

if [[ -z "$SLUG" ]]; then
    SLUG="feature"
fi

BRANCH_NAME="${NEXT_NUM}-${SLUG}"
FEATURE_DIR="$SPECS_DIR/$BRANCH_NAME"
SPEC_FILE="$FEATURE_DIR/spec.md"
TEMPLATE_FILE="$REPO_ROOT/.specify/templates/spec-template.md"

mkdir -p "$FEATURE_DIR"

if [[ -f "$TEMPLATE_FILE" ]]; then
    cp "$TEMPLATE_FILE" "$SPEC_FILE"
else
    echo "# Especificação: [FEATURE]" > "$SPEC_FILE"
fi

# Cria a branch a partir do estado atual (só se estivermos num repo git com commits).
if git rev-parse --verify HEAD >/dev/null 2>&1; then
    git checkout -b "$BRANCH_NAME" >/dev/null 2>&1 || {
        echo "AVISO: não foi possível criar a branch '$BRANCH_NAME' (talvez já exista)." >&2
    }
else
    echo "AVISO: repositório sem commits ainda; branch não foi criada automaticamente." >&2
fi

if $JSON_MODE; then
    printf '{"BRANCH_NAME":"%s","SPEC_FILE":"%s","FEATURE_DIR":"%s","FEATURE_NUM":"%s"}\n' \
        "$BRANCH_NAME" "$SPEC_FILE" "$FEATURE_DIR" "$NEXT_NUM"
else
    echo "Branch:    $BRANCH_NAME"
    echo "Spec:      $SPEC_FILE"
    echo "Diretório: $FEATURE_DIR"
fi

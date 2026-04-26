#!/usr/bin/env bash
# update-catalog.sh
# Scans all skills and regenerates CATALOG.md
# Categories are read from metadata.category in each SKILL.md frontmatter.
# Usage: ./skills/skill-creator/scripts/update-catalog.sh
# Compatible with bash 3.2+ (macOS default)

set -euo pipefail

# Locate repo root (assuming this script is in skills/skill-creator/scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$(dirname "$(dirname "$SCRIPT_DIR")")")"
CATALOG="$REPO_ROOT/CATALOG.md"

if [ ! -d "$REPO_ROOT/skills" ]; then
    echo "Error: Could not find skills directory at $REPO_ROOT/skills"
    exit 1
fi

echo "Regenerating CATALOG.md in $REPO_ROOT..."

# Function to get description from SKILL.md frontmatter
get_desc() {
    local file="$1"
    local desc=""

    # 1. Try YAML frontmatter (description:)
    desc=$(grep "^description:" "$file" | head -n1 | sed 's/^description: *//')

    # Handle block scalar (> or |) — read all indented continuation lines
    if echo "$desc" | grep -qE "^[>|]$"; then
        desc=""
        local in_desc=0
        while IFS= read -r line; do
            if [ $in_desc -eq 0 ]; then
                if echo "$line" | grep -qE "^description:"; then
                    in_desc=1
                fi
                continue
            fi
            # Continuation lines are indented with spaces
            if echo "$line" | grep -q "^  "; then
                local trimmed
                trimmed=$(echo "$line" | sed 's/^  *//')
                if [ -z "$desc" ]; then
                    desc="$trimmed"
                else
                    desc="$desc $trimmed"
                fi
            else
                break
            fi
        done < "$file"
    fi

    # 2. Fallback: Try extracting from Blockquote (>) near top
    if [ -z "$desc" ]; then
        desc=$(head -n 20 "$file" | grep "^> " | head -n1 | sed 's/^> *//' | sed 's/\*\*//g')
    fi

    # 3. Fallback: No description
    if [ -z "$desc" ]; then
        desc="-"
    fi

    # Clean up
    printf '%s' "$desc" | tr -d '\n'
}

# Extract category from metadata.category in frontmatter
get_category() {
    local file="$1"
    local cat=""
    cat=$(grep "category:" "$file" | head -n1 | sed 's/.*category: *//' | tr -d '[:space:]')
    if [ -z "$cat" ]; then
        cat="uncategorized"
    fi
    printf '%s' "$cat"
}

# Category metadata
cat_header() {
    case "$1" in
        platform)     printf '%s\n' "## 🧩 Platform" ;;
        engineering)  printf '%s\n' "## 🏗️ Engineering" ;;
        design)       printf '%s\n' "## 🎨 Design" ;;
        ops)          printf '%s\n' "## 🛠️ Ops" ;;
        research)     printf '%s\n' "## 🔬 Research" ;;
        productivity) printf '%s\n' "## 📋 Productivity" ;;
        *)            printf '%s\n' "## $1" ;;
    esac
}

cat_desc() {
    case "$1" in
        platform)     echo "_Agent-internal mechanics, memory, orchestration, and skill tooling._" ;;
        engineering)  echo "_Software development, git workflows, code quality, and reviews._" ;;
        design)       echo "_UI/UX, design systems, visuals, and diagrams._" ;;
        ops)          echo "_Infrastructure, deployment, fleet management, and project coordination._" ;;
        research)     echo "_Web browsing, scraping, and information retrieval._" ;;
        productivity) echo "_Content creation, media, communication, and domain tools._" ;;
    esac
}

# Category order
CAT_ORDER="platform engineering design ops research productivity"

# --- COLLECT SKILLS ---

# Temp files per category (bash 3 compatible — no associative arrays)
for cat_name in $CAT_ORDER; do
    : > "/tmp/catalog_${cat_name}.txt"
done
: > "/tmp/catalog_uncategorized.txt"

for skill_dir in "$REPO_ROOT"/skills/*/; do
    name=$(basename "$skill_dir")
    skill_file="$skill_dir/SKILL.md"

    [ ! -f "$skill_file" ] && continue

    cat_name=$(get_category "$skill_file")
    desc=$(get_desc "$skill_file")
    # Escape pipes in description
    desc=$(echo "$desc" | sed 's/|/\\|/g')

    # Validate category — fall back to uncategorized with warning
    if ! echo "$CAT_ORDER" | grep -qw "$cat_name"; then
      echo "  ⚠️  Unknown category '$cat_name' for $name — filing under uncategorized"
      cat_name="uncategorized"
    fi

    echo "| [\`$name\`](skills/$name/SKILL.md) | $desc |" >> "/tmp/catalog_${cat_name}.txt"
done

# --- WRITE CATALOG ---

cat > "$CATALOG" <<'EOF'
# Agent Skills Catalog

Overview of available capabilities in the `agentic-foundation` library, organized by domain.
Generated automatically. Run `skills/skill-creator/scripts/update-catalog.sh` to update.

**Naming convention:** `*-workflow` = multi-step process, `*-routine` = periodic/cron-driven, `*-api` = external API integration, no suffix = capability/knowledge.

EOF

for cat_name in $CAT_ORDER; do
    tmpfile="/tmp/catalog_${cat_name}.txt"
    [ ! -s "$tmpfile" ] && continue

    cat_header "$cat_name" >> "$CATALOG"
    cat_desc "$cat_name" >> "$CATALOG"
    echo "" >> "$CATALOG"

    echo "| Skill | Description |" >> "$CATALOG"
    echo "| :--- | :--- |" >> "$CATALOG"

    sort "$tmpfile" >> "$CATALOG"
    echo "" >> "$CATALOG"
done

# Uncategorized (if any)
if [ -s "/tmp/catalog_uncategorized.txt" ]; then
    echo "## ❓ Uncategorized" >> "$CATALOG"
    echo "" >> "$CATALOG"
    echo "| Skill | Description |" >> "$CATALOG"
    echo "| :--- | :--- |" >> "$CATALOG"
    sort "/tmp/catalog_uncategorized.txt" >> "$CATALOG"
    echo "" >> "$CATALOG"
fi

# Cleanup
for cat_name in $CAT_ORDER uncategorized; do
    rm -f "/tmp/catalog_${cat_name}.txt"
done

echo "Generated $CATALOG"

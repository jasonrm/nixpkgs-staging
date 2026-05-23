#!/usr/bin/env bash
set -euo pipefail

# scripts/update-github.sh
#
# Check all packages that source from GitHub (fetchFromGitHub) for newer
# upstream versions using nix-update.
#
# Usage:
#   ./scripts/update-github.sh                    # check all GitHub packages
#   ./scripts/update-github.sh arcanum            # check only 'arcanum'
#   ./scripts/update-github.sh arcanum -- --use-github-releases
#   ./scripts/update-github.sh -- arcanum --use-github-releases
#   ./scripts/update-github.sh -- --use-github-releases --quiet
#
# After running, review changes with:
#   jj diff
#   jj status
#
# Only packages whose version actually changed will have modifications.
# This repo uses Jujutsu (jj), so run `jj status` (or any jj command) after
# editing to ensure new/changed files are tracked.

cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit 1

if [[ ! -f flake.nix ]]; then
  echo "Error: Must be run from the repository root (flake.nix not found)." >&2
  exit 1
fi

echo "Finding all packages using fetchFromGitHub under pkgs/ ..."

packages=()
while IFS= read -r p; do
  packages+=("$p")
done < <(
  find pkgs -path '*/package.nix' -exec grep -l 'fetchFromGitHub' {} + \
    | while IFS= read -r f; do
        basename "$(dirname "$f")"
      done \
    | sort -u
)

if [[ ${#packages[@]} -eq 0 ]]; then
  echo "No packages using fetchFromGitHub found."
  exit 0
fi

echo "Found ${#packages[@]} GitHub-sourced package(s)."
echo

# --- Argument parsing -------------------------------------------------
# Supports:
#   ./scripts/update-github.sh
#   ./scripts/update-github.sh arcanum
#   ./scripts/update-github.sh arcanum -- --use-github-releases
#   ./scripts/update-github.sh -- arcanum
#   ./scripts/update-github.sh -- arcanum --use-github-releases
#   ./scripts/update-github.sh -- --use-github-releases
#
# A single package name may appear either before the first '--' or as the
# first non-flag argument after '--'. Everything after '--' (after the
# optional package name) is forwarded to nix-update.

target_pkg=""
extra_args=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --)
      shift
      # After --, the next token (if present and not a flag) may be a package name
      if [[ $# -gt 0 && "$1" != -* ]]; then
        if printf '%s\n' "${packages[@]}" | grep -qxF "$1"; then
          target_pkg="$1"
          shift
        fi
      fi
      extra_args=("$@")
      break
      ;;
    -*)
      # Flags appearing before any -- are treated as nix-update flags
      extra_args=("$@")
      break
      ;;
    *)
      # Bare word before -- is the target package
      if [[ -z "$target_pkg" ]]; then
        if printf '%s\n' "${packages[@]}" | grep -qxF "$1"; then
          target_pkg="$1"
          shift
          continue
        else
          echo "Error: '$1' is not a GitHub-sourced package managed by this script." >&2
          echo "Run without arguments to see the full list." >&2
          exit 1
        fi
      else
        echo "Error: Only one package name is supported." >&2
        exit 1
      fi
      ;;
  esac
done

if [[ -n "$target_pkg" ]]; then
  packages=("$target_pkg")
  echo "Targeting single package: $target_pkg"
  echo
fi

updated_list=()   # entries like "cake-stats:1.0.27 -> 1.0.29"

for pkg in "${packages[@]}"; do
  echo "=== Checking $pkg ==="
  # Capture output so we can parse "Update X -> Y" messages for good commit suggestions
  output=$(nix run github:Mic92/nix-update -- "$pkg" --flake "${extra_args[@]}" 2>&1 || true)
  echo "$output"

  # Parse nix-update's "Update old -> new in .../pkgs/NAME/package.nix" lines
  # (regex stored in a variable for compatibility with macOS bash 3.2)
  update_re='Update ([^ ]+) -> ([^ ]+) in .*/pkgs/([^/]+)/package.nix'
  while IFS= read -r line; do
    if [[ $line =~ $update_re ]]; then
      old_ver="${BASH_REMATCH[1]}"
      new_ver="${BASH_REMATCH[2]}"
      name="${BASH_REMATCH[3]}"
      updated_list+=("$name:$old_ver -> $new_ver")
    fi
  done <<< "$output"
done

echo
echo "=== Finished checking ${#packages[@]} package(s) ==="
echo

# If we saw real version updates from nix-update, give precise ready-to-paste jj commit commands
if [[ ${#updated_list[@]} -gt 0 ]]; then
  echo "Suggested commit commands:"
  for entry in "${updated_list[@]}"; do
    name="${entry%%:*}"
    vers="${entry#*:}"
    echo "  jj commit -m \"$name: $vers\" pkgs/$name/package.nix"
  done
  echo
else
  # Fallback when there were no version bumps (e.g. --version=skip or only hash refreshes)
  if [[ -n "${target_pkg:-}" ]]; then
    pkg_file="pkgs/${target_pkg}/package.nix"
    if jj diff --name-only 2>/dev/null | grep -q "$pkg_file"; then
      echo "Package file was modified during this run: $pkg_file"
      echo "  jj commit -m \"$target_pkg: update\" $pkg_file"
    else
      echo "No changes were made to $pkg_file (already up to date or no hash changes with the flags used)."
    fi
  else
    echo "The following package files were modified (if any had newer versions upstream):"
    jj diff --name-only 2>/dev/null || git diff --name-only 2>/dev/null || true
  fi
  echo
fi

echo "Review full diff with:  jj diff"

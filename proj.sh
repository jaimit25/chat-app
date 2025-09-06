#!/bin/bash

OUTPUT_FILE="project-structure.txt"


# Start fresh
echo "Project Structure - $(date)" > "$OUTPUT_FILE"
echo "------------------------------------" >> "$OUTPUT_FILE"

print_dir() {
    local dir="$1"
    local prefix="$2"

    for entry in "$dir"/*; do
        [ -e "$entry" ] || continue  # Skip if no files
        local name=$(basename "$entry")
        if [ -d "$entry" ]; then
            echo "${prefix}📁 $name/" >> "$OUTPUT_FILE"
            print_dir "$entry" "$prefix    "  
        else
            echo "${prefix}📄 $name" >> "$OUTPUT_FILE"
        fi
    done
}

print_dir "." ""

echo "Project structure saved to $OUTPUT_FILE"

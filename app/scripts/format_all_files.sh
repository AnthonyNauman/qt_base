#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
FORMAT_DIR=app/src

if ! command -v clang-format &> /dev/null; then
    echo -e "${RED}Error: clang-format is not installed${NC}"
    echo "Install it using:"
    echo "  Ubuntu/Debian: sudo apt install clang-format"
    echo "  macOS: brew install clang-format"
    echo "  Windows: install LLVM"
    exit 1
fi

if [ ! -d "${FORMAT_DIR}" ]; then
    echo -e "${RED}Error: directory '${FORMAT_DIR}' not found in current directory${NC}"
    echo "Current directory: $(pwd)"
    exit 1
fi

if [ ! -f ".clang-format" ]; then
    echo -e "${YELLOW}Warning: .clang-format file not found${NC}"
    echo "Default clang-format settings will be used"
    echo ""
fi

echo -e "${GREEN}Starting formatting of files in ${FORMAT_DIR} directory...${NC}"
echo ""

total_files=0
formatted_files=0

while IFS= read -r -d '' file; do
    total_files=$((total_files + 1))
    
    echo -ne "${YELLOW}[$total_files]${NC} Processing: $file ... "
    
    if clang-format -i "$file" 2>/dev/null; then
        echo -e "${GREEN}✓${NC}"
        formatted_files=$((formatted_files + 1))
    else
        echo -e "${RED}✗ (formatting error)${NC}"
    fi
    
done < <(find ${FORMAT_DIR} -type f \( -name "*.cpp" -o -name "*.h" -o -name "*.hpp" -o -name "*.c" -o -name "*.cxx" \) -print0)

echo ""
echo -e "${GREEN}Formatting completed!${NC}"
echo -e "Total files: ${YELLOW}$total_files${NC}"
echo -e "Formatted: ${GREEN}$formatted_files${NC}"
echo -e "Errors: ${RED}$((total_files - formatted_files))${NC}"

if [ $formatted_files -lt $total_files ]; then
    echo ""
    echo -e "${YELLOW}Do you want to see the list of files with errors? (y/n)${NC}"
    read -r show_errors
    if [ "$show_errors" = "y" ] || [ "$show_errors" = "Y" ]; then
        find ${FORMAT_DIR} -type f \( -name "*.cpp" -o -name "*.h" -o -name "*.hpp" -o -name "*.c" -o -name "*.cxx" \) -exec clang-format -n {} \; 2>&1 | grep -v "Done"
    fi
fi
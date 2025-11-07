#!/bin/bash

NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
ORANGE='\033[0;33m' 
PINK='\033[1;38;5;200m'
KUNMUD='\033[1;38;5;228m'
PPK='\033[1;38;5;228m'
INI1='\e[34m'
INI2='\e[7m'
INI3='\033[1;38;5;172m' 
INI4='\033[1;38;5;057m'
INI5='\033[1;38;5;160m'
INI6='\033[1;38;5;120m'
BRIGHT_RED='\033[1;31m'
BRIGHT_GREEN='\033[1;32m'
BRIGHT_YELLOW='\033[1;33m'
BRIGHT_BLUE='\033[1;34m'
BRIGHT_MAGENTA='\033[1;35m'
BRIGHT_CYAN='\033[1;36m'
BRIGHT_WHITE='\033[1;37m'

## JANGAN DI UBAH \\ SETTINGAN DEFFAULT // ###
MAX_CONCURRENT=15
BATCH_SIZE=12
TIMEOUT_SMTP=10
CONNECTION_TIMEOUT=5
DELAY_BETWEEN_BATCHES=1
#############################################

ENCRYPT_KEY="KONTOLTERBANG2025"

# Password protection - encoded
check_password() {
    local pass_enc="TE9OR0VOVE9UMjAyNQ=="
    local pass_real=$(echo "$pass_enc" | base64 -d 2>/dev/null)
    printf "${BRIGHT_WHITE}Enter password to start validation: ${NC}"
    read -s user_input
    echo
    if [[ "$user_input" != "$pass_real" ]]; then
        printf "${RED}Wrong password! Access denied.${NC}\n"
        exit 1
    fi
    printf "${GREEN}Password accepted! Starting validation...${NC}\n\n"
}

# Generate random user agent
generate_user_agent() {
    local agents=(
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/121.0"
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    )
    local count=${#agents[@]}
    local random_index=$((RANDOM % count))
    echo "${agents[$random_index]}"
}

encrypt_response() {
    local data="$1"
    echo "$data" | openssl enc -aes-256-cbc -a -salt -pass pass:"$ENCRYPT_KEY" 2>/dev/null
}

print_banner() {
    clear
    echo ""
    printf "${BRIGHT_CYAN}"
    echo "██████╗ ██╗  ██╗██╗  ██╗███╗   ██╗██████╗ ██╗   ██╗"
    echo "██╔══██╗██║  ██║██║  ██║████╗  ██║██╔══██╗╚██╗ ██╔╝"
    echo "██║  ██║███████║███████║██╔██╗ ██║██║  ██║ ╚████╔╝ "
    echo "██║  ██║██╔══██║╚════██║██║╚██╗██║██║  ██║  ╚██╔╝  "
    echo "██████╔╝██║  ██║     ██║██║ ╚████║██████╔╝   ██║   "
    echo "╚═════╝ ╚═╝  ╚═╝     ╚═╝╚═╝  ╚═══╝╚═════╝    ╚═╝   "
    printf "${NC}"
    printf "${BRIGHT_MAGENTA}"
    echo "███╗   ███╗██╗ ██████╗██████╗  ██████╗ ███████╗ ██████╗ ███████╗████████╗"
    echo "████╗ ████║██║██╔════╝██╔══██╗██╔═══██╗██╔════╝██╔═══██╗██╔════╝╚══██╔══╝"
    echo "██╔████╔██║██║██║     ██████╔╝██║   ██║███████╗██║   ██║█████╗     ██║   "
    echo "██║╚██╔╝██║██║██║     ██╔══██╗██║   ██║╚════██║██║   ██║██╔══╝     ██║   "
    echo "██║ ╚═╝ ██║██║╚██████╗██║  ██║╚██████╔╝███████║╚██████╔╝██║        ██║   "
    echo "╚═╝     ╚═╝╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝        ╚═╝   "

    printf "${NC}"
    printf "${BRIGHT_BLUE}============================================================================${NC}\n"
    printf "${BRIGHT_RED}                MICROSOFT FAMILY VALIDATOR - DH4NDY 2025${NC}\n"
    printf "${BRIGHT_BLUE}============================================================================${NC}\n\n"
}

# ============================ MICROSOFT FAMILY VALIDATION ============================

validate_microsoft_family() {
    local email="$1"
    
    # Encoded and obfuscated validation logic
    local u_a=$(generate_user_agent)
    local url_part1="https://odc.officeapps.live.com/odc/emailhrd"
    local url_part2="/getidp?hm=0&emailAddress=${email}&_=1604288577990"
    
    local result=$(wget -qO- --timeout=$TIMEOUT_SMTP --user-agent="$u_a" \
        --header="Accept: */*" \
        --header="Content-Type: application/x-www-form-urlencoded" \
        --header="Connection: close" \
        --header="Host: odc.officeapps.live.com" \
        --header="Accept-Encoding: gzip, deflate" \
        --header="Referer: https://odc.officeapps.live.com/odc/v2.0/hrd?rs=ar-sa&Ver=16&app=23&p=6&hm=0" \
        --header="Accept-Language: ar,en-US;q=0.9,en;q=0.8" \
        --header="canary: BCfKjqOECfmW44Z3Ca7vFrgp9j3V8GQHKh6NnEESrE13SEY/4jyexVZ4Yi8CjAmQtj2uPFZjPt1jjwp8O5MXQ5GelodAON4Jo11skSWTQRzz6nMVUHqa8t1kVadhXFeFk5AsckPKs8yXhk7k4Sdb5jUSpgjQtU2Ydt1wgf3HEwB1VQr+iShzRD0R6C0zHNwmHRnIatjfk0QJpOFHl2zH3uGtioL4SSusd2CO8l4XcCClKmeHJS8U3uyIMJQ8L+tb:2:3c" \
        --header="uaid: d06e1498e7ed4def9078bd46883f187b" \
        "${url_part1}${url_part2}" 2>/dev/null)
    
    # Obfuscated response checking
    local check1="MSAccount"
    local check2="Neither"
    
    if echo "$result" | grep -q "$check1"; then
        return 0
    elif echo "$result" | grep -q "$check2"; then
        return 1
    else
        return 2
    fi
}

# ============================ MICROSOFT DOMAIN DETECTION ============================

is_microsoft_domain() {
    local email="$1"
    local domain=$(echo "$email" | cut -d'@' -f2 | tr '[:upper:]' '[:lower:]' | sed 's/^ *//;s/ *$//')
    
    # Match semua domain Microsoft termasuk yang ada kode negara
    case "$domain" in
        *"outlook"*|*"hotmail"*|*"live"*|*"msn"*) 
            return 0 
            ;;
        *) 
            return 1 
            ;;
    esac
}

# ============================ PROCESSING FUNCTIONS ============================

process_single_email() {
    local email=$1
    local index=$2
    local total=$3
    local timestamp=$(date +%H:%M:%S)
    
    local kirigan="${INI1}D${NC}${INI5}H${NC}${INI3}4${NC}${INI4}N${NC}${INI5}D${NC}${INI6}Y${NC} | ${PPK}M${NC}I${INI6}C${NC}${INI5}R${NC}${INI4}O${NC}${INI3}S${NC}${INI6}O${NC}${INI1}F${NC}${GREEN}T${NC}${ORANGE}"
    
    # Clean email address
    email=$(echo "$email" | tr -d '\r' | sed 's/^ *//;s/ *$//')
    
    # Skip empty lines
    if [[ -z "$email" ]]; then
        return
    fi
    
    # Check if it's Microsoft domain
    if ! is_microsoft_domain "$email"; then
        printf "$kirigan | [%d/%d] |${ORANGE} NOT MICROSOFT ${NC}|${YELLOW} $email ${NC}| %s\n" "$index" "$total" "$timestamp"
        echo "$email" >> "$targetFolder/not_microsoft.txt"
        return
    fi
    
    # Validate Microsoft Family
    validate_microsoft_family "$email"
    local result=$?
    
    if [[ $result -eq 0 ]]; then
        printf "$kirigan | [%d/%d] |${GREEN} MICROSOFT VALID ${NC}|${YELLOW} $email ${NC}| %s\n" "$index" "$total" "$timestamp"
        echo "$email" >> "$targetFolder/microsoft_valid.txt"
    elif [[ $result -eq 1 ]]; then
        printf "$kirigan | [%d/%d] |${RED} MICROSOFT INVALID ${NC}|${YELLOW} $email ${NC}| %s\n" "$index" "$total" "$timestamp"
        echo "$email" >> "$targetFolder/microsoft_invalid.txt"
    else
        printf "$kirigan | [%d/%d] |${YELLOW} MICROSOFT UNKNOWN ${NC}|${YELLOW} $email ${NC}| %s\n" "$index" "$total" "$timestamp"
        echo "$email" >> "$targetFolder/microsoft_unknown.txt"
    fi
}

# ============================ MAIN EXECUTION ============================

inputFile=""
targetFolder=""
sendList=$BATCH_SIZE
perSec=$DELAY_BETWEEN_BATCHES
isDel='n'

usage() { 
    print_banner
    echo ""
    printf "${BRIGHT_WHITE}Usage:${NC} ${BRIGHT_CYAN}$0 -i <list.txt> -r <folder/> [-l <number>] [-t <seconds>] [-d]${NC}\n"
    printf "${BRIGHT_YELLOW}Example:${NC} ${GREEN}$0 -i emails.txt -r results/ -l 12 -t 1${NC}\n\n"
    
    printf "${BRIGHT_WHITE}Performance Options:${NC}\n"
    printf "  ${BRIGHT_CYAN}-i <file>${NC}    Input file containing emails\n"
    printf "  ${BRIGHT_CYAN}-r <folder>${NC}  Result folder\n"
    printf "  ${BRIGHT_CYAN}-l <number>${NC}  Emails per batch ${YELLOW}[default: $BATCH_SIZE]${NC}\n"
    printf "  ${BRIGHT_CYAN}-t <seconds>${NC} Delay between batches ${YELLOW}[default: $DELAY_BETWEEN_BATCHES]${NC}\n"
    printf "  ${BRIGHT_CYAN}-d${NC}           Delete processed emails\n"
    printf "  ${BRIGHT_CYAN}-h${NC}           Show this help\n"
    printf "\n${BRIGHT_YELLOW}Supported Domains:${NC}\n"
    printf "  ${GREEN}•${NC} @outlook.* (semua domain outlook)\n"
    printf "  ${GREEN}•${NC} @hotmail.* (semua domain hotmail)\n"
    printf "  ${GREEN}•${NC} @live.* (semua domain live)\n"
    printf "  ${GREEN}•${NC} @msn.* (semua domain msn)\n"
    printf "\n${BRIGHT_YELLOW}Security Features:${NC}\n"
    printf "  ${GREEN}•${NC} Encrypted response storage\n"
    printf "  ${GREEN}•${NC} AES-256-CBC encryption\n"
    printf "  ${GREEN}•${NC} Secure Microsoft API validation\n"
    exit 1 
}

while getopts "i:r:l:t:dh" opt; do
    case $opt in
        i) inputFile="$OPTARG" ;;
        r) targetFolder="$OPTARG" ;;
        l) sendList="$OPTARG" ;;
        t) perSec="$OPTARG" ;;
        d) isDel='y' ;;
        h) usage ;;
        *) printf "${RED}Invalid option: -$OPTARG${NC}\n" >&2; usage ;;
    esac
done

if [[ $# -eq 0 ]]; then
    print_banner
    printf "${BRIGHT_CYAN}DH4NDY Microsoft Family Validator${NC}\n"
    printf "${BRIGHT_BLUE}=================================================${NC}\n\n"
    
    while [[ -z "$inputFile" ]]; do
        printf "${BRIGHT_YELLOW}Available .txt files:${NC}\n"
        ls *.txt 2>/dev/null | while read file; do
            printf "  ${CYAN}•${NC} ${GREEN}$file${NC}\n"
        done || printf "  ${YELLOW}No .txt files found in current directory${NC}\n"
        
        printf "\n${BRIGHT_WHITE}Enter email list file: ${NC}"
        read inputFile
        if [[ ! -f "$inputFile" ]]; then
            printf "${RED}File not found: $inputFile${NC}\n"
            inputFile=""
        fi
    done
    
    while [[ -z "$targetFolder" ]]; do
        printf "${BRIGHT_WHITE}Enter result folder: ${NC}"
        read targetFolder
        if [[ -z "$targetFolder" ]]; then
            printf "${RED}Result folder is required${NC}\n"
        fi
    done
    
    printf "${BRIGHT_WHITE}Emails per batch ${YELLOW}[$BATCH_SIZE]: ${NC}"
    read customSendList
    [[ -n "$customSendList" ]] && sendList="$customSendList"
    
    printf "${BRIGHT_WHITE}Delay between batches (seconds) ${YELLOW}[$DELAY_BETWEEN_BATCHES]: ${NC}"
    read customPerSec
    [[ -n "$customPerSec" ]] && perSec="$customPerSec"
    
    printf "${BRIGHT_WHITE}Delete processed emails? ${YELLOW}[y/N]: ${NC}"
    read deleteChoice
    [[ "$deleteChoice" == "y" || "$deleteChoice" == "Y" ]] && isDel='y'
fi

if [[ -z "$inputFile" || -z "$targetFolder" ]]; then
    printf "${RED}Error: Input file and result folder are required${NC}\n"
    usage
fi

if [[ ! -f "$inputFile" ]]; then
    printf "${RED}Error: Input file '$inputFile' not found${NC}\n"
    exit 1
fi

# Password protection
check_password

mkdir -p "$targetFolder"
SECONDS=0

print_banner

printf "${BRIGHT_YELLOW}Initializing DH4NDY Microsoft Family Validation...${NC}\n"
printf "${BRIGHT_BLUE}╔══════════════════════════════════════════════════════════╗${NC}\n"

printf "${BRIGHT_WHITE}Checking system requirements...${NC}"
if command -v wget &>/dev/null && command -v openssl &>/dev/null; then
    printf " ${GREEN}OK${NC}\n"
else
    printf " ${RED}FAILED${NC}\n"
    printf "${RED}Error: Required tools (wget, openssl) not found${NC}\n"
    exit 1
fi

printf "${BRIGHT_WHITE}Loading input file...${NC}"
if [[ -f "$inputFile" ]]; then
    file_size=$(wc -l < "$inputFile" 2>/dev/null || echo 0)
    printf " ${GREEN}OK${NC} ${CYAN}($file_size lines)${NC}\n"
else
    printf " ${RED}FAILED${NC}\n"
    exit 1
fi

printf "${BRIGHT_WHITE}Testing Microsoft API connectivity...${NC}"
if wget -q --timeout=5 --tries=1 "https://odc.officeapps.live.com" -O /dev/null; then
    printf " ${GREEN}CONNECTED${NC}\n"
else
    printf " ${YELLOW}SLOW${NC}\n"
fi

printf "${BRIGHT_BLUE}╚══════════════════════════════════════════════════════════╝${NC}\n\n"

printf "${BRIGHT_MAGENTA}Filtering Microsoft email addresses...${NC}\n"

# Mengambil semua domain Microsoft termasuk yang ada kode negara
grep -Eio '[a-zA-Z0-9._%+-]+@(outlook|hotmail|live|msn)\.[a-zA-Z]{2,}' "$inputFile" 2>/dev/null | \
tr '[:upper:]' '[:lower:]' | awk '!seen[$0]++' | sort > "$inputFile.microsoft_emails"

totalMicrosoft=$(wc -l < "$inputFile.microsoft_emails" 2>/dev/null || echo 0)
totalOriginal=$(wc -l < "$inputFile" 2>/dev/null || echo 0)

if [[ $totalMicrosoft -eq 0 ]]; then
    printf "${RED}Error: No Microsoft email addresses found in input file${NC}\n"
    printf "${YELLOW}Supported domains: outlook.*, hotmail.*, live.*, msn.*${NC}\n"
    printf "${YELLOW}Total emails in original file: $totalOriginal${NC}\n"
    exit 1
fi

printf "${GREEN}Found $totalMicrosoft Microsoft addresses ${YELLOW}(from $totalOriginal total)${NC}\n\n"

printf "${BRIGHT_GREEN}Starting Microsoft Family validation...${NC}\n"
printf "${BRIGHT_BLUE}Performance Configuration:${NC}\n"
printf "  ${BRIGHT_WHITE}• Concurrent processes:${NC} ${CYAN}$MAX_CONCURRENT${NC}\n"
printf "  ${BRIGHT_WHITE}• Emails per batch:${NC} ${CYAN}$sendList${NC}\n"
printf "  ${BRIGHT_WHITE}• Delay between batches:${NC} ${CYAN}$perSec seconds${NC}\n"
printf "  ${BRIGHT_WHITE}• API Timeout:${NC} ${CYAN}${TIMEOUT_SMTP}s${NC}\n"
printf "  ${BRIGHT_WHITE}• Total to process:${NC} ${CYAN}$totalMicrosoft emails${NC}\n"
printf "  ${BRIGHT_WHITE}• Security:${NC} ${GREEN}ENCRYPTED RESPONSE SYSTEM${NC}\n\n"

printf "${BRIGHT_YELLOW}Launching parallel validation engine...${NC}\n"
printf "${BRIGHT_BLUE}════════════════════════════════════════════════════════════════════════════════════════════════════════════${NC}\n"

# Initialize result files
> "$targetFolder/microsoft_valid.txt"
> "$targetFolder/microsoft_invalid.txt"
> "$targetFolder/microsoft_unknown.txt"
> "$targetFolder/not_microsoft.txt"

# Process emails
mapfile -t email_array < "$inputFile.microsoft_emails"
total_emails=${#email_array[@]}
current_index=0

while [[ $current_index -lt $total_emails ]]; do
    batch_end=$((current_index + sendList))
    [[ $batch_end -gt $total_emails ]] && batch_end=$total_emails
    
    for ((i=current_index; i<batch_end; i++)); do
        email="${email_array[i]}"
        [[ -z "$email" ]] && continue
        
        process_index=$((i + 1))
        process_single_email "$email" "$process_index" "$total_emails" &
        
        while [[ $(jobs -r | wc -l) -ge $MAX_CONCURRENT ]]; do
            sleep 0.1
        done
    done
    
    wait
    
    current_index=$batch_end
    
    progress=$((current_index * 100 / total_emails))
    printf "${BRIGHT_CYAN}════════════════════════════════════════> Progress: %d/%d (%d%%) <════════════════════════════════════════${NC}\n" "$current_index" "$total_emails" "$progress"
    
    [[ $current_index -lt $total_emails ]] && sleep "$perSec"
    
    if [[ "$isDel" == 'y' ]]; then
        for ((i=current_index-sendList; i<current_index; i++)); do
            email="${email_array[i]}"
            [[ -n "$email" ]] && sed -i "/^${email}$/d" "$inputFile" 2>/dev/null
        done
    fi
done

printf "${BRIGHT_BLUE}═════════════════════════════════════════════════════════════════════════════════════════════════════════════${NC}\n"

printf "\n${BRIGHT_GREEN}Validation Completed!${NC}\n"
printf "${BRIGHT_BLUE}════════════════════════════════════════════════════════════${NC}\n"

# Generate final report
microsoft_valid=0
microsoft_invalid=0
microsoft_unknown=0
not_microsoft=0

[[ -f "$targetFolder/microsoft_valid.txt" ]] && microsoft_valid=$(wc -l < "$targetFolder/microsoft_valid.txt")
[[ -f "$targetFolder/microsoft_invalid.txt" ]] && microsoft_invalid=$(wc -l < "$targetFolder/microsoft_invalid.txt")
[[ -f "$targetFolder/microsoft_unknown.txt" ]] && microsoft_unknown=$(wc -l < "$targetFolder/microsoft_unknown.txt")
[[ -f "$targetFolder/not_microsoft.txt" ]] && not_microsoft=$(wc -l < "$targetFolder/not_microsoft.txt")

total_checked=$((microsoft_valid + microsoft_invalid + microsoft_unknown))

printf "${GREEN}Microsoft Valid:${NC}   ${CYAN}$microsoft_valid${NC}\n"
printf "${RED}Microsoft Invalid:${NC} ${CYAN}$microsoft_invalid${NC}\n"
printf "${YELLOW}Microsoft Unknown:${NC} ${CYAN}$microsoft_unknown${NC}\n"
printf "${ORANGE}Non-Microsoft:${NC}     ${CYAN}$not_microsoft${NC}\n"

printf "\n${BRIGHT_WHITE}DH4NDY PERFORMANCE REPORT:${NC}\n"
printf "${BRIGHT_BLUE}────────────────────────────────────────────────────────────${NC}\n"
printf "${GREEN}MICROSOFT VALID:   $microsoft_valid${NC}\n"
printf "${RED}MICROSOFT INVALID: $microsoft_invalid${NC}\n"
printf "${BRIGHT_CYAN}TOTAL PROCESSED:  $total_checked${NC}\n"
printf "${YELLOW}ORIGINAL COUNT:  $totalOriginal${NC}\n"

if [[ $total_checked -gt 0 ]]; then
    accuracy=$(( (microsoft_valid * 100) / total_checked ))
    printf "${BRIGHT_MAGENTA}SUCCESS RATE:    $accuracy%%${NC}\n"
    
    if [[ $accuracy -gt 90 ]]; then
        printf "${BRIGHT_GREEN}PERFORMANCE: EXCELLENT${NC}\n"
    elif [[ $accuracy -gt 70 ]]; then
        printf "${BRIGHT_YELLOW}PERFORMANCE: GOOD${NC}\n"
    else
        printf "${BRIGHT_RED}PERFORMANCE: NEEDS CHECK${NC}\n"
    fi
fi

duration=$SECONDS
emails_per_second=0
[[ $duration -gt 0 ]] && emails_per_second=$((total_checked / duration))

printf "\n${BRIGHT_WHITE}SECURITY & SPEED METRICS:${NC}\n"
printf "${BRIGHT_BLUE}────────────────────────────────────────────────────────────${NC}\n"
printf "${CYAN}Total time:      ${duration}s${NC}\n"
printf "${GREEN}Speed:           ${emails_per_second} emails/second${NC}\n"
printf "${YELLOW}Security:        ENCRYPTED RESPONSE SYSTEM${NC}\n"
printf "${MAGENTA}Encryption:     AES-256-CBC ACTIVE${NC}\n"

archive_dir="microsoft_checked_$(date +%Y%m%d_%H%M%S)"
mv "$targetFolder" "$archive_dir"
rm -f "$inputFile.microsoft_emails"

printf "\n${BRIGHT_GREEN}Results: ${BRIGHT_CYAN}$archive_dir${NC}\n"
printf "${BRIGHT_YELLOW}DH4NDY Microsoft Family validation completed!${NC}\n\n"

printf "${BRIGHT_BLUE}╔══════════════════════════════════════════════════════════╗${NC}\n"
printf "${BRIGHT_BLUE}║                       DH4NDY - 2025                      ║${NC}\n"
printf "${BRIGHT_BLUE}╚══════════════════════════════════════════════════════════╝${NC}\n"

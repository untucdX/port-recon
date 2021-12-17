source ~/.bash_profile

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

echo "${RED} ######################################################### ${RESET}"
echo "${RED} #                         Let's Hunt                    # ${RESET}"
echo "${RED} ######################################################### ${RESET}"

while getopts ":d:" input; do
        case "$input" in
        d)
                domain=${OPTARG}
                ;;
        esac
done
if [ -z "$domain" ]; then
        echo "${BLUE}Please give a domain like \"-d domain.com\"${RESET}"
        exit 1
fi

mkdir $domain
cd $domain

echo $domain > all.txt

echo "${BLUE} ######################################################### ${RESET}"
echo "${BLUE} #                      Running Naabu                    # ${RESET}"
echo "${BLUE} ######################################################### ${RESET}"

naabu -l all.txt -c 40 -p - -nmap-cli 'nmap -nv -sSV -A -oN --script nmap-vulners,vulscan nmap_scan.txt' -o naabu_portscan.txt

echo "${BLUE} ######################################################### ${RESET}"
echo "${BLUE} #              Checking for alive subdomains            # ${RESET}"
echo "${BLUE} ######################################################### ${RESET}"

cat naabu_portscan.txt | httprobe -c 100 | tee -a alive2.txt
cat alive2.txt | sort -u | tee -a alive.txt
rm alive2.txt


# nikto --host $domain >nikto.txt

# echo "${BLUE} ######################################################### ${RESET}"
# echo "${BLUE} #                       Starting Nuclei                 # ${RESET}"
# echo "${BLUE} ######################################################### ${RESET}"

# mkdir nuclei_op
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/cves/" -c 100 -o nuclei_op/cves.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/default-logins/" -c 100 -o nuclei_op/default-logins.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/dns/" -c 100 -o nuclei_op/dns.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/exposed-panels/" -c 100 -o nuclei_op/exposed-panels.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/exposed-tokens/" -c 100 -o nuclei_op/exposed-tokens.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/exposures/" -c 100 -o nuclei_op/exposures.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/fuzzing/" -c 100 -o nuclei_op/fuzzing.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/helpers/" -c 100 -o nuclei_op/helpers.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/miscellaneous/" -c 100 -o nuclei_op/miscellaneous.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/misconfiguration/" -c 100 -o nuclei_op/misconfiguration.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/takeovers/" -c 100 -o nuclei_op/takeovers.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/technologies/" -c 100 -o nuclei_op/technologies.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/vulnerabilities/" -c 100 -o nuclei_op/vulnerabilities.txt
# nuclei -l alive.txt -t "/root/tools/nuclei-templates/workflows/" -c 100 -o nuclei_op/workflows.txt

# echo "${BLUE} ######################################################### ${RESET}"
# echo "${BLUE} #            Looking for HTTP request smuggling         # ${RESET}"
# echo "${BLUE} ######################################################### ${RESET}"

# cat alive.txt | smuggler | tee -a smuggler_op.txt

cd ..

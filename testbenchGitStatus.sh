#!/bin/bash
set -e # Exit on first error

nmapResults=$(sudo nmap -sn 10.0.5.188/22 | grep -i 'testbench\|deploy\|metalXO')

echo "$nmapResults"
echo ''

gitStatus="cd ~/repo/realtime && git status || error with git status"

readarray testBenchList <<<"${nmapResults}"
for var in "${testBenchList[@]}"; do

	# Isolate the ip and domain name
	ip="$(echo "${var}" | cut -d' ' -f6 | tr -d '()')"
    domain="$(echo "${var}" | cut -d' ' -f5)"
    echo "${domain} (${ip})"

    timeout 3 sshpass -p 'sarcos' ssh "sarcos@${ip}" "${gitStatus}" || echo 'error'

    echo ''

done


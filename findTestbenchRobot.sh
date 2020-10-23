#!/bin/bash
set -e # Exit on first error

nmapResults=$(sudo nmap -sn 10.0.5.255/22 | grep -i 'testbench\|deploy\|metalXO\|alpha')

echo "$nmapResults"
echo ''

checkRobot="timeout 2 sshpass -p 'sarcos' ssh sarcos@192.168.113.2 'hostname' || echo no robot"

readarray testBenchList <<<"${nmapResults}"
for var in "${testBenchList[@]}"; do

	# Isolate the ip and domain name
	ip="$(echo "${var}" | cut -d' ' -f6 | tr -d '()')"
    domain="$(echo "${var}" | cut -d' ' -f5)"
    echo "${domain} (${ip})"

    timeout 3 sshpass -p 'sarcos' ssh "sarcos@${ip}" "${checkRobot}" || echo 'cant enter as sarcos'

    echo ''

done

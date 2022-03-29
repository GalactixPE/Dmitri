#!/bin/bash
iptables -I DOCKER -p udp --dport 19132 -j REJECT

ipset -N nl hash:net
ipset -N be hash:net
ipset -N es hash:net

for i in $(cat nl.zone ); do ipset -A nl $i; done
for i in $(cat be.zone ); do ipset -A be $i; done
for i in $(cat es.zone ); do ipset -A es $i; done

iptables -I DOCKER -p udp --dport 19132 -m set --match-set nl src -j ACCEPT
iptables -I DOCKER -p udp --dport 19132 -m set --match-set be src -j ACCEPT
iptables -I DOCKER -p udp --dport 19132 -m set --match-set es src -j ACCEPT

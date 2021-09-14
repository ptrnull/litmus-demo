#!/bin/bash
for i in $(cat litmus.installed| cut -f1 -d' '); do
	kubectl delete $i; 
done
kubectl delete pv litmus
kubectl delete sc manual
rm -rf /mnt/data/litmus/*
rm -rf /usr/local/bin/litmusctl

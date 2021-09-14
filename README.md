# litmus-demo

Litmus is an end-to-end chaos engineering platform for cloud native infrastructure and applications. Cloud native SREs, QA teams and developers use Litmus to design, orchestrate and analyse chaos in their environments.

More info: https://docs.litmuschaos.io/

This repo contains some scripts to automate a basic installation and uninstall of the Limus Chaos software under Kubernetes for demo testing.

* install.sh: script to install Limus Chaos
* uninstall.sh: script to uninstall Linus Chaos
* limus-pv.yaml: a PV definition of 1GB to store the mongodb db
* limus-sc.yaml: a SC definition to manage the PVs and PVCs


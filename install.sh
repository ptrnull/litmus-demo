#!/bin/bash
litmusyaml=litmus-2.0.0.yaml
litmusctl=/usr/local/bin/litmusctl
litmusctltar=litmusctl-linux-amd64-v0.3.0.tar.gz

if [ -f ${litmusyaml} ]; then
	echo "Old ${litmusyaml} file found, removing."
	rm -rf ${litmusyaml} ${litmusyaml}.ori litmusctl-linux-amd64-v0.3.0.tar.gz
fi
echo "Downloading litmus yaml"
wget https://litmuschaos.github.io/litmus/2.0.0/${litmusyaml} &> /dev/null
if [ $? -ne 0 ]; then
	echo "Error when downloading ${litmusyaml}, aborting"
	exit 1
fi


if [ -f ${litmusctl} ]; then
	echo "${litmusctl} binary found, skipping download.";
else
	echo "Downloading litmusctl"
	wget https://litmusctl-production-bucket.s3.amazonaws.com/${litmusctltar}  &> /dev/null
	if [ $? -ne 0 ]; then
		echo "Error when downloading ${litmusyaml}, aborting"
		exit 1
	else
		tar -zxvf ${litmusctltar}
		mv litmusctl /usr/local/bin/
		chmod +x /usr/local/bin/litmusctl
	fi
fi



if [ -f ${litmusyaml} ]; then
	cp ${litmusyaml} ${litmusyaml}.ori
	echo "Modifying downloaded file..."
	sed -i 's/20Gi/1Gi/g' ${litmusyaml}
	sed -i "707 a \        storageClassName: manual" ${litmusyaml}
	echo "Installing litmus..."
	kubectl apply -f ${litmusyaml} > litmus.installed
	echo "Creating a PV for mongodb"
	kubectl create -f litmus-pv.yaml
	echo "Creating an storage class"
	kubectl create -f litmus-sc.yaml
	kubectl config set-context --current --namespace=litmus
	kubectl get pods -w
fi


#!/bin/bash

echo Installing dependencies
apk --update --no-cache add openssl curl libc6-compat git openssh-client python py-pip python3 && pip install awscli

echo Downloading And Installing Terraform
curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip
unzip -d /usr/local/bin terraform.zip
rm terraform.zip

rm -rf .terraform

echo Creating Authorising Files
cat ../gcp-service-account | openssl enc -aes-128-cbc -a -d -salt -pass pass:$gcp_account_pass > ~/serviceaccount.json
cat docker-user | openssl enc -aes-128-cbc -a -d -salt -pass pass:$gcp_account_pass > ~/docker-user
mv docker-user.pub ~/docker-user.pub

#
# this makefile is meant to be a root of all configuration on skynet
#

init: install-terraform install-template install-job

install-terraform:
	@echo "installing terraform"
	@go get -u github.com/hashicorp/terraform

install-template:
	@echo "installing go-sdk/template"
	@go get -u github.com/blend/go-sdk/cmd/template	

install-job:
	@echo "installing go-sdk/job"
	@go get -u github.com/blend/go-sdk/cmd/job
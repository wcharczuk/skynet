#
# this makefile is meant to be a root of all configuration on skynet
#

#
# preamble: helper variables and context
#
SHA=$(shell git rev-parse --short HEAD)
VERSION=$(shell cat VERSION)
DIRTY=$(shell if `git diff-index --quiet HEAD --`; then echo false; else echo true;  fi)

#
# initialization & setup targets
#

TERRAFORM_INSTALLED := $(shell command -v terraform 2> /dev/null)

init: install-terraform

doctor: terraform-required

install-terraform:
	@echo "installing terraform"
	@go get -u github.com/hashicorp/terraform

terraform-required:
ifndef TERRAFORM_INSTALLED
	$(error "terraform is not available please install terraform")
endif

#
# operational targets
#

fmt:
	$(SHELL) -c 'for f in $(TF); do printf .; terraform fmt $$f; done'; \
	echo

lint: terraform-validate lint-terraform-fmt lint-tflint

terraform-validate:
	@$(SHELL) -c 'env'
	@$(SHELL) -c 'terraform validate -check-variables=true'

lint-terraform-fmt: terraform
	$(SHELL) -c 'for f in $(TF); do printf .; terraform fmt --check=true --diff=true $$f || exit $$? ; done'
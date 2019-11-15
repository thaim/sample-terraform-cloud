

.PHONY: help fmt init plan apply destroy

help: ## Show help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-12s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

fmt: ## Apply changes for the canonical format
	@terraform fmt

init: ## Create and update terraform initial files
	terraform init -backend-config="backend.tfvars"

plan: ## Generate an execution plan for Terraform
	terraform plan -out=tfplan

apply: ## Apply changes according to terraform execution plan
	terraform apply -input=false tfplan

destroy: ## Destroy terraform managed infrastructure
	terraform destroy

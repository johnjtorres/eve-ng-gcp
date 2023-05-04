.PHONY: eve destroy

.DEFAULT_GOAL = eve

eve:
	@terraform apply --auto-approve
	@terraform output --raw ip > inventory
	@ansible-playbook site.yml

destroy:
	@terraform destroy --auto-approve

remake: destroy eve

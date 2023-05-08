.PHONY: eve destroy backup

.DEFAULT_GOAL = eve

eve:
	@terraform apply --auto-approve
	@ansible-playbook playbooks/site.yml

backup:
	@ansible-playbook playbooks/backup_labs.yml

destroy: backup
	@terraform destroy --auto-approve

remake: destroy eve

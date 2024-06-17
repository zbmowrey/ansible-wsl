help:
    @echo "Just Setup ==================================="
    @echo "  start: Create variables.yml file"
    @echo "  facts: Run config-facts.yml playbook"
    @echo "  build: Run build.yml playbook"

build:
    ansible-playbook -i config-hosts.yml build.yml

facts:
    ansible-playbook -i config-hosts.yml config-facts.yml

start:
    cp variables.example.yml variables.yml
    @echo "variables.yml created. Please edit it to match your environment."

laravel:
    ansible-playbook -i config-hosts.yml laravel.yml
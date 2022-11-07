#!/bin/sh

/usr/sbin/sshd
cd /app

. ./venv_ansible/bin/activate
ansible-playbook update_db_endpoint.yaml
ansible-playbook create_table.yaml
deactivate

. ./venv_app/bin/activate
python manage.py db init
python manage.py db migrate
python manage.py db upgrade

python manage.py runserver --host=0.0.0.0

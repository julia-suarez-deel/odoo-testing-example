export PGPASSWORD:=odoo
up:
	docker-compose up -d

down:
	docker-compose down

addon_scaffold:
	docker exec -it --user root plusteam-odoo-web /usr/bin/odoo scaffold $(ADDON_NAME) /mnt/extra-addons

rebuild:
	docker-compose down
	docker-compose up -d --build

generate_local_coverage_report:
	docker exec -it plusteam-odoo-web pytest -s --odoo-database=db_test --html=/coverage/local/report.html /mnt/extra-addons/
	docker cp plusteam-odoo-web:/coverage/local coverage

generate_coverage_report:
	-docker exec -it -u root plusteam-odoo-web coverage run /usr/bin/odoo -d db_test --test-enable -p 8001 --stop-after-init --log-level=test
	docker exec -it -u root plusteam-odoo-web coverage html -d /coverage/all
	docker cp plusteam-odoo-web:/coverage/all coverage

init_test_db:
	docker stop plusteam-odoo-web
	docker exec -t plusteam-odoo-db psql -U odoo -d postgres -c "DROP DATABASE IF EXISTS db_test"
	docker exec -t plusteam-odoo-db psql -U odoo -d postgres -c "CREATE DATABASE db_test"
	docker start plusteam-odoo-web
	docker exec -u root -t plusteam-odoo-web odoo -i all -d db_test --stop-after-init
	docker exec -u root -t plusteam-odoo-web odoo -i plus_poc -d db_test --stop-after-init

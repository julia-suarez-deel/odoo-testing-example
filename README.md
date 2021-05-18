# Tutorial to run odoo tests in a docker container with Pycharm
In this repository you will find examples and commands to use docker compose file to set up an odoo instance since this can speed up development. You can read the detailed tutorial here.

## Commands

### up
Shortcut for `docker-compose up -d` (Create/start containers specified in the `docker-compose.yml`)

### down
Shortcut for `docker-compose down` (Remove containers created from the `docker-compose.yml` file)

### addon_scaffold
Command to create a new odoo addon scaffold, example:
```shell
> make addon_scaffold ADDON_NAME=my_module
```

### rebuild
Removes the existing containers and force the rebuild of the ones specified in the `docker-compose.yml` file.

### generate_local_coverage_report
Run all tests available in the `/addon` directory with `pytest` and generates coverage html reports in the `coverage/local` directory, make sure you have the test database set up with the command `make init_test_db`

### generate_coverage_report
Run all tests including the ones available in the `odoo` binary using the `coverage` python package, also generates an html coverage report that will be available in the `coverage/all` directory.

### init_test_db
Initializes or recreates the test database with the name: `db_test`, it also initializes all the addons in new database including the example addon `plus_poc` available in the `addons` folder.
# build container
docker-compose build

# start app; run all containers
docker-compose up

# stop app; terminate all containers
docker-compose down

# run tests
docker-compose run --rm app sh -c "python manage.py test"

# make migrations
docker-compose run --rm app sh -c "python manage.py makemigrations"

# migrate
docker-compose run --rm app sh -c "python manage.py wait_for_db && python manage.py migrate"

# delete DB
docker volume rm recipe-app-api_dev-db-data
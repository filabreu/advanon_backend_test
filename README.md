# Advanon Backend Test

### Dependencies

The application was configured with Docker.
To run the application, you must first install Docker.

https://www.docker.com/community-edition#/download

All other dependencies will be handled by Docker.

### Building the application

Use Docker to build the application.

On the root folder of the application run:

```
docker-compose build
```

This might take a while, as it will install all dependencies into the container, including Ruby, PostgreSQL, gems and front-end dependencies.

After the container is built, you must generate the database:

```
docker-compose run app rake db:setup
```

Now you are ready to run the application

### Running the application

To run the application, use Docker again:

```
docker-compose up
```

It will start the database instance and the application server on development mode.

Access the application on `http://localhost:3000`

### Running commands and tests

If you want to run commands, as `rails c` or tests, use Docker again:

To run the console:

```
docker-compose run app rails c
```

To run tests:

```
docker-compose run app rspec
```

To run any other command:

```
docker-compose run app <command>
```

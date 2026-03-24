# Billing

## Prerequisites
```
cp .env.example .env

Should change host to DB_HOST=billing_db
```

## Installation

1. Run docker
```
sh run.sh build
```

2. Create the first Admin account
```
Visit http://localhost:8888/setup --> Accept the terms and Continue --> Continue --> Click the Green button --> Create your account
```

## Note:
Available commands:

`sh run.sh build`: Build entire environment initially

`sh run.sh rebuild`: Rebuild containers and resources

`sh run.sh down`: Bring down all running containers

`sh run.sh migrate`: Migrate and seed database table and data

`sh run.sh rollback`: Rollback the migration

`sh run.sh`: Bring the existing containers
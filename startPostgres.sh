#!/bin/bash

docker run --name linux_dutt_db -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword postgres

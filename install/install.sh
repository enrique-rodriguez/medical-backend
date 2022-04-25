#!/bin/bash

REQUIRED="git pipenv npm"
MEDICAL_DIR="medical-backend"
MEDICAL_BACKEND_REMOTE="https://github.com/enrique-rodriguez/medical-backend"
MEDICAL_FRONTEND_REMOTE="https://github.com/enrique-rodriguez/medical-frontend"


abort() {
    printf "\e[31m$1\e[0m\n"
    exit
}

if [ -z "${BASH_VERSION:-}" ]
then
    abort "Bash is required to interpret this script."
fi


for CMD in $REQUIRED
do
    if ! hash $CMD
    then
        abort "$CMD is required to install project."
    fi
done


mkdir "$MEDICAL_DIR" && cd "$MEDICAL_DIR"
git clone "$MEDICAL_BACKEND_REMOTE" .
cd "$MEDICAL_DIR"

pipenv install
pipenv run setup

cd frontend

git clone "$MEDICAL_FRONTEND_REMOTE" .

npm install

npm run build
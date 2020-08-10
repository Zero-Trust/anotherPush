#!/bin/bash


# (Execute inside a Docker Container)

UPLOAD_FILE="$1"
GITHUB_USERNAME="$2"
GITHUB_REPO="$3"
USER_EMAIL="$4"

# Setup git repository
git config --global user.name "${GITHUB_USERNAME}"
git config --global user.email "${USER_EMAIL}"

# Clone 
git clone "https://${API_TOKEN_GITHUB}@github.com/${GITHUB_USERNAME}/${GITHUB_REPO}.git" ${UPLOAD_FILE}

mv "${UPLOAD_FILE}" "${GITHUB_REPO}/${UPLOAD_FILE}"
git add "${GITHUB_REPO}/${UPLOAD_FILE}"
git commit --message "Upload from https://github.com/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA} by GitHub Actions"
git push origin master



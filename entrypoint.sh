#!/bin/bash


# (Execute inside a Docker Container)
# ==================================
UPLOAD_FILE="$1"
GITHUB_USERNAME="$2"
GITHUB_REPO="$3"
USER_EMAIL="$4"

REMOTE_REPO="git@github.com:${GITHUB_USERNAME}/${GITHUB_REPO}.git"
PARENTDIR="${GITHUB_REPO}/Notes"
# ==================================


# SSH Configuration ================
# deploy_key="~/deploy_key.pem"
# GIT_SSH_COMMAND="ssh -i ${deploy_key} -o StrictHostKeyChecking=no -F /dev/null"
# 
# echo "${GH_REPO_DEPLOY_KEY}" > "${deploy_key}"
# chmod 600 "${deploy_key}"
# ==================================


# Setup Git Repository =============
git clone "https://${API_TOKEN_GITHUB}@github.com/${GITHUB_USERNAME}/${GITHUB_REPO}.git"
cd ${GITHUB_REPO}/
git config --global user.name "${GITHUB_USERNAME}"
git config --global user.email "${USER_EMAIL}"
git config remote.origin.url "${REMOTE_REPO}"
git checkout master
# ==================================


# Get file =========================
touch ${UPLOAD_FILE}
cat > ${UPLOAD_FILE} << EOF
<html>
<head>
<title>Document</title>
</head>
<body>
This is test.
</body>
</html>
EOF
# ==================================


# Commit to Another Repository =====
if [ -e "./${UPLOAD_FILE}" ]; then
    mkdir -p "${PARENTDIR}" && cd ${PARENTDIR}
    mv "${UPLOAD_FILE}" "${PARENTDIR}/${UPLOAD_FILE}"
    
    git add "${GITHUB_REPO}/${UPLOAD_FILE}"
    if ! git diff --cached --quiet; then
      git commit -m "Upload from https://github.com/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA} by GitHub Actions"
      git push origin master
    fi
else
	echo "No such file: ./${UPLOAD_FILE}"
fi
# ==================================



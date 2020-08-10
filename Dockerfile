FROM gentoo/stage3-amd64:latest

RUN emerge --sync && emerge dev-vcs/git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]



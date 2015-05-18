FROM node:0.10-onbuild
EXPOSE 8080
ENTRYPOINT bin/hubot -a irc -n steward

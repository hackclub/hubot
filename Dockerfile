FROM node:4.2.1-onbuild
EXPOSE 8080
ENTRYPOINT bin/hubot -a slack

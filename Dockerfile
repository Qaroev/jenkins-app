FROM node:10.13.0-alpine
ENV teever=TEEVER
ENV buildNumber=BUILD_NUMBER
ENV branchName=BRANCH
COPY package*.json ./
RUN npm set progress=false && npm config set depth 0 && npm cache clean --force
# Storing node modules on a separate layer will prevent unnecessary npm installs at each build
RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app
WORKDIR /ng-app
COPY . .
RUN npm run build
RUN npm run copy
RUN npm run zipdist

FROM node:12.10

WORKDIR /usr/src/app

COPY . .

RUN yarn
RUN yarn build

CMD yarn start
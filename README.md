# gcloud-run-express-vue

> Nuxt.js App running on Google Cloud Run

[![Run on Google Cloud](https://storage.googleapis.com/cloudrun/button.svg)](https://console.cloud.google.com/cloudshell/editor?shellonly=true&cloudshell_image=gcr.io/cloudrun/button&cloudshell_git_repo=https://github.com/ejangi/gcloud-run-express-vue.git)

For detailed explanation on how things work, check out [Nuxt.js docs](https://nuxtjs.org).

## Local Development

``` bash
docker-compose build
docker-compose up
```

## Push to Google Cloud Run

``` bash
docker build -t gcr.io/<project id>/gcloud-run-express-vue:v1 . --build-arg NODE_ENV=production

docker push gcr.io/<project id>/gcloud-run-express-vue:v1

gcloud beta run deploy gcloud-run-express-vue --image gcr.io/<project id>/gcloud-run-express-vue:v1 --platform managed --region asia-northeast1  --allow-unauthenticated 
```

## How this project was created

### 1. Create a `Dockerfile` and `docker-compose.yml` file

``` Dockerfile
FROM node:12.10

WORKDIR /usr/src/app
```

``` yaml
version: '3'

services:
  app:
    build: 
      context: .
    volumes:
      - .:/usr/src/app
    ports:
      - 8080:8080
    command: bash
```

### 2. Run the container and get bash prompt

``` bash
docker-compose exec app bash
```

### 3. Install dependencies

``` bash
yarn init
yarn add nuxt
yarn global add create-nuxt-app
```

### 4. Run the `create-nuxt` command

``` bash
cd ../
yarn create-nuxt-app app
```

### 5. Update `Dockerfile` for production and `docker-compose.yml` for dev

``` dockerfile
FROM node:12.10

WORKDIR /usr/src/app

COPY . .

RUN yarn
RUN yarn build

CMD yarn start
```

``` yaml
version: '3'

services:
  app:
    build: 
      context: .
    volumes:
      - .:/usr/src/app
    ports:
      - 8080:8080
    command: yarn dev
```

### 6. Add PORT environment variable support to `nuxt.config.js`

``` javascript
server: {
    host: '0.0.0.0',
    port: process.env.PORT || 8080
}
```


## Build Setup (from within the container)

``` bash
# install dependencies
$ yarn install

# serve with hot reload at localhost:3000
$ yarn dev

# build for production and launch server
$ yarn build
$ yarn start

# generate static project
$ yarn generate
```
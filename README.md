# gcloud-run-express-vue

> Nuxt.js App running on Google Cloud Run

## Build Setup

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

For detailed explanation on how things work, check out [Nuxt.js docs](https://nuxtjs.org).

## How this project was created

### 1. Create a `Dockerfile` and `docker-compose.yml` file

```
FROM node:12.10

WORKDIR /usr/src/app
```

```
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

```
docker-compose exec app bash
```

### 3. Install dependencies

```
yarn init
yarn add nuxt
yarn global add create-nuxt-app
```

### 4. Run the `create-nuxt` command

```
cd ../
yarn create-nuxt-app app
```

### 5. Update `Dockerfile` for production and `docker-compose.yml` for dev

```
FROM node:12.10

WORKDIR /usr/src/app

COPY . .

RUN yarn
RUN yarn build

CMD yarn start
```

```
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

```
server: {
    host: '0.0.0.0',
    port: process.env.PORT || 8080
}
```
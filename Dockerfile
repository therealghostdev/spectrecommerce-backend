
FROM node:22-alpine

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci --include=dev

COPY . .

RUN DATABASE_URL="postgresql://build:build@localhost:5432/build" npx prisma generate

RUN npx tsc

ENV NODE_ENV=production

# RUN npm prune --omit=dev

EXPOSE 3000

CMD ["npm", "start"]

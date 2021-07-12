DROP TABLE users;
CREATE TABLE users(
  id SERIAL NOT NULL UNIQUE,
  firstname VARCHAR(64) NOT NULL CHECK (firstname != ''),
  lastname VARCHAR(64) NOT NULL CHECK (lastname != ''),
  email VARCHAR(256) NOT NULL CHECK (email != ''),
  is_male BOOLEAN NOT NULL,
  birthday DATE NOT NULL CHECK (birthday < CURRENT_DATE),
  height NUMERIC(3, 2) NOT NULL CHECK (
    height > 0.2
    AND height < 3
  )
);
ALTER TABLE "users"
ADD "weight" NUMERIC (5, 2) NOT NULL CHECK ("weight">0 AND "weight" < 500);

INSERT INTO users (
    firstname,
    lastname,
    email,
    is_male,
    birthday,
    height
  )
VALUES (
    'Test',
    'Testovich',
    'test@mail.com',
    TRUE,
    '1990-01-01',
    1.6
  );
INSERT INTO users (
    firstname,
    lastname,
    email,
    is_male,
    birthday,
    height
  )
VALUES (
    'Ivan',
    'Ivanov',
    'test2@gmail.com',
    'TRUE',
    '1995-05-25',
    1.5
  );
  DROP TABLE IF EXISTS "messages";
CREATE TABLE "messages" (
  "id" BIGSERIAL PRIMARY KEY,
  "body" VARCHAR(2000) NOT NULL CHECK ("body" != ''),
  "author_id" BIGINT NOT NULL,
  "createdAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_read" BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY ("chat_id", "author_id") REFERENCES "users_to_chats" ("chat_id", "user_id")
);

DROP TABLE IF EXISTS "products";
CREATE TABLE "products"(
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR (256) NOT NULL CHECK ("name" != ''),
  "category" VARCHAR(128) NOT NULL CHECK ("category" != ''),
  "quantity" INTEGER NOT NULL CHECK ("quantity" > 0),
  UNIQUE ("name", "category")
);
/* */

DROP TABLE IF EXISTS "orders";
CREATE TABLE "orders" (
  "id" BIGSERIAL PRIMARY KEY,
  "customer_id" INTEGER NOT NULL CHECK ("customer_id" > 0),
  "is_done" BOOLEAN,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS "products_to_orders";
CREATE TABLE "products_to_orders" (
  "order_id" BIGINT REFERENCES "orders" ("id"),
  "product_id" INTEGER REFERENCES "products" ("id"),
  "quantity" INTEGER CHECK ("quantity" > 0)
);
/* */
DROP TABLE IF EXISTS "chats";
CREATE TABLE "chats" (
  "id" BIGSERIAL PRIMARY KEY,
  "owner_id" INTEGER NOT NULL REFERENCES "users" ("id"),
  "chat_name" VARCHAR(100) NOT NULL CHECK ("chat_name"!=''), 
  "description" VARCHAR (512) CHECK ("description"!='') 
  );
/* */
CREATE TABLE "users_to_chats" (
  "chat_id" BIGINT REFERENCES "chats"("id"),
  "user_id" INTEGER REFERENCES "users" ("id"),
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("chat_id", "user_id")
);

/* */
DROP TABLE IF EXISTS "content";
CREATE TABLE "content"(
  "content_id" SERIAL PRIMARY KEY,
  "owner_id" INTEGER NOT NULL REFERENCES "users" ("id"),
  "name" VARCHAR (255) NOT NULL CHECK ("name" !=''),
  "description" TEXT 
);

CREATE TABLE "reaction_to_content"(
  "user_id" INTEGER REFERENCES "users" ("id"),
  "content_id" INTEGER REFERENCES "content" ("content_id"),
  "isLiked" BOOLEAN DEFAULT FALSE,
  PRIMARY KEY ("content_id", "user_id")
);

 

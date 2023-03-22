CREATE SEQUENCE IF NOT EXISTS product_id_seq START 1;
CREATE SEQUENCE IF NOT EXISTS user_marketplace_id_seq START 1;
CREATE SEQUENCE IF NOT EXISTS cart_id_seq START 1;
CREATE SEQUENCE IF NOT EXISTS cart_item_id_seq START 1;
CREATE SEQUENCE IF NOT EXISTS order_id_seq START 1;
CREATE SEQUENCE IF NOT EXISTS order_item_id_seq START 1;

CREATE TABLE IF NOT EXISTS products
(
    id          BIGINT
        CONSTRAINT product_pkey PRIMARY KEY
        DEFAULT nextval('product_id_seq'),
    name        VARCHAR(255)   NOT NULL,
    description TEXT           NOT NULL,
    price       DECIMAL(10, 2) NOT NULL,
    image_url   VARCHAR(255)   NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS users
(
    id           BIGINT
        CONSTRAINT users_pkey PRIMARY KEY
        DEFAULT nextval('user_marketplace_id_seq'),
    username     VARCHAR(50)  NOT NULL
        CONSTRAINT uk_username UNIQUE,
    name         VARCHAR(255) NOT NULL,
    email        VARCHAR(255) NOT NULL
        CONSTRAINT uk_email UNIQUE,
    password     VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL
        CONSTRAINT uk_phone_number UNIQUE,
    role         VARCHAR(255) NOT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS carts
(
    id         BIGINT
        CONSTRAINT carts_pkey PRIMARY KEY
        DEFAULT nextval('cart_id_seq'),
    user_id    BIGINT NOT NULL
        CONSTRAINT fk_user_id REFERENCES users,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cart_items
(
    id         BIGINT
        CONSTRAINT cart_items_pkey PRIMARY KEY
        DEFAULT nextval('cart_item_id_seq'),
    cart_id    BIGINT NOT NULL
        CONSTRAINT fk_cart_id REFERENCES carts,
    product_id BIGINT NOT NULL
        CONSTRAINT fk_product_id REFERENCES products,
    quantity   BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_cart_id_product_id
        UNIQUE (cart_id, product_id)
);

CREATE TABLE IF NOT EXISTS orders
(
    id         BIGINT
        CONSTRAINT orders_pkey PRIMARY KEY
        DEFAULT nextval('order_id_seq'),
    user_id    BIGINT      NOT NULL
        CONSTRAINT fk_user_id REFERENCES users,
    status     VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items
(
    id           BIGINT
        CONSTRAINT order_items_pkey PRIMARY KEY
        DEFAULT nextval('order_item_id_seq'),
    order_id     BIGINT         NOT NULL
        CONSTRAINT fk_orders_id REFERENCES orders,
    cart_item_id BIGINT         NOT NULL
        CONSTRAINT fk_cart_item_id REFERENCES cart_items,
    price        DECIMAL(10, 2) NOT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO products (name, description, price, image_url, created_at, updated_at)
VALUES ('Bread - Crumbs, Bulk', 'Sacral spina bifida without hydrocephalus', 208.59,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.',
        '2021-02-28 17:34:42', '2023-01-23 05:29:38'),
       ('Wine - White, Lindemans Bin 95', 'Spontaneous rupture of extensor tendons, left lower leg', 79.05,
        'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.',
        '2021-06-16 04:03:06', '2022-11-23 21:06:36'),
       ('Lumpfish Black', 'Lacerat unsp musc/fasc/tend at wrs/hnd lv, r hand, sequela', 702.02,
        'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo.',
        '2021-03-30 21:25:11', '2022-02-27 07:30:33'),
       ('Salmon Steak - Cohoe 6 Oz', 'Unspecified dislocation of right patella', 102.27,
        'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.',
        '2021-12-25 08:57:21', '2022-12-29 12:09:43'),
       ('Energy Drink - Franks Pineapple', 'Oth place in nursing home as place', 938.5,
        'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', '2021-05-26 17:20:35',
        '2022-09-06 21:36:28');

INSERT INTO users (username, name, email, password, phone_number, role, created_at, updated_at)
VALUES ('sdamiral0', 'Sibyl Damiral', 'sdamiral0@noaa.gov', 'X8yAGaqFbGKs', '3106452576', 'ROLE_ADMIN',
        '2021-12-03 13:41:55', '2022-04-08 22:08:12'),
       ('bmc1', 'Berry Mc Curlye', 'bmc1@unblog.fr', '3GMoGb', '6113296723', 'ROLE_USER', '2021-08-13 19:26:37',
        '2022-10-20 18:43:10'),
       ('egreser2', 'Eugenio Greser', 'egreser2@tinypic.com', 'lA2gPG', '3836407895', 'ROLE_USER',
        '2021-05-22 02:44:47', '2022-05-10 05:26:59'),
       ('lsharple3', 'Larissa Sharple', 'lsharple3@tiny.cc', '3yQ2uZmCRu', '6194018373', 'ROLE_USER',
        '2021-11-13 12:21:08', '2022-09-25 06:08:58'),
       ('pforker4', 'Pam Forker', 'pforker4@fotki.com', 'wAaFHb1mc7', '6144030837', 'ROLE_USER', '2021-03-03 04:42:58',
        '2023-01-21 03:35:56');


INSERT INTO carts (user_id, created_at, updated_at)
VALUES (2, '2021-12-03 13:41:55', '2022-04-08 22:08:12'),
       (3, '2021-08-13 19:26:37', '2022-10-20 18:43:10'),
       (3, '2021-05-22 02:44:47', '2022-05-10 05:26:59'),
       (2, '2021-11-13 12:21:08', '2022-09-25 06:08:58'),
       (4, '2021-03-03 04:42:58', '2023-01-21 03:35:56');


INSERT INTO cart_items (cart_id, product_id, quantity, created_at, updated_at)
VALUES (1, 2, 3, '2021-12-03 13:41:55', '2022-04-08 22:08:12'),
       (1, 3, 4, '2021-08-13 19:26:37', '2022-10-20 18:43:10'),
       (2, 1, 4, '2021-08-13 19:26:37', '2022-10-20 18:43:10'),
       (3, 4, 4, '2021-08-13 19:26:37', '2022-10-20 18:43:10'),
       (4, 5, 4, '2021-08-13 19:26:37', '2022-10-20 18:43:10');

INSERT INTO orders (user_id, status, created_at, updated_at)
VALUES (2, 'PENDING', '2021-12-03 13:41:55', '2022-04-08 22:08:12'),
       (3, 'PENDING', '2021-12-03 13:41:55', '2022-04-08 22:08:12'),
       (4, 'PENDING', '2021-12-03 13:41:55', '2022-04-08 22:08:12'),
       (2, 'SHIPPED', '2021-12-03 13:41:55', '2022-04-08 22:08:12'),
       (5, 'PENDING', '2021-12-03 13:41:55', '2022-04-08 22:08:12');


INSERT INTO order_items (order_id, cart_item_id, price, created_at, updated_at)
VALUES (1, 1, 1000.23, '2021-12-03 13:41:55', '2022-04-08 22:08:12'),
       (2, 2, 50.23, '2021-12-03 13:41:55', '2022-04-08 22:08:12'),
       (3, 3, 252.23, '2021-12-03 13:41:55', '2022-04-08 22:08:12'),
       (3, 4, 231.99, '2021-12-03 13:41:55', '2022-04-08 22:08:12'),
       (5, 4, 199.11, '2021-12-03 13:41:55', '2022-04-08 22:08:12');


drop table if exists developer
CREATE TABLE developer (
    developer_id varchar(10)
  , developer varchar(100) NOT NULL
  , developer_link varchar(100) NOT NULL
  , icon varchar(500) NOT NULL
  , PRIMARY KEY (developer_id)
);

drop table if exists app_info
CREATE TABLE app_info (
    app_id char(36),
	developer_id varchar(10) NOT NULL,
	review_id varchar(10) NOT NULL UNIQUE,
	PRIMARY KEY (app_id),
	FOREIGN KEY (developer_id) references developer (developer_id)
);

drop table if exists reviews
CREATE TABLE reviews (
    review_id varchar(10)
  , rating numeric(2,1) NOT NULL
  , reviews_count integer NOT NULL
  , PRIMARY KEY (review_id)
  , FOREIGN KEY (review_id) references app_info (review_id)
);

drop table if exists apps_urls
CREATE TABLE apps_urls (
    app_id char(36),
	url varchar(200) NOT NULL,
	PRIMARY KEY (app_id),
	FOREIGN KEY (app_id) references app_info (app_id)
);

drop table if exists titles
CREATE TABLE titles (
    category_id  char(36)
  , title varchar(50) NOT NULL 
  , PRIMARY KEY (category_id)
);

drop table if exists categories
CREATE TABLE categories ( 
	app_id char(36),
    category_id char(36) NOT NULL, 
    PRIMARY KEY (app_id,category_id),
    FOREIGN KEY (app_id) references app_info (app_id),
	FOREIGN KEY (category_id) references titles (category_id)
);

drop table if exists app_descriptions 
CREATE TABLE app_descriptions (
    app_id char(36)
  , description_raw  varchar
  , description varchar
  , tagline varchar
  , PRIMARY KEY (app_id)
  , FOREIGN KEY (app_id) references app_info (app_id)
);

drop table if exists pricing_advantages
CREATE TABLE pricing_advantages (
    app_id char(36)
  , pricing_hint  integer 
  , PRIMARY KEY (app_id)
  , FOREIGN KEY (app_id) references app_info (app_id)
);

drop table if exists feature_descriptions
CREATE TABLE feature_descriptions (
	id varchar(10),
    app_id char(36)
  , title varchar(50) NOT NULL
  , description  varchar(500) 
  , PRIMARY KEY (id)
  , FOREIGN KEY (app_id) references app_info (app_id)
);

drop table if exists author_info
CREATE TABLE author_info(
	author_id varchar(10),
	author varchar NOT NULL, 
	PRIMARY KEY (author_id)
);

drop table if exists author_review_info
CREATE TABLE author_review_info (
	author_review_id varchar(10),
	app_id char(36) NOT NULL,
    author_id varchar(10) NOT NULL,
	PRIMARY KEY (author_review_id),
	FOREIGN KEY (app_id) references app_info (app_id),
	FOREIGN KEY (author_id) references author_info (author_id)
);

drop table if exists author_reviews
CREATE TABLE author_reviews(
	author_review_id varchar(10),
	rating int,
	posted_at timestamp,
	body varchar,
	helpful_count int,
	PRIMARY KEY (author_review_id),
	FOREIGN KEY (author_review_id) references author_review_info (author_review_id)
);

drop table if exists developer_review_info
CREATE TABLE developer_review_info (
	developer_review_id varchar(10),
	app_id char(36),
	PRIMARY KEY (developer_review_id),
	FOREIGN KEY (app_id) references app_info (app_id)
);

drop table if exists developer_reviews
CREATE TABLE developer_reviews(
	developer_review_id varchar(10),
	developer_reply varchar(200) NOT NULL,
	developer_reply_posted_at varchar NOT NULL,
	PRIMARY KEY (developer_review_id)
  , FOREIGN KEY (developer_review_id) references developer_review_info (developer_review_id)
);

drop table if exists app_price
CREATE TABLE app_price(
	id char(36),
	app_id char(36), 
	title varchar(50),
	price numeric NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (app_id) references app_info (app_id)
);




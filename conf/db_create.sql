-- File: db_create.sql
-- Date: 2013-05-02
-- Author: SivaCoHan

SET client_min_messages=ERROR;

--本地用户表
DROP TABLE IF EXISTS local_users;
CREATE TABLE local_users(
    id          SERIAL8 NOT NULL,
    username    VARCHAR(20) UNIQUE,
    passhash    VARCHAR(40),
    PRIMARY KEY(id)
);

--外部用户表

DROP TABLE IF EXISTS other_users;
CREATE TABLE other_users(
    id          SERIAL8 NOT NULL,
    token       VARCHAR(40) NOT NULL,
    PRIMARY KEY(id)
);

--全局用户表

DROP TABLE IF EXISTS global_users;
CREATE TABLE global_users(
    id          SERIAL8 NOT NULL,
    user_id     INT8 NOT NULL,
    user_from   VARCHAR(10) NOT NULL,
    PRIMARY KEY(id)
);

--用户角色

DROP TABLE IF EXISTS user_role;
CREATE TABLE user_role(
    user_id     INT8,
    role        VARCHAR(16),
    extra       VARCHAR(255),
    UNIQUE(user_id,role)
);

--标签类型

DROP TABLE IF EXISTS tagtype;
CREATE TABLE tagtype(
    id          SERIAL8 NOT NULL,
    tagname     VARCHAR(200) UNIQUE,
    dt_create   TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY(id)
);

--标签值

DROP TABLE IF EXISTS tagvalue;
CREATE TABLE tagvalue(
    id          SERIAL8 NOT NULL,
    user_id     INT8    NOT NULL,
    tagtype_id  INT8,
    value       TEXT,
    dt_create   TIMESTAMP DEFAULT NOW(),
    UNIQUE(tagtype_id,value),           --在考虑要不要再加上user_id
    PRIMARY KEY(id)
);

--标签关系

DROP TABLE IF EXISTS tagrelation;
CREATE TABLE tagrelation(
    tagvalue_id     INT8,
    tagtype_id      INT8,
    relation        VARCHAR(16),
    UNIQUE(tagvalue_id,tagtype_id)
);

--用户信息

DROP TABLE IF EXISTS usertag;
CREATE TABLE usertag(
    user_id         INT8,
    tagvalue_id     INT8,
    UNIQUE(user_id,tagvalue_id)
);

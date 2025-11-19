CREATE TABLE "user" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "email" varchar,
  "password" varchar,
  "created_at" datetime
);

CREATE TABLE "token" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "description" varchar,
  "user_id" integer,
  "permission_id" integer,
  "created_at" datetime,
  "expires_at" datetime
);

CREATE TABLE "repository" (
  "id" integer PRIMARY KEY,
  "owner_id" integer,
  "name" varchar,
  "provider" varchar,
  "connected_at" datetime
);

CREATE TABLE "merge_request" (
  "id" integer PRIMARY KEY,
  "author_id" varchar,
  "repository_id" integer,
  "request_id" varchar,
  "title" varchar,
  "thread_id" integer,
  "created_at" datetime,
  "merged_at" datetime,
  "status_id" varchar
);

CREATE TABLE "permission_type" (
  "id" integer PRIMARY KEY,
  "type" varchar
);

CREATE TABLE "merge_request_status" (
  "id" integer PRIMARY KEY,
  "status" varchar
);

CREATE TABLE "thread" (
  "id" integer PRIMARY KEY,
  "text" varchar,
  "author_id" integer,
  "created_at" timestamp
);

CREATE TABLE "commit" (
  "id" integer PRIMARY KEY,
  "author_id" integer,
  "hash" varchar,
  "repository_id" integer,
  "message" text,
  "created_at" datetime
);

CREATE TABLE "file_change" (
  "id" integer PRIMARY KEY,
  "merge_request_id" integer,
  "file_path" varchar,
  "change_type" varchar,
  "lines_added" integer,
  "lines_deleted" integer
);

CREATE TABLE "code_review" (
  "id" integer PRIMARY KEY,
  "reviewer_id" integer,
  "merge_request_id" integer,
  "status_id" integer,
  "submitted_at" datetime
);

CREATE TABLE "repository_member" (
  "id" integer PRIMARY KEY,
  "user_id" integer,
  "repository_id" integer,
  "role_id" integer,
  "joined_at" datetime
);

CREATE TABLE "review_status" (
  "id" integer PRIMARY KEY
);

CREATE TABLE "member_role" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "permission_id" integer
);

CREATE TABLE "member_role_permission_type" (
  "id" integer PRIMARY KEY,
  "permission_id" integer,
  "member_role" integer
);

ALTER TABLE "token" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "token" ADD FOREIGN KEY ("permission_id") REFERENCES "permission_type" ("id");

ALTER TABLE "repository" ADD FOREIGN KEY ("owner_id") REFERENCES "user" ("id");

ALTER TABLE "merge_request" ADD FOREIGN KEY ("repository_id") REFERENCES "repository" ("id");

ALTER TABLE "merge_request" ADD FOREIGN KEY ("author_id") REFERENCES "user" ("id");

ALTER TABLE "merge_request" ADD FOREIGN KEY ("thread_id") REFERENCES "thread" ("id");

ALTER TABLE "merge_request" ADD FOREIGN KEY ("status_id") REFERENCES "merge_request_status" ("id");

ALTER TABLE "thread" ADD FOREIGN KEY ("author_id") REFERENCES "user" ("id");

ALTER TABLE "commit" ADD FOREIGN KEY ("author_id") REFERENCES "user" ("id");

ALTER TABLE "commit" ADD FOREIGN KEY ("repository_id") REFERENCES "repository" ("id");

ALTER TABLE "file_change" ADD FOREIGN KEY ("merge_request_id") REFERENCES "merge_request" ("id");

ALTER TABLE "code_review" ADD FOREIGN KEY ("merge_request_id") REFERENCES "merge_request" ("id");

ALTER TABLE "code_review" ADD FOREIGN KEY ("reviewer_id") REFERENCES "user" ("id");

ALTER TABLE "code_review" ADD FOREIGN KEY ("status_id") REFERENCES "review_status" ("id");

ALTER TABLE "repository_member" ADD FOREIGN KEY ("repository_id") REFERENCES "repository" ("id");

ALTER TABLE "repository_member" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "repository_member" ADD FOREIGN KEY ("role_id") REFERENCES "member_role" ("id");

ALTER TABLE "permission_type" ADD FOREIGN KEY ("id") REFERENCES "member_role_permission_type" ("permission_id");

ALTER TABLE "member_role" ADD FOREIGN KEY ("id") REFERENCES "member_role_permission_type" ("member_role");

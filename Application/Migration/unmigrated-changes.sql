-- This file is created by the IHP Schema Designer.
-- When you generate a new migration, all changes in this file will be copied into your migration.
--
-- Use http://localhost:8001/NewMigration or `new-migration` to generate a new migration.
--
-- Learn more about migrations: https://ihp.digitallyinduced.com/Guide/database-migrations.html
ALTER TABLE posts DROP COLUMN created_at;
ALTER TABLE posts ADD COLUMN created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL;
CREATE TABLE comments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    post_id UUID NOT NULL,
    author TEXT NOT NULL,
    body TEXT NOT NULL
);
CREATE INDEX comments_post_id_index ON comments (post_id);
ALTER TABLE comments ADD CONSTRAINT comments_ref_post_id FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE NO ACTION;

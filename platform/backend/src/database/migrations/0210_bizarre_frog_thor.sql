CREATE TYPE "public"."mcp_server_scope" AS ENUM('personal', 'team', 'org');--> statement-breakpoint
ALTER TABLE "mcp_server" ADD COLUMN "scope" "mcp_server_scope" DEFAULT 'personal' NOT NULL;--> statement-breakpoint
ALTER TABLE "mcp_server" ADD COLUMN "organization_id" text;--> statement-breakpoint
CREATE INDEX "mcp_server_scope_idx" ON "mcp_server" USING btree ("scope");--> statement-breakpoint
CREATE INDEX "mcp_server_organization_id_idx" ON "mcp_server" USING btree ("organization_id");--> statement-breakpoint
UPDATE "mcp_server" SET "scope" = 'team' WHERE "team_id" IS NOT NULL;--> statement-breakpoint
UPDATE "mcp_server" SET "organization_id" = "team"."organization_id" FROM "team" WHERE "mcp_server"."team_id" = "team"."id" AND "mcp_server"."organization_id" IS NULL;--> statement-breakpoint
UPDATE "mcp_server" SET "organization_id" = "member"."organization_id" FROM "member" WHERE "mcp_server"."owner_id" = "member"."user_id" AND "mcp_server"."organization_id" IS NULL;

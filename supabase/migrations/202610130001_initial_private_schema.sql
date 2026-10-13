-- LingoLive stage 1: schema only. No current data or API keys are copied.
-- Server-private tables: the public API cannot query this schema.
BEGIN;
CREATE SCHEMA IF NOT EXISTS app_private;
REVOKE ALL ON SCHEMA app_private FROM PUBLIC, anon, authenticated;
GRANT USAGE ON SCHEMA app_private TO service_role;
CREATE TABLE app_private."content_access" (
	"id" text PRIMARY KEY NOT NULL,
	"free" BIGINT DEFAULT 0 NOT NULL
);

ALTER TABLE app_private."content_access" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."content_access" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."hidden_samples" (
	"id" text PRIMARY KEY NOT NULL,
	"hidden_at" BIGINT NOT NULL
);

ALTER TABLE app_private."hidden_samples" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."hidden_samples" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."ielts_blocks" (
	"id" text PRIMARY KEY NOT NULL,
	"lesson_id" text NOT NULL,
	"position" BIGINT NOT NULL,
	"kind" text NOT NULL,
	"body" text DEFAULT '' NOT NULL,
	"media_key" text,
	"mime_type" text,
	"created_at" BIGINT NOT NULL
);

ALTER TABLE app_private."ielts_blocks" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."ielts_blocks" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."ielts_progress" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"lesson_id" text NOT NULL,
	"completed_at" BIGINT NOT NULL
);

ALTER TABLE app_private."ielts_progress" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."ielts_progress" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."ielts_speaking_examples" (
	"id" text PRIMARY KEY NOT NULL,
	"category" text NOT NULL,
	"question" text NOT NULL,
	"cue" text DEFAULT '' NOT NULL,
	"answer" text NOT NULL,
	"translation" text DEFAULT '' NOT NULL,
	"audio_key" text,
	"mime_type" text,
	"status" text DEFAULT 'draft' NOT NULL,
	"created_at" BIGINT NOT NULL
, "kind" text DEFAULT 'listening' NOT NULL, "track" text DEFAULT '' NOT NULL, "questions" text DEFAULT '[]' NOT NULL, "vocabulary" text DEFAULT '' NOT NULL, "video_key" text, "video_mime_type" text, "video_url" text, "scroll_speed" BIGINT DEFAULT 32 NOT NULL, "cue_points" text DEFAULT '[]' NOT NULL, "description" text DEFAULT '' NOT NULL, "level" text DEFAULT 'Intermediate' NOT NULL, "band" text DEFAULT '' NOT NULL, "format" text DEFAULT 'audio' NOT NULL, "thumbnail_key" text, "pdf_key" text, "display_format" text DEFAULT 'landscape' NOT NULL);

ALTER TABLE app_private."ielts_speaking_examples" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."ielts_speaking_examples" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."learner_preferences" (
	"user_id" text PRIMARY KEY NOT NULL,
	"translation_language" text DEFAULT 'fa' NOT NULL
);

ALTER TABLE app_private."learner_preferences" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."learner_preferences" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."learner_profiles" (
	"user_id" text PRIMARY KEY NOT NULL,
	"email" text NOT NULL,
	"display_name" text NOT NULL,
	"country" text DEFAULT '' NOT NULL,
	"level" text DEFAULT '' NOT NULL,
	"purpose" text DEFAULT '' NOT NULL,
	"newsletter_consent" BIGINT DEFAULT 0 NOT NULL,
	"newsletter_consent_at" BIGINT,
	"completed_at" BIGINT,
	"created_at" BIGINT NOT NULL,
	"updated_at" BIGINT NOT NULL,
	"last_seen_at" BIGINT NOT NULL
, "is_pending" BIGINT DEFAULT 0 NOT NULL, "pending_email" text);

ALTER TABLE app_private."learner_profiles" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."learner_profiles" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."learning_daily" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"section" text NOT NULL,
	"lesson_id" text NOT NULL,
	"day" text NOT NULL,
	"active_seconds" BIGINT DEFAULT 0 NOT NULL
);

ALTER TABLE app_private."learning_daily" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."learning_daily" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."learning_progress" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"section" text NOT NULL,
	"lesson_id" text NOT NULL,
	"title" text NOT NULL,
	"href" text NOT NULL,
	"first_accessed_at" BIGINT NOT NULL,
	"last_accessed_at" BIGINT NOT NULL,
	"completed_at" BIGINT,
	"active_seconds" BIGINT DEFAULT 0 NOT NULL
, "resume_seconds" BIGINT DEFAULT 0 NOT NULL);

ALTER TABLE app_private."learning_progress" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."learning_progress" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."media_integrations" (
	"id" text PRIMARY KEY NOT NULL,
	"assembly_key" text DEFAULT '' NOT NULL,
	"google_key" text DEFAULT '' NOT NULL,
	"enabled" BIGINT DEFAULT 0 NOT NULL
, "youtube_client_id" text DEFAULT '' NOT NULL, "youtube_client_secret" text DEFAULT '' NOT NULL, "youtube_refresh_token" text DEFAULT '' NOT NULL, "translation_provider" text DEFAULT 'google' NOT NULL, "deepl_key" text DEFAULT '' NOT NULL, "deepl_plan" text DEFAULT 'free' NOT NULL, "azure_key" text DEFAULT '' NOT NULL, "azure_region" text DEFAULT '' NOT NULL);

ALTER TABLE app_private."media_integrations" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."media_integrations" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."media_transcripts" (
	"id" text PRIMARY KEY NOT NULL,
	"segments" text DEFAULT '[]' NOT NULL
);

ALTER TABLE app_private."media_transcripts" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."media_transcripts" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."memberships" (
	"user_id" text PRIMARY KEY NOT NULL,
	"expires_at" BIGINT NOT NULL,
	"subscription_id" text,
	"customer_id" text
);

ALTER TABLE app_private."memberships" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."memberships" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."payment_orders" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"provider" text NOT NULL,
	"plan" text NOT NULL,
	"amount" BIGINT NOT NULL,
	"currency" text NOT NULL,
	"provider_ref" text,
	"status" text DEFAULT 'pending' NOT NULL,
	"created_at" BIGINT NOT NULL,
	"paid_at" BIGINT,
	"expires_at" BIGINT
);

ALTER TABLE app_private."payment_orders" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."payment_orders" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."payment_settings" (
	"id" text PRIMARY KEY NOT NULL,
	"pricing_revision" BIGINT DEFAULT 0 NOT NULL,
	"iran_monthly" BIGINT DEFAULT 400000 NOT NULL,
	"iran_annual" BIGINT DEFAULT 1000000 NOT NULL,
	"international_monthly" BIGINT DEFAULT 0 NOT NULL,
	"international_annual" BIGINT DEFAULT 0 NOT NULL,
	"currency" text DEFAULT 'eur' NOT NULL,
	"iran_enabled" BIGINT DEFAULT 0 NOT NULL,
	"international_enabled" BIGINT DEFAULT 0 NOT NULL,
	"merchant_key" text DEFAULT '' NOT NULL,
	"stripe_key" text DEFAULT '' NOT NULL,
	"webhook_key" text DEFAULT '' NOT NULL
);

ALTER TABLE app_private."payment_settings" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."payment_settings" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."premium_grants" (
	"user_id" text PRIMARY KEY NOT NULL,
	"expires_at" BIGINT NOT NULL,
	"granted_by" text NOT NULL,
	"updated_at" BIGINT NOT NULL
);

ALTER TABLE app_private."premium_grants" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."premium_grants" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."quick_tip_lessons" (
	"id" text PRIMARY KEY NOT NULL,
	"category" text NOT NULL,
	"title" text NOT NULL,
	"body" text NOT NULL,
	"translation" text DEFAULT '' NOT NULL,
	"example" text DEFAULT '' NOT NULL,
	"example_translation" text DEFAULT '' NOT NULL,
	"audio_key" text,
	"mime_type" text,
	"status" text DEFAULT 'draft' NOT NULL,
	"created_at" BIGINT NOT NULL
);

ALTER TABLE app_private."quick_tip_lessons" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."quick_tip_lessons" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."reading_blocks" (
	"id" text PRIMARY KEY NOT NULL,
	"chapter_id" text NOT NULL,
	"position" BIGINT NOT NULL,
	"kind" text NOT NULL,
	"body" text DEFAULT '' NOT NULL,
	"media_key" text,
	"mime_type" text,
	"created_at" BIGINT NOT NULL
);

ALTER TABLE app_private."reading_blocks" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."reading_blocks" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."reading_chapters" (
	"id" text PRIMARY KEY NOT NULL,
	"item_id" text NOT NULL,
	"position" BIGINT NOT NULL,
	"title" text NOT NULL,
	"body" text NOT NULL,
	"created_at" BIGINT NOT NULL
, "translation" text DEFAULT '' NOT NULL);

ALTER TABLE app_private."reading_chapters" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."reading_chapters" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."reading_items" (
	"id" text PRIMARY KEY NOT NULL,
	"title" text NOT NULL,
	"description" text DEFAULT '' NOT NULL,
	"category" text NOT NULL,
	"level" text DEFAULT 'Beginner' NOT NULL,
	"status" text DEFAULT 'draft' NOT NULL,
	"created_at" BIGINT NOT NULL
, "document_key" text, "document_mime_type" text);

ALTER TABLE app_private."reading_items" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."reading_items" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."referral_codes" (
	"user_id" text PRIMARY KEY NOT NULL,
	"code" text NOT NULL,
	"created_at" BIGINT NOT NULL
);

ALTER TABLE app_private."referral_codes" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."referral_codes" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."referral_entitlements" (
	"user_id" text PRIMARY KEY NOT NULL,
	"milestones_granted" BIGINT DEFAULT 0 NOT NULL,
	"expires_at" BIGINT NOT NULL,
	"updated_at" BIGINT NOT NULL
);

ALTER TABLE app_private."referral_entitlements" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."referral_entitlements" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."referral_signups" (
	"invitee_user_id" text PRIMARY KEY NOT NULL,
	"inviter_user_id" text NOT NULL,
	"invitee_email" text NOT NULL,
	"created_at" BIGINT NOT NULL,
	"confirmed_at" BIGINT
);

ALTER TABLE app_private."referral_signups" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."referral_signups" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."routine_lessons" (
	"id" text PRIMARY KEY NOT NULL,
	"title" text NOT NULL,
	"phrase" text NOT NULL,
	"phrase_translation" text DEFAULT '' NOT NULL,
	"explanation" text NOT NULL,
	"example_one" text NOT NULL,
	"example_one_translation" text DEFAULT '' NOT NULL,
	"example_two" text NOT NULL,
	"example_two_translation" text DEFAULT '' NOT NULL,
	"body" text DEFAULT '' NOT NULL,
	"audio_key" text,
	"mime_type" text,
	"status" text DEFAULT 'draft' NOT NULL,
	"created_at" BIGINT NOT NULL
, "category" text DEFAULT 'daily-everyday' NOT NULL);

ALTER TABLE app_private."routine_lessons" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."routine_lessons" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."saved_routines" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"lesson_id" text NOT NULL,
	"created_at" BIGINT NOT NULL
);

ALTER TABLE app_private."saved_routines" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."saved_routines" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."saved_sentences" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"lesson_id" text NOT NULL,
	"lesson_title" text NOT NULL,
	"section" text NOT NULL,
	"start_ms" BIGINT NOT NULL,
	"english" text NOT NULL,
	"translation" text DEFAULT '' NOT NULL,
	"created_at" BIGINT NOT NULL
);

ALTER TABLE app_private."saved_sentences" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."saved_sentences" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."saved_vocabulary" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"word" text NOT NULL,
	"translation" text DEFAULT '' NOT NULL,
	"source_lesson_id" text NOT NULL,
	"created_at" BIGINT NOT NULL
, "translation_language" text DEFAULT 'fa' NOT NULL, "example_sentence" text DEFAULT '' NOT NULL, "lesson_title" text DEFAULT '' NOT NULL, "source_section" text DEFAULT '' NOT NULL);

ALTER TABLE app_private."saved_vocabulary" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."saved_vocabulary" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."speaking_recordings" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"lesson_id" text NOT NULL,
	"media_key" text NOT NULL,
	"mime_type" text NOT NULL,
	"created_at" BIGINT NOT NULL
, "title" text DEFAULT '' NOT NULL, "duration" BIGINT DEFAULT 0 NOT NULL);

ALTER TABLE app_private."speaking_recordings" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."speaking_recordings" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."support_messages" (
	"id" text PRIMARY KEY NOT NULL,
	"ticket_id" text NOT NULL,
	"author_id" text NOT NULL,
	"is_admin" BIGINT DEFAULT 0 NOT NULL,
	"body" text NOT NULL,
	"attachment_key" text DEFAULT '' NOT NULL,
	"attachment_type" text DEFAULT '' NOT NULL,
	"created_at" BIGINT NOT NULL
);

ALTER TABLE app_private."support_messages" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."support_messages" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."support_tickets" (
	"id" text PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"email" text NOT NULL,
	"name" text NOT NULL,
	"subject" text NOT NULL,
	"category" text NOT NULL,
	"priority" text DEFAULT 'normal' NOT NULL,
	"lesson_path" text DEFAULT '' NOT NULL,
	"status" text DEFAULT 'open' NOT NULL,
	"created_at" BIGINT NOT NULL,
	"updated_at" BIGINT NOT NULL
);

ALTER TABLE app_private."support_tickets" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."support_tickets" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."transcript_jobs" (
	"lesson_id" text PRIMARY KEY NOT NULL,
	"provider_id" text DEFAULT '' NOT NULL,
	"state" text NOT NULL,
	"languages" text DEFAULT '[]' NOT NULL,
	"segments" text DEFAULT '[]' NOT NULL,
	"cursor" BIGINT DEFAULT 0 NOT NULL,
	"error" text DEFAULT '' NOT NULL,
	"created_at" BIGINT NOT NULL
);

ALTER TABLE app_private."transcript_jobs" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."transcript_jobs" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."translation_cache" (
	"id" text PRIMARY KEY NOT NULL,
	"english" text NOT NULL,
	"language" text NOT NULL,
	"translation" text DEFAULT '' NOT NULL,
	"source" text DEFAULT 'provider' NOT NULL,
	"state" text DEFAULT 'pending' NOT NULL,
	"updated_at" BIGINT NOT NULL
);

ALTER TABLE app_private."translation_cache" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."translation_cache" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."translation_usage" (
	"id" text PRIMARY KEY NOT NULL,
	"count" BIGINT DEFAULT 0 NOT NULL,
	"characters" BIGINT DEFAULT 0 NOT NULL
);

ALTER TABLE app_private."translation_usage" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."translation_usage" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."user_admin_audit" (
	"id" text PRIMARY KEY NOT NULL,
	"actor_id" text NOT NULL,
	"target_id" text NOT NULL,
	"action" text NOT NULL,
	"expires_at" BIGINT,
	"created_at" BIGINT NOT NULL
);

ALTER TABLE app_private."user_admin_audit" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."user_admin_audit" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."video_categories" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"created_at" BIGINT NOT NULL
, "section" text DEFAULT 'video' NOT NULL, "parent_id" text);

ALTER TABLE app_private."video_categories" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."video_categories" FORCE ROW LEVEL SECURITY;

CREATE TABLE app_private."video_lessons" (
	"id" text PRIMARY KEY NOT NULL,
	"title" text NOT NULL,
	"description" text DEFAULT '' NOT NULL,
	"category" text NOT NULL,
	"level" text DEFAULT 'Beginner' NOT NULL,
	"tags" text DEFAULT '' NOT NULL,
	"media_key" text NOT NULL,
	"mime_type" text NOT NULL,
	"transcript" text DEFAULT '[]' NOT NULL,
	"status" text DEFAULT 'draft' NOT NULL,
	"created_at" BIGINT NOT NULL
, "content_kind" text DEFAULT 'video' NOT NULL, "source_url" text, "display_format" text DEFAULT 'landscape' NOT NULL, "transcription_key" text, "thumbnail_key" text, "thumbnail_source" text DEFAULT 'default' NOT NULL, "thumbnail_settings" text DEFAULT '{"fit":"contain","x":50,"y":50,"zoom":1}' NOT NULL);

ALTER TABLE app_private."video_lessons" ENABLE ROW LEVEL SECURITY;

ALTER TABLE app_private."video_lessons" FORCE ROW LEVEL SECURITY;

CREATE INDEX "idx_ielts_blocks_lesson_position" ON app_private."ielts_blocks" ("lesson_id","position");

CREATE UNIQUE INDEX "idx_ielts_progress_user_lesson" ON app_private."ielts_progress" ("user_id","lesson_id");

CREATE INDEX "idx_ielts_speaking_category_status" ON app_private."ielts_speaking_examples" ("category","status");

CREATE INDEX "idx_learner_profiles_country" ON app_private."learner_profiles" ("country");

CREATE INDEX "idx_learner_profiles_created" ON app_private."learner_profiles" ("created_at");

CREATE UNIQUE INDEX "idx_learner_profiles_pending_email" ON app_private."learner_profiles" ("pending_email");

CREATE INDEX "idx_learning_daily_user_day" ON app_private."learning_daily" ("user_id","day");

CREATE UNIQUE INDEX "idx_learning_daily_user_lesson_day" ON app_private."learning_daily" ("user_id","section","lesson_id","day");

CREATE UNIQUE INDEX "idx_learning_progress_user_lesson" ON app_private."learning_progress" ("user_id","section","lesson_id");

CREATE INDEX "idx_learning_progress_user_recent" ON app_private."learning_progress" ("user_id","last_accessed_at");

CREATE UNIQUE INDEX "idx_payment_orders_provider_ref" ON app_private."payment_orders" ("provider_ref");

CREATE INDEX "idx_payment_orders_user" ON app_private."payment_orders" ("user_id");

CREATE INDEX "idx_quick_tips_category_status" ON app_private."quick_tip_lessons" ("category","status");

CREATE INDEX "idx_reading_blocks_chapter_position" ON app_private."reading_blocks" ("chapter_id","position");

CREATE INDEX "idx_reading_chapters_item_position" ON app_private."reading_chapters" ("item_id","position");

CREATE INDEX "idx_reading_items_status_category" ON app_private."reading_items" ("status","category");

CREATE INDEX "idx_referral_signups_inviter" ON app_private."referral_signups" ("inviter_user_id","confirmed_at");

CREATE INDEX "idx_routine_lessons_status_created" ON app_private."routine_lessons" ("status","created_at");

CREATE UNIQUE INDEX "idx_saved_routines_user_lesson" ON app_private."saved_routines" ("user_id","lesson_id");

CREATE INDEX "idx_saved_sentences_user_created" ON app_private."saved_sentences" ("user_id","created_at");

CREATE UNIQUE INDEX "idx_saved_sentences_user_lesson_start" ON app_private."saved_sentences" ("user_id","lesson_id","start_ms");

CREATE INDEX "idx_saved_vocabulary_user_word" ON app_private."saved_vocabulary" ("user_id","word");

CREATE INDEX "idx_speaking_recordings_user_lesson" ON app_private."speaking_recordings" ("user_id","lesson_id");

CREATE INDEX "idx_support_messages_author" ON app_private."support_messages" ("author_id","created_at");

CREATE INDEX "idx_support_messages_ticket" ON app_private."support_messages" ("ticket_id","created_at");

CREATE INDEX "idx_support_status_updated" ON app_private."support_tickets" ("status","updated_at");

CREATE INDEX "idx_support_user_updated" ON app_private."support_tickets" ("user_id","updated_at");

CREATE INDEX "idx_user_admin_audit_target" ON app_private."user_admin_audit" ("target_id");

CREATE INDEX "idx_video_lessons_status_category" ON app_private."video_lessons" ("status","category");

CREATE UNIQUE INDEX "referral_codes_code_unique" ON app_private."referral_codes" ("code");

CREATE UNIQUE INDEX "referral_signups_invitee_email_unique" ON app_private."referral_signups" ("invitee_email");
REVOKE ALL ON ALL TABLES IN SCHEMA app_private FROM PUBLIC, anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA app_private TO service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_private REVOKE ALL ON TABLES FROM PUBLIC, anon, authenticated;
COMMIT;

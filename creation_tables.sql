
DROP TYPE IF EXISTS "gender_options";
CREATE TYPE "gender_options" AS ENUM (
  'm',
  'f',
  'M',
  'F',
  'x',
  'X'
);

DROP TYPE IF EXISTS "fiscal_status";
CREATE TYPE "fiscal_status" AS ENUM (
  'monotributista',
  'responsable_inscripto'
);


-----------------------------------------------------------------------------------------------
-- PROFESSIONAL
-----------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS "professional" CASCADE;
CREATE TABLE "professional" (
    "professional_id"   INTEGER generated ALWAYS as IDENTITY PRIMARY KEY,
    "name"              VARCHAR(100)    NOT NULL,
    "last_name"         VARCHAR(100)    NOT NULL,
    "profile"           VARCHAR(100) 	NOT NULL UNIQUE,
    "phone"             VARCHAR(30),         
    "email" 		    VARCHAR(255),       
    "password"          VARCHAR(255) 	NOT NULL,
    "gender"            gender_options  NOT NULL,
    "deleted_at"        TIMESTAMP,
    "created_at"        TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at"        TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP

    -- Verifica que el registro tenga al menos el phone o el email
    CHECK (email IS NOT NULL OR phone IS NOT NULL)
    -- Valida formato
    CHECK (email <> '')
    -- CHECK (phone ~ '^(?:(?:00)?549?)?0?(?:11|[2368]\d)(?:(?=\d{0,2}15)\d{2})??\d{8}$' OR phone IS NULL)
);

DROP INDEX IF EXISTS unique_email_exclude_empty;
CREATE UNIQUE INDEX unique_email_exclude_empty ON "professional" ((CASE WHEN email IS NOT NULL THEN email END));

DROP INDEX IF EXISTS unique_phone_exclude_empty;
CREATE UNIQUE INDEX unique_phone_exclude_empty ON "professional" ((CASE WHEN phone IS NOT NULL THEN phone END));

-----------------------------------------------------------------------------------------------
-- PROFESSIONAL_DETAIL
-----------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS "professional_detail" CASCADE;
CREATE TABLE "professional_detail" (
    "detail_id"         SERIAL PRIMARY KEY,
    "cuit"              VARCHAR(20),
    "fiscal_status"     fiscal_status,
    "birthdate"         DATE,
    "bank"              VARCHAR(255),
    "bank_account"      VARCHAR(50),
    "cbu"               VARCHAR(23),
    "alias"             VARCHAR(50),
    "created_at"        TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at"        TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT professional_fk FOREIGN KEY (detail_id) REFERENCES "professional"(professional_id),

    -- Verifica que el profesional tenga entre 18 y 85 años 
    CHECK (birthdate <= CURRENT_DATE - INTERVAL '18 years' AND birthdate >= CURRENT_DATE - INTERVAL '85 years')
);
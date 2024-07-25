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
    "mongo_id"          TEXT            NOT NULL UNIQUE,
    "name"              VARCHAR(100)    NOT NULL,
    "last_name"         VARCHAR(100)    NOT NULL,
    "profile"           VARCHAR(100) 	NOT NULL UNIQUE,
    "deleted_at"        TIMESTAMP,
    "created_at"        TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at"        TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP
);


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
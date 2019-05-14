{{ config(materialized='view') }}

SELECT "Contact"."id" AS "Contact Id",
       DATE_TRUNC('day', ("Contact"."create_date" AT TIME ZONE 'UTC'))::DATE AS "Contact Create Date",
       "Contact"."email" AS "Contact Email",
       "Contact"."lead_source" AS "Lead Source",
       "Contact"."life_cycle_stage" AS "Life Cycle Stage",
       "Owner"."email" AS "Contact Owner"
FROM "hubspot"."contact" AS "Contact"
INNER JOIN "hubspot"."owner" AS "Owner" ON "Contact"."hubspot_owner_id" = "Owner"."id"
GROUP BY "Contact"."id",
         DATE_TRUNC('day', ("Contact"."create_date" AT TIME ZONE 'UTC'))::DATE,
         "Contact"."email",
         "Contact"."lead_source",
         "Contact"."life_cycle_stage",
         "Owner"."email"
ORDER BY "Contact Id" ASC
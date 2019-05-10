{{ config(materialized='view') }}

SELECT "Account"."id" AS "Account Id",
       "Account"."name" AS "Account Name",
       "Account"."number_of_employees" AS "Number Of Employees",
       DATE_TRUNC('day', ("Account"."created_date" AT TIME ZONE 'UTC'))::DATE AS "Account Created Date",
       "Opportunity"."id" AS "Opportunity Id",
       "Opportunity"."lead_source" AS "Lead Source",
       "Opportunity"."amount" AS "Opportunity Amount",
       "Opportunity"."stage_name" AS "Stage Name",
       "Opportunity"."type" AS "Opportunity Type",
       "User"."email" AS "Opportunity Owner"
FROM "salesforce"."account" AS "Account"
INNER JOIN "salesforce"."user" AS "User" ON "Account"."owner_id" = "User"."id"
INNER JOIN "salesforce"."opportunity" AS "Opportunity" ON "Opportunity"."account_id" = "Account"."id"
WHERE ("Opportunity"."type" != 'Churn')
GROUP BY "Account"."id",
         "Account"."name",
         "Account"."number_of_employees",
         DATE_TRUNC('day', ("Account"."created_date" AT TIME ZONE 'UTC'))::DATE,
         "Opportunity"."id",
         "Opportunity"."lead_source",
         "Opportunity"."amount",
         "Opportunity"."stage_name",
         "Opportunity"."type",
         "User"."email"
ORDER BY "Account Id" ASC
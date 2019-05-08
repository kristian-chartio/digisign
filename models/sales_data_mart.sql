{{ config(materialized='view') }}

SELECT DATE_TRUNC('day', ("Account"."created_date" AT TIME ZONE 'UTC'))::DATE AS "Day of Created Date",
       "Account"."name" AS "Name",
       "Account"."id" AS "Id",
       "Account"."annual_revenue" AS "Annual Revenue",
       "Account"."number_of_employees" AS "Number Of Employees",
       "Opportunity"."amount" AS "Amount",
       "Opportunity"."lead_source" AS "Lead Source",
       "Opportunity"."stage_name" AS "Stage Name",
       "Opportunity"."type" AS "Type"
FROM "salesforce"."account" AS "Account"
INNER JOIN "salesforce"."opportunity" AS "Opportunity" ON "Opportunity"."account_id" = "Account"."id"
WHERE ("Opportunity"."type" != 'Churn')
GROUP BY DATE_TRUNC('day', ("Account"."created_date" AT TIME ZONE 'UTC'))::DATE,
         "Account"."name",
         "Account"."id",
         "Account"."annual_revenue",
         "Account"."number_of_employees",
         "Opportunity"."amount",
         "Opportunity"."lead_source",
         "Opportunity"."stage_name",
         "Opportunity"."type"
ORDER BY "Day of Created Date" ASC
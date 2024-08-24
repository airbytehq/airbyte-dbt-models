
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            
            address,
            advertiser_id AS id,
            balance,
            cellphone_number,
            cellphone_number AS phone_number,
            company,
            contacter,
            country,
            currency,
            description,
            email,
            industry,
            language,
            name,
            telephone_number AS telephone,
            telephone_number,
            timezone

        FROM
            {{ source('source_tiktok_marketing', 'advertisers') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            
            address,
            advertiser_id AS id,
            balance,
            cellphone_number,
            cellphone_number AS phone_number,
            company,
            contacter,
            country,
            currency,
            description,
            email,
            industry,
            language,
            name,
            telephone_number AS telephone,
            telephone_number,
            timezone

        FROM
            {{ source('source_tiktok_marketing', 'advertisers') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            
            address,
            advertiser_id AS id,
            balance,
            cellphone_number,
            cellphone_number AS phone_number,
            company,
            contacter,
            country,
            currency,
            description,
            email,
            industry,
            language,
            name,
            telephone_number AS telephone,
            telephone_number,
            timezone

        FROM
            {{ source('source_tiktok_marketing', 'advertisers') }}
    )

    SELECT * FROM TMP

{%endif%}

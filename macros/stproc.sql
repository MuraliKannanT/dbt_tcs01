{% macro spins() %}

{# Query to generate random numbers #} 
{% set rand_query %}
    select uniform(1, 10000, random()) rndno limit 1
{% endset %}

{# Run the rand_query and store the results in a agate.table#} 
{% set resultnum = run_query(rand_query)%}

{# Extract only the required data, if the query executes successfully #} 
{% if execute %}
    {% set numbr = resultnum.rows[0]['RNDNO'] %}
{% endif %}

{# Query to fetch key and name from suppliers which matches the numbr variable #} 
{% set supp_query %}
    select top 1 skey,sname from {{ ref('supplier_names') }}  where skey={{numbr}}
{% endset %}
{% set results = run_query(supp_query) %}

{% if execute %}
{# Extract only the required data, if the query executes successfully #} 

    {% set supkey = results.rows[0] %}

{# Query to call a stored procedure already created in Snowflake, by passing input values #} 
    {% set proquery %}
    call SOURCEDB.MK_MALL.INSERT_VALUE({{supkey['SKEY']}} , '{{ supkey['SNAME'] }}' );
    {% endset %}
    {% do run_query(proquery) %}
 {% endif %}
{% endmacro %}
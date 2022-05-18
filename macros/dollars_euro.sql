{% macro dol_eur(colname,decno) -%}

    round( 0.96 * {{colname}}, {{decno}})

{%- endmacro %}
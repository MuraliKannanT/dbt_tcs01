select 
order_id,
total_price,
{{ dol_eur('total_price',2) }} price_euro
from stg_orders
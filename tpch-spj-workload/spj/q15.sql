select
    s_suppkey,
    s_name,
    s_address,
    s_phone,
	l_suppkey,
	l_extendedprice,
    l_discount
from
    supplier,
	lineitem
where
    s_suppkey = l_suppkey
    and l_shipdate >= date '1995-03-21'
    and l_shipdate < date '1995-03-21' + interval '3' year

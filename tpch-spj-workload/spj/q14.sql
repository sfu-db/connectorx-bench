select
	p_type,
    l_extendedprice,
    l_discount
from
	lineitem,
	part
where
	l_partkey = p_partkey
	and l_shipdate >= date '1994-09-01'
	and l_shipdate < date '1994-09-01' + interval '3' year

l_extendedprice
select
	l_extendedprice,
    l_discount
from
	lineitem
where
	l_shipdate >= date '1992-01-01'
	and l_shipdate < date '1992-01-01' + interval '4' year
	and l_discount between .06 - 0.03 and .06 + 0.03
	and l_quantity < 48

l_extendedprice
select
	l_extendedprice
from
	lineitem,
	part
where
	p_partkey = l_partkey
	and p_brand in ('Brand#23', 'Brand#43')
	and p_container <> 'MED BOX'
	and l_quantity < (
		select
			0.8 * avg(l_quantity)
		from
			lineitem
		where
			l_partkey = p_partkey
	)

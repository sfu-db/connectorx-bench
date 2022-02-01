select
	n_name,
	l_extendedprice,
    l_discount
from
	customer,
	orders,
	lineitem,
	supplier,
	nation,
	region
where
	c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and l_suppkey = s_suppkey
	and c_nationkey = s_nationkey
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
    and r_name <> 'ASIA'
    and o_orderdate >= date '1992-12-21'
    and o_orderdate < date '1992-12-21' + interval '5' year

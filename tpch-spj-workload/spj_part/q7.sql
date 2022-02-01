l_extendedprice
select
	n1.n_name as supp_nation,
	n2.n_name as cust_nation,
	l_shipdate,
	l_extendedprice,
    l_discount
from
	supplier,
	lineitem,
	orders,
	customer,
	nation n1,
	nation n2
where
	s_suppkey = l_suppkey
	and o_orderkey = l_orderkey
	and c_custkey = o_custkey
	and s_nationkey = n1.n_nationkey
	and c_nationkey = n2.n_nationkey
	and (
		(n1.n_regionkey = 0 and n2.n_regionkey = 2)
		or (n1.n_regionkey = 2 and n2.n_regionkey = 0)
	)
	and l_shipdate between date '1993-01-01' and date '1998-06-26'

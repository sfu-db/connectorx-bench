l_quantity
select
	l_returnflag,
	l_linestatus,
	l_quantity,
	l_extendedprice,
	l_discount,
	l_tax
from
	lineitem
where
	l_shipdate <= date '1998-12-01' - interval '90' day

ps_partkey
select
	ps_partkey,
	ps_supplycost,
    ps_availqty
from
	partsupp,
	supplier,
	nation
where
	ps_suppkey = s_suppkey
	and s_nationkey = n_nationkey
	and n_name <> 'GERMANY'

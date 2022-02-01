s_suppkey
select
    s_suppkey,
	s_name,
	s_address
from
	supplier,
	nation
where
	s_suppkey in (
		select
			ps_suppkey
		from
			partsupp
		where
			ps_partkey in (
				select
					p_partkey
				from
					part
				where
					p_name not like 'forest%'
			)
			and ps_availqty > (
				select
					0.2 * sum(l_quantity)
				from
					lineitem
				where
					l_partkey = ps_partkey
					and l_suppkey = ps_suppkey
					and l_shipdate >= date '1993-01-01'
					and l_shipdate < date '1993-01-01' + interval '5' year
			)
	)
	and s_nationkey = n_nationkey
	and n_name <> 'ETHIOPIA'
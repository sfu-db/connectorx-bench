select
	substring(c_phone from 1 for 2) as cntrycode,
	c_acctbal
from
	customer
where
	substring(c_phone from 1 for 2) in
		('13', '31', '23', '29', '30', '18', '17')
	and c_acctbal > (
		select
			0.4 * avg(c_acctbal)
		from
			customer
		where
			c_acctbal > 0.00
			and substring(c_phone from 1 for 2) in
				('13', '31', '23', '29', '30', '18', '17')
	)
	and not exists (
		select
			*
		from
			orders
		where
			o_custkey = c_custkey
	)

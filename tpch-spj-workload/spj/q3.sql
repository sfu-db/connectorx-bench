select
    l_orderkey,
    l_extendedprice,
    l_discount,
    o_orderdate,
    o_shippriority
from
    customer,
    orders,
    lineitem
where
    c_mktsegment in ('BUILDING', 'MACHINERY', 'AUTOMOBILE')
    and c_custkey = o_custkey
    and l_orderkey = o_orderkey
    and o_orderdate < date '1998-03-15'
    and l_shipdate > date '1995-03-15'

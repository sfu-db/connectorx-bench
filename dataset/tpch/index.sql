-- https://github.com/oltpbenchmark/oltpbench/blob/master/src/com/oltpbenchmark/benchmarks/tpch/ddls/tpch-postgres-index-ddl.sql

create unique index c_ck on customer (c_custkey asc) ;
create index c_nk on customer (c_nationkey asc) ;
create unique index p_pk on part (p_partkey asc) ;
create unique index s_sk on supplier (s_suppkey asc) ;
create index s_nk on supplier (s_nationkey asc) ;
create index ps_pk on partsupp (ps_partkey asc) ;
create index ps_sk on partsupp (ps_suppkey asc) ;
create unique index ps_pk_sk on partsupp (ps_partkey asc, ps_suppkey asc) ;
create unique index ps_sk_pk on partsupp (ps_suppkey asc, ps_partkey asc) ;
create unique index o_ok on orders (o_orderkey asc) ;
create index o_ck on orders (o_custkey asc) ;
create index o_od on orders (o_orderdate asc) ;
create index l_ok on lineitem (l_orderkey asc) ;
create index l_pk on lineitem (l_partkey asc) ;
create index l_sk on lineitem (l_suppkey asc) ;
--create index l_ln on lineitem (l_linenumber asc) ;
create index l_sd on lineitem (l_shipdate asc) ;
create index l_cd on lineitem (l_commitdate asc) ;
create index l_rd on lineitem (l_receiptdate asc) ;
--create unique index l_ok_ln on lineitem (l_orderkey asc, l_linenumber asc) ;
--create unique index l_ln_ok on lineitem (l_linenumber asc, l_orderkey asc) ;
create index l_pk_sk on lineitem (l_partkey asc, l_suppkey asc) ;
create index l_sk_pk on lineitem (l_suppkey asc, l_partkey asc) ;
create unique index n_nk on nation (n_nationkey asc) ;
create index n_rk on nation (n_regionkey asc) ;
create unique index r_rk on region (r_regionkey asc) ;

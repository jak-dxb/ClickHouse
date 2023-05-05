-- { echoOn }
-- corner case with constant sort prefix
SELECT number
FROM numbers(1)
ORDER BY 10 ASC, number DESC WITH FILL FROM 1
SETTINGS enable_positional_arguments=0;

-- sensor table
drop table if exists ts;
create table ts (sensor_id UInt64, timestamp UInt64, value Float64) ENGINE=MergeTree()  ORDER BY (sensor_id, timestamp);
insert into ts VALUES (1, 10, 1), (1, 12, 2), (3, 5, 1), (3, 7, 3), (5, 1, 1), (5, 3, 1);
-- FillingTransform: 6 rows will be processed in 1 chunks
select * from ts order by sensor_id, timestamp with fill step 1;

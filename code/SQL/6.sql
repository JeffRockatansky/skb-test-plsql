create table
	TableC
as (
	select
		B.OWNM
		, A.EMPFIO
	from
		TableA A
	inner join
		TableB B
	on
		A.key = B.key
);
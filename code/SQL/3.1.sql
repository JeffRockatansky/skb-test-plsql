-- 1. записи из таблицы А, которых нет в таблице B;
select
	*
from
	A
left outer join
	B
on
	A.key = B.key
where
	B.key is null;

-- 2. записи, которые имеются одновременно и в таблице А, и в таблице B;
select
	*
from
	A
inner join
	B
on
	A.key = B.key;

-- 3. записи, которые имеются либо в таблице А, либо в таблице B;
select
	*
from
	A
full outer join
	B
on
	A.key = B.key;

-- 4. уникальные записи, которые имеются либо в таблице А, либо в таблице B.
select
	*
from
	A
full outer join
	B
on
	A.key = B.key
where
	A.key is null or B.key is null;
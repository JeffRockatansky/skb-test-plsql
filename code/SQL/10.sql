create table SKB_TSILYURIK_TABLE_C (
	OWNM varchar2(4000) not null
	, EMPFIO varchar2(4000) not null
);
COMMIT;
/
-- Add comments to the table
COMMENT ON TABLE "SKB_TSILYURIK_TABLE_C" IS 'Таблица C';
-- Add comments to the columns
COMMENT ON COLUMN "SKB_TSILYURIK_TABLE_C"."OWNM" IS 'Наименование подразделения';
COMMENT ON COLUMN "SKB_TSILYURIK_TABLE_C"."EMPFIO" IS 'ФИО сотрудника';
/
declare
	arg_ownm SKB_TSILYURIK_TABLE_C.OWNM%type := 'Гаррипоттерная';
	arg_empfio SKB_TSILYURIK_TABLE_C.EMPFIO%type := 'Зубенко Михаил Петрович';
	b_record_exists number := 0;
	ex_record_exists EXCEPTION;
begin
	select
		count(*) cnt
	into
		b_record_exists
	from
		SKB_TSILYURIK_TABLE_C C
	where
		C.OWNM = arg_ownm
		and
		C.EMPFIO = arg_empfio;
	if (b_record_exists > 0)
		then
			raise ex_record_exists;
		else
			insert
				into SKB_TSILYURIK_TABLE_C(OWNM, EMPFIO)
				values (arg_ownm, arg_empfio);
	end if;
EXCEPTION
	when ex_record_exists then
		dbms_output.put_line('This record already exists!');
end;
/
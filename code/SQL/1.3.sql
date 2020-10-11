--drop table SKB_TSILYURIK_EMP;
--commit;
--/
create table SKB_TSILYURIK_EMP (
	tabnum number PRIMARY key
	, username varchar2(4000) not null UNIQUE
);

-- # Comments
-- ## Table
COMMENT ON TABLE "SKB_TSILYURIK_EMP" IS 'Таблица Сотрудников';
-- ## Colums
COMMENT ON COLUMN "SKB_TSILYURIK_EMP"."TABNUM" IS 'Табельный номер';
COMMENT ON COLUMN "SKB_TSILYURIK_EMP"."USERNAME" IS 'Имя пользователя';

CREATE OR REPLACE PACKAGE skb_tsilyurik_accs is
	type numrow is record (num number);
	type t_num is table of numrow;
	procedure gen(arg_n_count in number);
	function get(arg_v_username in varchar2) return t_num pipelined;
end skb_tsilyurik_accs;
/
CREATE OR REPLACE PACKAGE BODY skb_tsilyurik_accs is
	procedure gen(arg_n_count in number) is
		--my_tname CONSTANT tab.tname%type := 'SKB_TSILYURIK_EMP';
		tname tab.tname%type := null;
	begin
		dbms_output.put_line(arg_n_count);
		begin
		select
			t.tname
			into tname
			from tab t
			where t.tname = 'SKB_TSILYURIK_EMP';
			EXCEPTION
				WHEN
					NO_DATA_FOUND
				THEN
					tname := NULL;
		end;
		dbms_output.put_line('test');
		if tname is not null then
			dbms_output.put_line('ok');
			for i in 1..arg_n_count loop
				insert into SKB_TSILYURIK_EMP values (i, 'user'||i);
				commit;
			end loop;
		end if;
	end gen;
	function get(arg_v_username in varchar2) return t_num pipelined is
	begin
		for acid in (
			select
				emp.tabnum acid
				from
					skb_tsilyurik_emp emp
				where
					emp.username = arg_v_username
		) loop
			pipe row(acid);
		end loop;
		return;
	end get;
end skb_tsilyurik_accs;
/
begin
	skb_tsilyurik_accs.gen(arg_n_count => 5);
	commit;
end;
/
select * from SKB_TSILYURIK_EMP;
/
select * from table(skb_tsilyurik_accs.get('user2'));
/

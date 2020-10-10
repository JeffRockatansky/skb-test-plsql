CREATE OR REPLACE PACKAGE skb_tsilyurik_accs is
	type numrow is record (num number);
	type t_num is table of numrow;
	procedure gen(arg_n_count in number);
	function get(arg_v_username in varchar2) return t_num pipelined;
end skb_tsilyurik_accs;
/
CREATE OR REPLACE PACKAGE BODY skb_tsilyurik_accs is
	procedure gen(arg_n_count in number) is
		my_tname CONSTANT tab.tname%type := 'SKB_TSILYURIK_EMP';
		tname tab.tname%type := null;
	begin
		select
			t.tname
			into tname
			from tab t
			where t.tname = my_tname;
			EXCEPTION
				WHEN
					NO_DATA_FOUND
				THEN
					tname := NULL;
		if tname = null then
			execute immediate
q'[create table ]'||my_tname||q'[ (
	tabnum number not null
	, username varchar2(4000) not null
);
commit;]';
		end if;
		for i in 1..arg_n_count loop
			insert into SKB_TSILYURIK_EMP values (i, 'user'||i);
		end loop;
	end gen;
	function get(arg_v_username in varchar2) return t_num pipelined is
	begin
		for acid in (
			select
				emp.tabnum
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

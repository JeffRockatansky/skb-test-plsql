declare
	msg varchar2(4000);
	type skb_coll_row is record (s varchar2(100), k varchar2(100), b varchar2(100));
	type skb_coll is table of skb_coll_row;
	msg_coll skb_coll;
begin
	-- XML generation from query
	select
		xmlelement(
			"SKB"
			, xmlforest(s, k, b)
		).getClobVal() myxml
		into msg
	from (
		select
			'Самый' s
			, 'Клёвый' k
			, 'Банк' b
		from dual
	) skb;
	dbms_output.put_line(msg);
	-- XML parsing into table collection
	
end;
/
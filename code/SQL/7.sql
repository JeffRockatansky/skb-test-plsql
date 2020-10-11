declare
	type skb_coll_row is record (s varchar2(100), k varchar2(100), b varchar2(100));
	type skb_coll is table of skb_coll_row;
	msg_coll skb_coll;
	msg varchar2(4000);
	msg_xml xmltype;
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
	-- Writing string into XML
	msg_xml := xmltype(msg);
	-- XML parsing into nested table collection
	select
		extractvalue(Value(skb_xml), '/SKB/S') as s
		, extractvalue(Value(skb_xml), '/SKB/K') as k
		, extractvalue(Value(skb_xml), '/SKB/B') as b
	bulk collect into
		msg_coll
	from table(XMLSequence(Extract(msg_xml, '/SKB'))) skb_xml;
	dbms_output.put_line(msg_coll(1).s||' '||msg_coll(1).k||' '||msg_coll(1).b);
end;
/
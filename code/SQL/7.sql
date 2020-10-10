select
	xmlagg(
		xmlelement(
			"SKB"
			, xmlforest(s, k, b)
		)
	).getClobVal() myxml
from (
	select
		'Самый' s
		, 'Клёвый' k
		, 'Банк' b
	from dual
) skb;
/
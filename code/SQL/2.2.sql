declare
	type varray_num is varray(10) of number;
	arr varray_num := varray_num(15, 10, 4, 8, 3, 1, 2, 6, 14, 7);
	buff number;
	isSorted number;
begin
	for i in 1..arr.count loop
		isSorted := 1;
		for j in 2..(arr.count - i + 1) loop
			if (arr(j) < arr(j - 1)) then
				buff := arr(j);
				arr(j) := arr(j - 1);
				arr(j - 1) := buff;
				isSorted := 0;
			end if;
		end loop;
		if (isSorted = 1) then
			exit;
		end if;
	end loop;
	-- output
	FOR i in 1..arr.count LOOP
		dbms_output.put_line(arr(i));
	END LOOP;
end;
/
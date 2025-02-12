-- Exploring Array Functions

--  ethier of the expression should be true like OR
SELECT 
	ARRAY[1, 2, 3, 4] >= ARRAY[1, 2, 3, 4], -- here = is true no need to check for > 
	ARRAY[1, 2, 3, 4] <= ARRAY[2, 3, 4, 5], -- here < is true no need to check for =
	ARRAY[1, 2, 3, 4] >= ARRAY[2, 3, 4, 5]  -- here non of expression is true
; 

SELECT 
	ARRAY[1, 2, 3, 4] < ARRAY[2, 3, 4]
; -- HERE THEY ARE COMPARING NO. OF ELEMENTS


-- @>, <@, && this ara inclusion operator
-- @> this is contain operator which means it check for wheater values on rigth are present in left or not
-- <@ reverse of @>
-- && this is used to check overlap



-- Array concatenation

SELECT 
	ARRAY[1, 2, 3] || ARRAY[4, 5, 6],
	ARRAY_CAT(ARRAY[1, 2, 3], ARRAY[4, 5, 6]),
	0 || ARRAY[1, 2, 3],
    ARRAY[1, 2, 3] || 4,
	ARRAY_PREPEND(0, ARRAY[1, 2, 3]),
	ARRAY_APPEND(ARRAY[1, 2, 3], 0)
;	

SELECT
	ARRAY_NDIMS(ARRAY[[[1]]]),
	ARRAY_DIMS(ARRAY[[[1]]]),
	ARRAY_LENGTH(ARRAY[4, 5, 6], 1),
	ARRAY_LOWER(ARRAY[5, 6, 4], 1), -- return starting index of array
	ARRAY_UPPER(ARRAY[4, 5, 6, 3], 1), -- return last index of array
	ARRAY_POSITION(ARRAY[5, 6, 4], 6),
	ARRAY_POSITIONS(ARRAY[5, 6, 4, 6, 6], 6),
	ARRAY_REMOVE(ARRAY[5, 6, 4, 6, 6], 6),
	ARRAY_REPLACE(ARRAY[5, 6, 4, 6, 6], 6, 3)
;

SELECT 
	STRING_TO_ARRAY('1,2,3,4,5', ','),
	STRING_TO_ARRAY('1 2 3 4 5', ' ')
;


-- Multi-dimensional array

CREATE TABLE students(
	student_id SERIAL PRIMARY KEY,
	student_name VARCHAR(100),
	student_grade INTEGER[][]
);


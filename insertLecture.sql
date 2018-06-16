create or replace PROCEDURE InsertLecture(
sCourseName IN VARCHAR2,
nCourseUnit IN NUMBER,
sProfessorId IN VARCHAR2,
sCourseId IN VARCHAR2,
nCourseIdNo IN NUMBER,
nTime IN NUMBER,
nMax IN NUMBER,
result OUT VARCHAR2
)
IS
duplicate_time_professor EXCEPTION;


check1 NUMBER;
check2 NUMBER;

nYear NUMBER;
nSemester NUMBER;


CURSOR duplicate_time_cursor IS
SELECT *
FROM TEACH
WHERE p_id = sProfessorId;



BEGIN
result := '';

--DBMS_OUTPUT.put_line('#');
--DBMS_OUTPUT.put_line(sProfessorId || '님이 과목번호 ' || sCourseId || ', 분반 ' || TO_CHAR(nCourseIdNo) || '의 수업 등록을 요청하였습니다.');

/* 년도, 학기 알아내기 */
nYear := Date2EnrollYear(SYSDATE);
nSemester := Date2EnrollSemester(SYSDATE);

/* 에러처리 1 : 중복 시간 수업 있는 경우*/
check1 := 0;
For time_list IN duplicate_time_cursor LOOP
	check1 := compareTime4pro(nTime,time_list.c_id,time_list.c_id_no);
	IF(check1 >0 ) THEN
		RAISE duplicate_time_professor;
	END IF;
END LOOP;


INSERT INTO TEACH
VALUES(sProfessorId, sCourseId, nCourseIdNo,sCourseName,nCourseUnit, nYear, nSemester,nTime ,nMax);

  COMMIT;
  result := '수업을 추가하였습니다.';

EXCEPTION
WHEN duplicate_time_professor THEN
result := '이미 등록된 과목 중 중복되는 강의가 존재합니다.';
WHEN OTHERS THEN
    ROLLBACK;
    result := '잠시후에 다시 시도해주세요';
END;
/
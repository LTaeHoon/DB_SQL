-- SQL Developer에서 작업

-- procedure : SQL 문을 절차적 언어와 같이 DB 프로그래밍할 수 있는 기능
-- 특정 교수의 급여 인상 프로시저
CREATE OR REPLACE PROCEDURE sal_inc(pno in NUMBER)
IS
BEGIN
  update professor set pay = pay * 1.1
  where profno = pno;
  COMMIT;
EXCEPTION WHEN OTHERS THEN
  ROLLBACK;
END;

select * from professor;

--프로시저 실행 : 1001 교수 대상 급여 인상
execute sal_inc(1001);

-- 프로시저 삭제
drop procedure sal_inc;

--trigger 생성
CREATE OR REPLACE TRIGGER sal_chk
BEFORE UPDATE
ON PROFESSOR
BEGIN
DBMS_OUTPUT.PUT_LINE('교수테이블이 수정되었습니다.');
END;

--trigger 실행 : trigger ->DML 명령 실행 시 자동으로 이벤트를 발생시키는 데이터베이트 객체
execute sal_inc(1002);
update professor set pay = pay*1.5 where profno = 1003;

-- trigger 삭제
drop trigger sal_chk;

--사용자 정의함수 : 사용자가 직접 정의한 함수를 의미

CREATE OR REPLACE FUNCTION EMP_SAL(ENO NUMBER)
RETURN NUMBER -- 리턴값의 자료형
IS
    SAL_VAL NUMBER(6); -- 리턴 변수 선언
BEGIN
    SAL_VAL := 0; -- 리턴 변수 초기화
    SELECT SAL
        INTO SAL_VAL -- SAL 칼럼 조회 결과를 변수에 저장
        FROM EMP
    WHERE EMPNO = ENO;
    RETURN SAL_VAL; -- 급여 결과 리턴
END;

--사용자 정의함수 호출
select * from emp;
select emp_sal(7369) from dual;

-- 사용자 정의함수 삭제
drop function emp_sal;
(defrule CreateStudentsList
; Create a List with all the IDs of the Students

	(ToDo CreateStudentsList)
    ?adStudentsList <- (OrderedStudentsList $?Students)
    (Student
        (ID ?studentID)
    )
    (not (OrderedStudentsList $? ?studentID $?))
    =>
    (retract ?adStudentsList)
    (assert (OrderedStudentsList $?Students ?studentID))
)

(defrule OrderStudentsList
; Order the List which contains all the IDs of the Students
; Is Activated only when fact (ToDo OrderStudents) is in the WM

    (ToDo OrderStudents)
    ?adStudentsList <- (OrderedStudentsList $?IDgroup1 ?ID1 $?IDgroup2 ?ID2 $?IDgroup3)
    (Student
        (ID ?ID1)
        (NoDisciplinesFailed ?NoDisciplinesFailedID1)
        (AverageFinalGrades ?AverageFinalGradesID1)
    )
    (Student
        (ID ?ID2)
        (NoDisciplinesFailed ?NoDisciplinesFailedID2)
        (AverageFinalGrades ?AverageFinalGradesID2)
    )
    (test (or (and (eq ?NoDisciplinesFailedID1 ?NoDisciplinesFailedID2)
                   (< ?AverageFinalGradesID1 ?AverageFinalGradesID2)
              ) 
              (> ?NoDisciplinesFailedID1 ?NoDisciplinesFailedID2)
          )
    )
    =>
    (retract ?adStudentsList)
    (assert (OrderedStudentsList $?IDgroup1 ?ID2 $?IDgroup2 ?ID1 $?IDgroup3))
)
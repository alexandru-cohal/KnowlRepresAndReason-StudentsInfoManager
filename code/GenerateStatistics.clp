;-------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------- FINAL GRADES --------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------

(defrule PrintAverageFinalGrades
; Print the Final Average Grades for all Students

	(Print AverageFinalGrades)
	(Student
		(ID ?IDStudent)
		(AverageFinalGrades ?AverageFinalGrades)
	)
	=>
	(printout t "Student " ?IDStudent " has the Final Average Grades: " ?AverageFinalGrades crlf)
)

(defrule PrintAverageFinalGradesGreater
; Print the Students who have the Final Average Grades greater than a specified value

	(Print AverageFinalGrades greater ?thresholdAverageFinalGrades)
	(Student
		(ID ?IDStudent)
		(AverageFinalGrades ?AverageFinalGrades &: (>= ?AverageFinalGrades ?thresholdAverageFinalGrades))
	)
	=>
	(printout t "Student " ?IDStudent " has the Final Average Grades: " ?AverageFinalGrades " (greater or equal than " ?thresholdAverageFinalGrades " )"  crlf)
)

(defrule PrintAverageFinalGradesGreater_NoMatch
; Print a message when no Students have the Final Average Grades greater than a specified value

	?ad <- (Print AverageFinalGrades greater ?thresholdAverageFinalGrades)
	(not (Student
			(ID ?IDStudent)
			(AverageFinalGrades ?AverageFinalGrades &: (>= ?AverageFinalGrades ?thresholdAverageFinalGrades))
		 )
	)
	=>
	(retract ?ad)
	(printout t "No Student has the Final Average Grades greater or equal than " ?thresholdAverageFinalGrades crlf)
)

(defrule PrintAverageFinalGradesFailed
; Print the Students who have at least one discipline Failed

	(Print AverageFinalGrades Fail)
	(Student
		(ID ?IDStudent)
		(FinalGrades $? 0.0 $?)
	)
	=>
	(printout t "Student " ?IDStudent " has Failed at least one discipline " crlf)
)

(defrule PrintAverageFinalGradesStudent
; Print the Final Average Grades for a specific Student

	?ad <- (Print AverageFinalGrades Student ?IDStudent)
	(Student
		(ID ?IDStudent)
		(AverageFinalGrades ?AverageFinalGrades)
	)
	=>
	(retract ?ad)
	(printout t "Student " ?IDStudent " has the Final Average Grades: " ?AverageFinalGrades crlf)
)

(defrule PrintFinalGradeDiscipline
; Print the final grade of all Students at a specified discipline
	
	(Print FinalGrade Discipline ?discipline)
	(Student
		(ID ?IDStudent)
		(DisciplineNames $?disciplineList1 ?discipline $?)
		(FinalGrades $?finalGradesList)
	)
	=>
	(printout t "Student " ?IDStudent " has the final grade " (nth$ (+ (length$ $?disciplineList1) 1) $?finalGradesList) " at Discipline " ?discipline crlf)
)

(defrule PrintFinalGradeDiscipline_NoMatch
; Print a message when no Student studies a specified Discipline
	
	(Print FinalGrade Discipline ?discipline)
	(not (Student
			(DisciplineNames $? ?discipline $?)
		 )
	)
	=>
	(printout t "No Student studies the Discipline " ?discipline crlf)
)

(defrule PrintFinalGradeDisciplineGreater
; Print the Students having the final grade at a specified Discipline greater than a specified value
	
	(Print FinalGrade Discipline ?discipline greater ?thresholdFinalGrade)
	(Student
		(ID ?IDStudent)
		(DisciplineNames $?disciplineList1 ?discipline $?)
		(FinalGrades $?finalGradesList)
	)
	(test (>= (nth$ (+ (length$ $?disciplineList1) 1) $?finalGradesList) ?thresholdFinalGrade))
	=>
	(printout t "Student " ?IDStudent " has the final grade " (nth$ (+ (length$ $?disciplineList1) 1) $?finalGradesList) " (greater or equal than " ?thresholdFinalGrade " ) at Discipline " ?discipline crlf)
)

(defrule PrintFinalGradeDisciplineGreater_NoMatch1
; Print a message when no Student has the final grade at a specified Discipline greater than a specified value
	
	?ad <- (Print FinalGrade Discipline ?discipline greater ?thresholdFinalGrade)
	(not (Student
			(DisciplineNames $?disciplineList1 ?discipline $?)
			(FinalGrades $?finalGradesList &: (>= (nth$ (+ (length$ $?disciplineList1) 1) $?finalGradesList) ?thresholdFinalGrade))
		)
	)
	=>
	(printout t "No Student has the Final Grade greater of equal than " ?thresholdFinalGrade " at Discipline " ?discipline crlf)
	(retract ?ad)
)

(defrule PrintFinalGradeDisciplineFail
; Print the Students failed at a specified Discipline
	
	(Print FinalGrade Discipline ?discipline Fail)
	(Student
		(ID ?IDStudent)
		(DisciplineNames $?disciplineList1 ?discipline $?)
		(FinalGrades $?finalGradesList)
	)
	(test (eq (nth$ (+ (length$ $?disciplineList1) 1) $?finalGradesList) 0.0))
	=>
	(printout t "Student " ?IDStudent " failed at Discipline " ?discipline crlf)
)

(defrule PrintFinalGradeDisciplineFail_NoMatch1
; Print a message when no Student has failed at a specified Discipline
	
	(Print FinalGrade Discipline ?discipline Fail)
	(not (Student
			(DisciplineNames $?disciplineList1 ?discipline $?)
			(FinalGrades $?finalGradesList &: (eq (nth$ (+ (length$ $?disciplineList1) 1) $?finalGradesList) 0.0))
		)
	)
	=>
	(printout t "No Student has failed at Discipline " ?discipline crlf)
)

(defrule PrintFinalGradeStudent
; Print all the Average Grades of a specified Student
	
	(Print FinalGrade Student ?IDStudent)
	(Student
		(ID ?IDStudent)
		(DisciplineNames $?disciplineList1 ?discipline $?)
		(FinalGrades $?finalGradesList)
	)
	=>
	(printout t "Student " ?IDStudent " has at Discipline " ?discipline " the Average Grade " (nth$ (+ (length$ $?disciplineList1) 1) $?finalGradesList) crlf)
)

(defrule PrintFinalGradeStudentDiscipline
; Print the Average Grades at a specified Discipline of a specified Student
	
	?ad <- (Print FinalGrade Student ?IDStudent Discipline ?discipline)
	(Student
		(ID ?IDStudent)
		(DisciplineNames $?disciplineList1 ?discipline $?)
		(FinalGrades $?finalGradesList)
	)
	=>
	(printout t "Student " ?IDStudent " has at Discipline " ?discipline " the Average Grade " (nth$ (+ (length$ $?disciplineList1) 1) $?finalGradesList) crlf)
	(retract ?ad)
)

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------- SCHOLARSHIPS --------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------

(defrule PrintScholarshipStudent
; Print the Scholarship of a specified Student 

    ?ad <- (Print Scholarship Student ?IDStudent)
    (Student
        (ID ?IDStudent)
        (Scholarship ?scholarshipType)
    )
    =>
    (if (eq ?scholarshipType "")
        then (printout t "Student " ?IDStudent " has no scholarship" crlf)
        else (printout t "Student " ?IDStudent " has " ?scholarshipType " scholarship" crlf)
	)
    (retract ?ad)
)

(defrule PrintScholarshipType
; Print all the Students having a specified Scholarship

    (Print Scholarship ?scholarshipType)
	(Student
        (ID ?IDStudent)
        (Scholarship ?scholarshipType)
    )
    =>
	(printout t "Student " ?IDStudent " has " ?scholarshipType " scholarship" crlf)   
)

(defrule PrintScholarshipType_NoMatch
; Print a message when no Student has a specified Scholarship

    ?ad <- (Print Scholarship ?scholarshipType)
	(not (Student
			(Scholarship ?scholarshipType)
		 )
    )
    =>
	(printout t "No Student has " ?scholarshipType " scholarship" crlf)   
	(retract ?ad)
)

(defrule PrintScholarshipWithoutType
; Print all the Students not having any type of Scholarship

    (Print Scholarship None)
	(Student
        (ID ?IDStudent)
        (Scholarship none)
    )
    =>
	(printout t "Student " ?IDStudent " has no scholarship" crlf)   
)

(defrule PrintScholarship
; Print the Scholarship for all the Students who have Scholarships

    (Print Scholarship)
	(Student
        (ID ?IDStudent)
        (Scholarship ?scholarshipType &~ none)
    )
	(Scholarship
		(Name ?scholarshipType)
		(Amount ?amount)
	)
    =>
	(printout t "Student " ?IDStudent " has " ?scholarshipType " scholarship ( " ?amount " RON )" crlf)
)

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------- GUIDING PROFESSOR ---------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------

(defrule PrintGuidingProfStudent
; Print the Guiding Professor of a specified Student

	?ad <- (Print GuidingProf Student ?IDStudent)
	(Student
		(ID ?IDStudent)
		(OptionsGuidingProf $?optionsGuidingProf)
		(GuidingProf ?IDGuidingProf)
		(IndexGuidingProfChoice ?indexGuidingProf)
	)
	=>
	(if (eq ?IDGuidingProf none)
		then (printout t "Student " ?IDStudent " has not a Guiding Professor assigned yet" crlf)
		else (if (eq ?IDGuidingProf N/A)
				then (printout t "Student " ?IDStudent " has no valid options for Guiding Professor" crlf)
				else (printout t "Student " ?IDStudent " has " ?IDGuidingProf " as Guiding Professor (option number " ?indexGuidingProf " out of " (length$ $?optionsGuidingProf)")" crlf)
			 )
	)
    (retract ?ad)
)

(defrule PrintGuidingProfProf
; Print the Students guided by a specific Professor

	(Print GuidingProf Professor ?IDProf)
	(Student
		(ID ?IDStudent)
		(GuidingProf ?IDProf)
	)
	=>
	(printout t "Professor " ?IDProf " guides student " ?IDStudent crlf)
)

(defrule PrintGuidingProfProf_NoMatch
; Print a message when a specified Professor does not guide any Students

	(Print GuidingProf Professor ?IDProf)
	(not (Student
			(ID ?IDStudent)
			(GuidingProf ?IDProf)
		 )
	)
	=>
	(printout t "Professor " ?IDProf " does not guide any students" crlf)
)

(defrule PrintGuidingProf
; Print for each Student the Guiding Professor

    (Print GuidingProf)
    (Student
        (ID ?IDStudent)
    )
    =>
    (assert (Print GuidingProf Student ?IDStudent))
)

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------- EXAM DATES ----------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------

(defrule PrintExamDatesGroup_Initialization
; Prepare to Print all the Exam Dates for a specified Group

	?ad <- (Print ExamDates Group ?groupName)
	(Group
		(Name ?groupName)
		(Disciplines $?groupDisciplines)
		(ExamDates $?groupExamDates)
	)
	=>
	(retract ?ad)
	(assert (DisciplinesList ?groupDisciplines))
	(assert (ExamDatesList ?groupExamDates))
	(assert (GroupList ?groupName))
)

(defrule PrintExamDatesGroup
; Print all the Exam Dates for a specified Group

	?adDisc <- (DisciplinesList ?discipline $?otherDisciplines)
	?adDates <- (ExamDatesList ?examDate $?otherExamDates)
	(GroupList ?groupName)
	=>
	(printout t "Exam Date for Discipline " ?discipline ": Day " ?examDate " ( group " ?groupName " )" crlf)
	(retract ?adDisc)
	(retract ?adDates)
	(assert (DisciplinesList $?otherDisciplines))
	(assert (ExamDatesList $?otherExamDates))
)

(defrule PrintExamDatesGroup_Clean
; Finalize to Print all the Exam Dates for a specified Group

	?adDisc <- (DisciplinesList)
	?adDates <- (ExamDatesList)
	?adGroup <- (GroupList ?)
	=>
	(retract ?adDisc)
	(retract ?adDates)
	(retract ?adGroup)
)

(defrule PrintExamDatesStudent
; Print all the Exam Dates for a specified Student

	?ad <- (Print ExamDates Student ?IDStudent)
	(Student
		(ID ?IDStudent)
		(Group ?groupName)
	)
	=>
	(printout t "Student " ?IDStudent ":" crlf)
	(retract ?ad)
	(assert (Print ExamDates Group ?groupName))
)

(defrule PrintExamDates
; Print all the Exam Dates for all Groups

	?ad <- (Print ExamDates)
	(Group
		(Name ?groupName)
	)
	=>
	(retract ?ad)
	(assert (Print ExamDates Group ?groupName))
)

(defrule PrintExamDatesProfessor
; Print all the Exam Dates for a specified Professor

	?ad <- (Print ExamDates Professor ?IDProf)
	(Professor
		(ID ?IDProf)
		(PrefferedExamDates $?prefferedExamDates)
		(OccupiedPrefferedExamDates $?occupiedExamDates ?discipline &~ no $?)
	)
	=>
	(printout t "Professor " ?IDProf " has exam on Day " (nth$ (+ (length$ $?occupiedExamDates) 1) $?prefferedExamDates) " at Discipline " ?discipline crlf)
)

(defrule PrintExamDatesProfessor_NoMatch
; Print a message when a specified Professor does not have any exams

	?ad <- (Print ExamDates Professor ?IDProf)
	(not (Professor
			(ID ?IDProf)
			(OccupiedPrefferedExamDates $? ?discipline &~ no $?)
		 )
	)
	=>
	(printout t "Professor " ?IDProf " does not have any exams" crlf)
)

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------- INFORMATION ---------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------

(defrule PrintInfoStudent
; Print Information about a specified Student

	?ad <- (Print Info Student ?IDStudent)
	(Student
		(ID ?IDStudent)
		(Name $?name)
		(Group ?group)
	)
	=>
	(printout t "Student " ?IDStudent ":" crlf)
	(printout t "Name: " $?name crlf)
	(printout t "Group: " ?group crlf)
	(assert (Print FinalGrades Student ?IDStudent))
	(assert (Print AverageFinalGrades Student ?IDStudent))
	(assert (Print Scholarship Student ?IDStudent))
	(assert (Print GuidingProf Student ?IDStudent))
	(retract ?ad)
)

(defrule PrintInfoProf
; Print Information about a specified Professor
	?ad <- (Print Info Professor ?IDProf)
	(Professor
		(ID ?IDProf)
		(Name $?name)
		(Disciplines $?disciplines)
	)
	=>
	(printout t "Professor " ?IDProf ":" crlf)
	(printout t "Name: " $?name crlf)
	(printout t "Disciplines: " $?disciplines crlf)
	(assert (Print ExamDates Professor ?IDProf))
	(assert (Print GuidingProf Professor ?IDProf))
	(retract ?ad)
)
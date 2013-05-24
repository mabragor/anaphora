;;;; This is the component of YACLANAPHT system.
;;;; See COPYING for details.

(in-package #:yaclanapht)

(defmacro! aif (test then &optional else)
  `(let ((,e!-it ,test))
     (if ,e!-it
	 ,then
	 ,@(if else `(,else)))))

(defmacro! awhen (test &body body)
  `(let ((,e!-it ,test))
     (when ,e!-it
       ,@body)))

(defmacro! apif (op test then &optional else)
  "Anaphoric-predicative if (i.e. it binds IT to
test, then uses OP to determine whether to go to THEN or
ELSE."
  `(let ((,e!-it ,test))
     (if (funcall ,op ,e!-it)
	 ,then
	 ,@(if else `(,else)))))

(defmacro! aand (&rest clauses)
  "Binds IT to the subsequent return-values of clauses.
Such that for each clause, return-value of previous one
is accessible through IT."
  (if clauses
      `(let ((,e!-it ,(car clauses)))
	 (and ,e!-it
	      (aand ,@(cdr clauses))))))

(defmacro! aandl (&rest clauses)
  "Like AAND, but IT is gradually consed list of
return-values of clauses."
  (labels ((rec (acc rev-clauses)
	     (if rev-clauses
		 (if (null acc)
		     (rec (car rev-clauses) (cdr rev-clauses))
		     (rec `(let ((,e!-it ,(car rev-clauses)))
			     (if ,e!-it
				 ,acc))
			  (cdr rev-clauses)))
		 `(let ((,e!-it `,nil))
		    ,acc))))
    (rec nil (reverse clauses))))
	 
(defmacro! acond-got (&body clauses)
  "Like COND, but assumes that all clauses predicates return 2 values: IT and GOT (like GETHASH function).
Clause succeeds, if GOT is T and IT is bound to the first value in the body of the clause."
  (let (result)
    (iter (for (predicate . body) in (reverse clauses))
	  (setf result (if (eq predicate t)
			   `(progn ,@body)
			   `(multiple-value-bind (,e!-it ,g!-got) ,predicate
			      (if ,g!-got
				  (progn ,@body)
				  ,result)))))
    result))

(defmacro! avcond-got (var &body clauses)
  "Anaphoric-variants ACOND-GOT."
  (let (result)
    (iter (for (predicate . body) in (reverse clauses))
	  (setf result (if (eq predicate t)
			   `(progn ,@body)
			   `(multiple-value-bind (,var ,g!-got) ,predicate
			      (if ,g!-got
				  (progn ,@body)
				  ,result)))))
    result))
	

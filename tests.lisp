;;;; Anaphora: The Anaphoric Macro Package from Hell
;;;; See LICENCE for details.

(defpackage #:yaclanapht-test-use
  (:use :cl :yaclanapht :rt))

(defpackage #:yaclanapht-test-no-use
  (:use :cl :rt))

(in-package :yaclanapht-test-use)

(deftest aif.1
    (aif (+ 1 2)
	 it
	 6)
  3)

(deftest apif.1
    (apif #'oddp (+ 1 2)
	  it
	  6)
  3)

(deftest aandl.1
    (aandl (+ 1 2)
	   (+ (car it) 5)
	   (+ (cadr it) 7))
  10)
  

(in-package :yaclanapht-test-no-use)

(deftest aif.1
    (a:aif (+ 1 2)
	   it
	   6)
  3)

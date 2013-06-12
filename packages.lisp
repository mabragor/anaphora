;;;; Part of YACLANAPHT software system
;;;; See COPYING for details.

(defpackage #:yaclanapht
  (:nicknames #:a)
  (:use #:cl #:defmacro-enhance #:iterate)
  (:export #:aif #:awhen #:apif #:avif #:aand #:aandl #:acond-got #:avcond-got)
  (:documentation "Collection of anaphoric macros from 'On Lisp' and 'Let Over Lambda'.
Distinct feature is that it interns IT (and other anaphoric symbols) directly into callee-package's
namespace."))

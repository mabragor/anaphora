;;;; Slight rewrite of anaphora's from hell
;;;; GPL'ed, so that everyone forever can benefit from this
;;;; Cause devils lurks in the details.
;;;; Nikodemus Siivola <nikodemus@random-state.net>
;;;; Alexander Popolitov <popolit@gmail.com>

;;;; Presumably, there is no contradiction between GPL and
;;;; preamble note in symbolic.lisp.
;;;; But if I'm in err, please, correct me (popolit).

(defsystem #:anaphora
    :version "0.9.5"
    :serial t
    :licence "GPL"
    :depends-on (#:defmacro-enhance)
    :components ((:file "packages")
		 (:file "early")
		 (:file "symbolic")
		 (:file "anaphora")))

(defsystem #:anaphora-test
    :depends-on (#:anaphora #:rt)
    :components ((:file "tests")))

(defmethod perform ((o test-op) (c (eql (find-system :anaphora))))
  (operate 'load-op :anaphora-test)
  (operate 'test-op :anaphora-test :force t))

(defmethod perform ((o test-op) (c (eql (find-system :anaphora-test))))
  (or (funcall (intern "DO-TESTS" :rt))
      (error "test-op failed")))

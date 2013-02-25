;;;; Part of YACLANAPHT software system.
;;;; See COPYING for details.

(defsystem #:yaclanapht
    :version "0.1"
    :serial t
    :licence "GPLv3"
    :depends-on (#:defmacro-enhance)
    :components ((:file "packages")
		 (:file "yaclanapht")))

(defsystem #:yaclanapht-test
    :depends-on (#:yaclanapht #:rt)
    :components ((:file "tests")))

(defmethod perform ((o test-op) (c (eql (find-system :yaclanapht))))
  (operate 'load-op :yaclanapht-test)
  (operate 'test-op :yaclanapht-test :force t))

(defmethod perform ((o test-op) (c (eql (find-system :yaclanapht-test))))
  (or (funcall (intern "DO-TESTS" :rt))
      (error "test-op failed")))

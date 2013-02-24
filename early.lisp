;;;; Anaphora: The Anaphoric Macro Package from Hell
;;;; See LICENCE for details.

(in-package :anaphora)

(defmacro ignore-first (first expr)
  (declare (ignore first))
  expr)

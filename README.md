anaphora
========

Anaphoric macros, as they should be.

In the original implementation, found in CVS and (currently 2013/02/24) found on quicklisp, following sequence on commands would not work.

        CL-USER> (ql:quickload 'anaphora)
        To load "anaphora":
          Load 1 ASDF system:
            anaphora
        ; Loading "anaphora"
        [package anaphora]................................
        [package anaphora-basic]..........................
        [package anaphora-symbol]
        (ANAPHORA)
        CL-USER> (anaphora:aif (+ 1 2) it 6)
        3

That is, library would not work correctly, unless you USE it.
Depending on the point of view, this is either a slight inconvenience,
or a serious drawback, since it forbids use of library in the
"script" context, when one does not want to create an asdf:system yet,
but is in the very beginning stage of experimental programming, yet,
wants to have the power of anaphoric macro at his disposal.

Requirement to USE a library also is a little bit buggy.
Since IT is shared among all using packages, suppose we have the code

        (in-package foo)
        
        (defparameter it nil "Insane, I know, but IT is now dynamical")
        
        (in-package bar)

        ;; This will probably not create what you want (the dynamic closure).
        (defun blah (x)
          (aif (+ 1 2)
            (lambda ()
              it)))

These two drawbacks are corrected in this version of the package, by
writing macros, that intern some symbols (here - IT) in the package, where
they are expanded, not defined.


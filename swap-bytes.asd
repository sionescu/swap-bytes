;;; -*- Mode: Lisp -*-

(defsystem :swap-bytes
  :depends-on (:trivial-features)
  :serial t
  :components ((:file "package")
               #+ccl (:file "ccl")
               #+sbcl (:file "sbcl-defknowns")
               #+sbcl (:file "sbcl-vops")
               #+sbcl (:file "sbcl")
               (:file "portable")))

;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

(defsystem :swap-bytes
  :depends-on (:trivial-features)
  :serial t
  :components ((:file "package")
               #+ccl (:file "ccl")
               #+sbcl (:sbcl-file "sbcl-defknowns")
               #+sbcl (:file "sbcl-vops")
               #+sbcl (:file "sbcl")
               (:file "portable")))

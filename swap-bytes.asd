;;; -*- Mode: Lisp -*-

(defpackage :swap-bytes-system
  (:use :common-lisp :asdf))
(in-package :swap-bytes-system)

;; ACHTUNG: Kludge. Redefining a DEFKNOWN signals an error ad load-time
;; which we try to ignore
#+sbcl
(defclass sbcl-file (cl-source-file) ())

#+sbcl
(defmethod perform ((o load-op) (c sbcl-file))
  (handler-bind ((simple-error
                  (lambda (e)
                    (let ((r (find-restart 'continue)))
                      (if r (invoke-restart r) (error e))))))
    (call-next-method)))

(defsystem :swap-bytes
  :depends-on (:trivial-features)
  :serial t
  :components ((:file "package")
               #+ccl (:file "ccl")
               #+sbcl (:sbcl-file "sbcl-defknowns")
               #+sbcl (:file "sbcl-vops")
               #+sbcl (:file "sbcl")
               (:file "portable")))

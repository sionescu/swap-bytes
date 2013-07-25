;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

(unless (or #+asdf3 (asdf/driver:version<= "2.29" (asdf-version)))
  (error "You need ASDF >= 2.29 to load this system correctly."))

(defsystem :swap-bytes
  :author "Stas Boukarev <stassats@gmail.com>"
  :maintainer "Stelian Ionescu <sionescu@cddr.org>"
  :description "Optimized byte-swapping primitives"
  :licence "MIT"
  :defsystem-depends-on (:madeira-port :trivial-features)
  :depends-on (:trivial-features)
  :components ((:file "package")
               (:madeira-port "ccl"
                :when (:and :ccl (:or :x86 :x86-64))
                :depends-on ("package"))
               (:madeira-port "sbcl-defknowns"
                :when (:and :sbcl (:or :x86 :x86-64))
                :depends-on ("package"))
               (:madeira-port "sbcl-vops"
                :when (:and :sbcl (:or :x86 :x86-64))
                :depends-on ("package" "sbcl-defknowns"))
               (:madeira-port "sbcl"
                :when (:and :sbcl (:or :x86 :x86-64))
                :depends-on ("package" "sbcl-defknowns" "sbcl-vops"))
               (:madeira-port "portable"
                :when (:not (:or (:and :ccl (:or :x86 :x86-64))
                                 (:and :sbcl (:or :x86 :x86-64))))
                :depends-on ("package" "ccl" "sbcl"))))

(asdf:defsystem :swap-bytes/test
  :depends-on (:swap-bytes :fiveam)
  :components ((:file "test")))

(defmethod asdf:perform ((o asdf:test-op)
                         (c (eql (asdf:find-system :swap-bytes))))
  (asdf:load-system :swap-bytes/test :force '(:swap-bytes/test))
  (asdf/package:symbol-call :5am :run! :swap-bytes))

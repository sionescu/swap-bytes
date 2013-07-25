;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

(defsystem :swap-bytes
  :defsystem-depends-on (:madeira-port :trivial-features)
  :depends-on (:trivial-features)
  :serial t
  :components ((:file "package")
               (:madeira-port "ccl"
                :when (:and :ccl (:or :x86 :x86-64)))
               (:madeira-port "sbcl-defknowns"
                :when (:and :sbcl (:or :x86 :x86-64)))
               (:madeira-port "sbcl-vops"
                :when (:and :sbcl (:or :x86 :x86-64)))
               (:madeira-port "sbcl"
                :when (:and :sbcl (:or :x86 :x86-64)))
               (:madeira-port "portable"
                :when (:not (:or (:and :ccl (:or :x86 :x86-64))
                                 (:and :sbcl (:or :x86 :x86-64)))))))

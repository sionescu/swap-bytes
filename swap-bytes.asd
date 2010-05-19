(defsystem :swap-bytes
  :depends-on (:trivial-features)
  :serial t
  :components ((:file "package")
               #+sbcl (:file "sbcl")
               (:file "portable")))

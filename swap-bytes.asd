(defsystem :swap-bytes
  :serial t
  :components ((:file "package")
               #+sbcl (:file "sbcl")
               (:file "portable")))

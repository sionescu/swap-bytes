
(asdf:defsystem swap-bytes
  :serial t
  :components ((:file "package")
               . 
               #+(and sbcl (or x86 x86-64))
               ((:file "sbcl-defknown")
                (:file "sbcl-vops")
                (:file "sbcl"))

               #-(and sbcl (or x86 x86-64))
               ((:file "portable"))))

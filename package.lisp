(defpackage :swap-bytes
  (:use #:cl .
        #+(and sbcl (or x86 x86-64)) (#:sb-c #:sb-assem))
  (:export #:swap-bytes-16 #:swap-bytes-32 #:swap-bytes-64
           #:htons #:ntohs #:htonl #:ntohl #:htonq #:ntohq))

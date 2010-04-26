(defpackage #:swap-bytes
  (:use #:cl)
  (:export #:swap-bytes-32 #:swap-bytes-64))

(in-package #:swap-bytes)

(declaim (inline swap-bytes-32))
(defun swap-bytes-32 (integer)
  (declare (type (unsigned-byte 32) integer))
  (logior (ash (logand #xFF integer) 24)
          (ash (logand #xFF00 integer) 8)
          (ash (logand #xFF0000 integer) -8)
          (ash integer -24)))

(declaim (inline swap-bytes-64))
(defun swap-bytes-64 (integer)
  (declare (type (unsigned-byte 64) integer))
  (macrolet ((shift (mask shift)
               `(ash (logand ,mask integer) ,shift)))
    (logior
     (shift #xFF 56)
     (shift #xFF00 40)
     (shift #xFF0000 24)
     (shift #xFF000000 8)
     (shift #xFF00000000 -8)
     (shift #xFF0000000000 -24)
     (shift #xFF000000000000 -40)
     (ash integer -56))))

(in-package :swap-bytes)

#+(or x86 x86-64)
(declaim (inline swap-bytes-32))
#+(or x86 x86-64)
(defun swap-bytes-32 (integer)
  (%swap-bytes-32 integer))

#+(or x86-64)
(declaim (inline swap-bytes-64))
#+(or x86-64)
(defun swap-bytes-64 (integer)
  (%swap-bytes-64 integer))

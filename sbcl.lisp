(in-package #:swap-bytes)

(declaim (inline swap-bytes-32))
(defun swap-bytes-32 (integer)
  (%swap-bytes-32 integer))

(declaim (inline swap-bytes-64))
(defun swap-bytes-64 (integer)
  (%swap-bytes-64 integer))

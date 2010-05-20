;;; -*- Mode: Lisp -*-

;;; This software is in the public domain and is
;;; provided with absolutely no warranty.

(in-package :swap-bytes)

#+(or x86 x86-64)
(defun swap-bytes-16 (integer)
  (declare (type (unsigned-byte 16) integer))
  (swap-bytes-16 integer))

#+(or x86 x86-64)
(defun swap-bytes-32 (integer)
  (declare (type (unsigned-byte 32) integer))
  (swap-bytes-32 integer))

#+(or x86-64)
(defun swap-bytes-64 (integer)
  (declare (type (unsigned-byte 64) integer))
  (%swap-bytes-64 integer))

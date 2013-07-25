;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

;;; This software is in the public domain and is
;;; provided with absolutely no warranty.

(in-package :swap-bytes)

#+x86
(defun swap-bytes-16 (integer)
  (declare (type (unsigned-byte 16) integer))
  (swap-bytes-16 integer))

(defun swap-bytes-32 (integer)
  (declare (type (unsigned-byte 32) integer))
  (swap-bytes-32 integer))

#+x86-64
(defun swap-bytes-64 (integer)
  (declare (type (unsigned-byte 64) integer))
  (swap-bytes-64 integer))

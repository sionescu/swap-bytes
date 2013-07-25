;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

(in-package :swap-bytes)

#-(and sbcl x86)
(declaim (inline swap-bytes-16))
#-(and sbcl x86)
(defun swap-bytes-16 (integer)
  (declare (type (unsigned-byte 16) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  (logior (ash (logand #xFF integer)  8)
          (ash integer -8)))

#-(and sbcl (or x86 x86-64))
(declaim (inline swap-bytes-32))
#-(and sbcl (or x86 x86-64))

(defun swap-bytes-32 (integer)
  (declare (type (unsigned-byte 32) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  (logior (ash (logand #x0000FF integer)  24)
          (ash (logand #x00FF00 integer)   8)
          (ash (logand #xFF0000 integer)  -8)
          (ash                  integer  -24)))

#-(and sbcl x86-64)
(declaim (inline swap-bytes-64))
#-(and sbcl x86-64)
(defun swap-bytes-64 (integer)
  (declare (type (unsigned-byte 64) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  (macrolet ((shift (mask shift)
               `(ash (logand ,mask integer) ,shift)))
    (logior
     (shift #x000000000000FF  56)
     (shift #x0000000000FF00  40)
     (shift #x00000000FF0000  24)
     (shift #x000000FF000000   8)
     (shift #x0000FF00000000  -8)
     (shift #x00FF0000000000 -24)
     (shift #xFF000000000000 -40)
     (ash integer -56))))


(declaim (inline htons))
(defun htons (integer)
  "Convert (unsigned-byte 16) from host order(little- or big-endian)
to network order(always big-endian)."
  (declare (type (unsigned-byte 16) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  #+little-endian (swap-bytes-16 integer)
  #+big-endian    integer)

(declaim (inline ntohs))
(defun ntohs (integer)
  "Convert (unsigned-byte 16) from network order(always big-endian) to
host order(little- or big-endian)."
  (declare (type (unsigned-byte 16) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  #+little-endian (swap-bytes-16 integer)
  #+big-endian    integer)

(declaim (inline htonl))
(defun htonl (integer)
  "Convert (unsigned-byte 32) from host order(little- or big-endian)
to network order(always big-endian)."
  (declare (type (unsigned-byte 32) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  #+little-endian (swap-bytes-32 integer)
  #+big-endian    integer)

(declaim (inline ntohl))
(defun ntohl (integer)
  "Convert (unsigned-byte 32) from network order(always big-endian) to
host order(little- or big-endian)."
  (declare (type (unsigned-byte 32) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  #+little-endian (swap-bytes-32 integer)
  #+big-endian    integer)

(declaim (inline htonq))
(defun htonq (integer)
  "Convert (unsigned-byte 64) from host order(little- or big-endian)
to network order(always big-endian)."
  (declare (type (unsigned-byte 64) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  #+little-endian (swap-bytes-64 integer)
  #+big-endian    integer)

(declaim (inline ntohq))
(defun ntohq (integer)
  "Convert (unsigned-byte 64) from network order(always big-endian) to
host order(little- or big-endian)."
  (declare (type (unsigned-byte 64) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  #+little-endian (swap-bytes-64 integer)
  #+big-endian    integer)


(deftype endianness ()
  '(member :big-endian :little-endian))

(deftype endianness-designator ()
  '(member :big-endian :little-endian :network :local))

(defconstant +endianness+
  #+big-endian    :big-endian
  #+little-endian :little-endian)

(defun endianness (endianness)
  (check-type endianness endianness-designator)
  (case endianness
    (:local   +endianness+)
    (:network :big-endian)
    (t        endianness)))

(defun find-swap-byte-function (&key size from (to :local))
  (let ((from (endianness from))
        (to   (endianness to)))
    (if (eql from to)
        'identity
        (ecase size
          (1 'identity)
          (2 'swap-bytes-16)
          (4 'swap-bytes-32)
          (8 'swap-bytes-64)))))

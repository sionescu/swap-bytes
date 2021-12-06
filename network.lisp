;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

(in-package :swap-bytes)

(declaim (inline htons ntohs htonl ntohl htonq ntohq))

(defun htons (integer)
  "Convert (unsigned-byte 16) from host order(little- or big-endian)
to network order(always big-endian)."
  (declare (type (unsigned-byte 16) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  #+little-endian (swap-bytes-16 integer)
  #+big-endian    integer)

(defun ntohs (integer)
  "Convert (unsigned-byte 16) from network order(always big-endian) to
host order(little- or big-endian)."
  (declare (type (unsigned-byte 16) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  #+little-endian (swap-bytes-16 integer)
  #+big-endian    integer)

(defun htonl (integer)
  "Convert (unsigned-byte 32) from host order(little- or big-endian)
to network order(always big-endian)."
  (declare (type (unsigned-byte 32) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  #+little-endian (swap-bytes-32 integer)
  #+big-endian    integer)

(defun ntohl (integer)
  "Convert (unsigned-byte 32) from network order(always big-endian) to
host order(little- or big-endian)."
  (declare (type (unsigned-byte 32) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  #+little-endian (swap-bytes-32 integer)
  #+big-endian    integer)

(defun htonq (integer)
  "Convert (unsigned-byte 64) from host order(little- or big-endian)
to network order(always big-endian)."
  (declare (type (unsigned-byte 64) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  #+little-endian (swap-bytes-64 integer)
  #+big-endian    integer)

(defun ntohq (integer)
  "Convert (unsigned-byte 64) from network order(always big-endian) to
host order(little- or big-endian)."
  (declare (type (unsigned-byte 64) integer)
           (optimize (speed 3) (safety 0) (debug 0)))
  #+little-endian (swap-bytes-64 integer)
  #+big-endian    integer)


;; from DBUS-lisp
(defun signed-to-unsigned (value size)
  "Return the unsigned representation of a signed byte with a given
size."
  (declare (type integer value size))
  (ldb (byte size 0) value))

(defun unsigned-to-signed (value size)
  "Return the signed representation of an unsigned byte with a given
size."
  (declare (type integer value size))
  (if (logbitp (1- size) value)
      (dpb value (byte size 0) -1)
      value))

(defun hton (x x-type)
  (declare (type real x))
  (declare (type keyword x-type))
  (ecase x-type
    (:uint8 (the uint8 x))
    (:sint8 (the uint8 (signed-to-unsigned x 8)))
    (:uint16 (the uint16 (htons x)))
    (:sint16 (the uint16 (htons (signed-to-unsigned x 16))))
    (:uint32 (the uint32 (htonl x)))
    (:sint32 (the uint32 (htonl (signed-to-unsigned x 32))))
    (:uint64 (the uint64 (htonq x)))
    (:sint64 (the uint64 (htonq (signed-to-unsigned x 64))))
    (:float32 (the uint32 (htonl (encode-float32 x))))
    (:float64 (the uint64 (htonq (encode-float64 x))))))

(defun ntoh (x x-type)
  (declare (type real x))
  (declare (type keyword x-type))
  (ecase x-type
    (:uint8  (the uint8 x))
    (:sint8  (the sint8 (unsigned-to-signed x 8)))
    (:uint16  (the uint16 (ntohs x)))
    (:sint16  (the sint16 (unsigned-to-signed (ntohs x) 16)))
    (:uint32  (the uint32 (ntohl x)))
    (:sint32  (the sint32 (unsigned-to-signed (ntohl x) 32)))
    (:uint64  (the uint64 (ntohq x)))
    (:sint64  (the sint64 (unsigned-to-signed (ntohq x) 64)))
    (:float32  (the single-float (decode-float32 (ntohl x))))
    (:float64  (the double-float (decode-float64 (ntohq x))))))

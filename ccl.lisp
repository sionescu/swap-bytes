;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

(in-package :ccl)

(defx8632lapfunction swap-bytes::%swap-bytes-16 ((unsigned-byte arg_z))
  (xchg  (% arg_z.bh)
         (% arg_z.b))
  (single-value-return))

(defx8632lapfunction swap-bytes::%swap-bytes-32 ((integer arg_z))
  (bswapl (% arg_z))
  (single-value-return))

(defx86lapfunction swap-bytes::%swap-bytes-64 ((integer arg_z))
  (bswapq (% arg_z))
  (single-value-return))

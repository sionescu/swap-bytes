;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

(in-package :swap-bytes)

(ccl::defx8632lapfunction %swap-bytes-16 ((unsigned-byte arg_z))
  (xchg  (% arg_z.bh)
         (% arg_z.b))
  (single-value-return))

(ccl::defx8632lapfunction %swap-bytes-32 ((integer arg_z))
  (bswapl (% arg_z))
  (single-value-return))

(ccl::defx86lapfunction %swap-bytes-64 ((integer arg_z))
  (bswapq (% arg_z))
  (single-value-return))

;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

;;; This software is in the public domain and is
;;; provided with absolutely no warranty.

(in-package :swap-bytes)

#+(or x86 x86_64)
(ccl::defx8632lapfunction %swap-bytes-16 ((fixnum arg_z))
  (unbox-fixnum fixnum imm0)
  (xchg (% ah) (% al))
  (box-fixnum imm0 fixnum)
  (single-value-return))

#+x8632-target
(ccl::defx8632lapfunction %swap-bytes-32 ((number arg_z))
  ; Extract the u32 from the number, swap the bytes, make and return
  ; a bignum.
  (save-simple-frame)
  (call-subprim .SPgetu32)
  (bswapl (% imm0))
  (restore-simple-frame)
  (jmp-subprim .SPmakeu32))

#+x8664-target
(ccl::defx86lapfunction %swap-bytes-32 ((fixnum arg_z))
  (unbox-fixnum fixnum imm0)
  (bswapl (% eax))
  (box-fixnum imm0 fixnum)
  (single-value-return))

#+x8632-target
(ccl::defx8632lapfunction %swap-bytes-64 ((number arg_z))
  ; Extract the u64 from the number (either a fixnum or, most certainly,
  ; a bignum) in the MM0 register, swap the bytes in the two doublewords,
  ; move them again to the MM0 register, make and return a bignum.
  (save-simple-frame)
  (call-subprim .SPgetu64)
  (movd (% mm0) (% imm0))  ; imm0 = low part
  (psrlq ($ 32) (% mm0))   ; shift high doubleword to low
  (movd (% mm0) (% temp0)) ; temp0 = high part
  (bswapl (% imm0))        ; swap low part bytes
  (movd (% imm0) (% mm0))  ; mm0 = low part
  (bswapl (% temp0))       ; swap high part bytes
  (movd (% temp0) (% mm1)) ; mm1 = high part
  (psllq ($ 32) (% mm0))   ; shift low doubleword to high
  (paddq (% mm1) (% mm0))  ; add both parts into mm0
  (restore-simple-frame)
  (jmp-subprim .SPmakeu64))

#+x8664-target
(ccl::defx86lapfunction %swap-bytes-64 ((number arg_z))
  ; Extract the u64 from the number (either a fixnum or bignum), swap the
  ; bytes, make and return a bignum.
  (save-simple-frame)
  (call-subprim .SPgetu64)
  (bswapq (% imm0))
  (restore-simple-frame)
  (jmp-subprim .SPmakeu64))

(defun swap-bytes-16 (integer)
  (declare (type (unsigned-byte 16) integer))
  (%swap-bytes-16 integer))

(defun swap-bytes-32 (integer)
  (declare (type (unsigned-byte 32) integer))
  (%swap-bytes-32 integer))

(defun swap-bytes-64 (integer)
  (declare (type (unsigned-byte 64) integer))
  (%swap-bytes-64 integer))

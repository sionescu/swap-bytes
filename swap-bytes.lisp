(defpackage #:sb-swap-bytes
  (:use #:cl #:sb-c #:sb-assem)
  (:export #:swap-bytes))

(in-package #:sb-swap-bytes)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defknown %swap-bytes ((unsigned-byte 32)) (unsigned-byte 32)
      (movable foldable flushable)))

(define-vop (%32bit-swap-bytes/c)
  (:policy :fast-safe)
  (:translate %swap-bytes)
  (:note "inline 32-bit swap bytes")
  (:args (integer :scs (sb-vm::unsigned-reg) :target res))
  (:arg-types sb-vm::unsigned-byte-32)
  (:results (res :scs (sb-vm::unsigned-reg)))
  (:result-types sb-vm::unsigned-byte-32)
  (:generator 5
              (move res integer)
              (inst bswap res)))

(declaim (inline swap-bytes))
(defun swap-bytes (integer)
  (%swap-bytes integer))



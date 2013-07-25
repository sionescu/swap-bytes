;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

(in-package :swap-bytes)

#+x86
(define-vop (16bit-swap-bytes)
  (:policy :fast-safe)
  (:translate %swap-bytes-16)
  (:note "inline 16-bit swap bytes")
  (:args (integer :scs (sb-vm::unsigned-reg) :target eax))
  (:arg-types sb-vm::unsigned-num)
  (:temporary (:sc sb-vm::unsigned-reg
                   :offset sb-vm::eax-offset :target res
                   :from (:argument 0) :to (:result 0))
              eax)
  (:results (res :scs (sb-vm::unsigned-reg)))
  (:result-types sb-vm::unsigned-num)
  (:generator 2
              (move eax integer)
              (inst xchg sb-vm::al-tn sb-vm::ah-tn)
              (move res eax)))

#+x86
(define-vop (32bit-swap-bytes)
  (:policy :fast-safe)
  (:translate %swap-bytes-32)
  (:note "inline 32-bit swap bytes")
  (:args (integer :scs (sb-vm::unsigned-reg) :target res))
  (:arg-types sb-vm::unsigned-byte-32)
  (:results (res :scs (sb-vm::unsigned-reg)))
  (:result-types sb-vm::unsigned-byte-32)
  (:generator 2
              (move res integer)
              (inst bswap res)))

#+x86-64
(define-vop (32bit-swap-bytes)
  (:policy :fast-safe)
  (:translate %swap-bytes-32)
  (:note "inline 32-bit swap bytes")
  (:args (integer :scs (sb-vm::unsigned-reg) :target res))
  (:arg-types sb-vm::unsigned-num)
  (:results (res :scs (sb-vm::unsigned-reg)))
  (:result-types sb-vm::unsigned-num)
  (:generator 2
              (move res integer)
              (inst bswap (sb-vm::reg-in-size res :dword))))

#+x86-64
(define-vop (64bit-swap-bytes)
  (:policy :fast-safe)
  (:translate %swap-bytes-64)
  (:note "inline 64-bit swap bytes")
  (:args (integer :scs (sb-vm::unsigned-reg) :target res))
  (:arg-types sb-vm::unsigned-byte-64)
  (:results (res :scs (sb-vm::unsigned-reg)))
  (:result-types sb-vm::unsigned-byte-64)
  (:generator 2
              (move res integer)
              (inst bswap res)))

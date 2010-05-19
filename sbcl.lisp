(in-package :swap-bytes)

#+(or x86 x86-64)
(defknown %swap-bytes-32 ((unsigned-byte 32)) (unsigned-byte 32)
    (movable foldable flushable))

#+x86
(define-vop (%32bit-swap-bytes)
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
(define-vop (%32bit-swap-bytes)
  (:policy :fast-safe)
  (:translate %swap-bytes-32)
  (:note "inline 64-bit swap bytes")
  (:args (integer :scs (sb-vm::unsigned-reg) :target res))
  (:arg-types sb-vm::unsigned-num)
  (:results (res :scs (sb-vm::unsigned-reg)))
  (:result-types sb-vm::unsigned-num)
  (:generator 2
              (move res integer)
              (inst bswap (sb-vm::reg-in-size res :dword))))

#+(or x86-64)
(defknown %swap-bytes-64 ((unsigned-byte 64)) (unsigned-byte 64)
    (movable foldable flushable))

#+x86-64
(define-vop (%64bit-swap-bytes)
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

#+(or x86 x86-64)
(declaim (inline swap-bytes-32))
#+(or x86 x86-64)
(defun swap-bytes-32 (integer)
  (%swap-bytes-32 integer))

#+(or x86-64)
(declaim (inline swap-bytes-64))
#+(or x86-64)
(defun swap-bytes-64 (integer)
  (%swap-bytes-64 integer))

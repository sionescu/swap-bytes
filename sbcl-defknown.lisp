
(in-package #:swap-bytes)

(defknown %swap-bytes-32 ((unsigned-byte 32)) (unsigned-byte 32)
    (movable foldable flushable))

(defknown %swap-bytes-64 ((unsigned-byte 64)) (unsigned-byte 64)
      (movable foldable flushable))
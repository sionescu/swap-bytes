;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

;;; This software is in the public domain and is
;;; provided with absolutely no warranty.

(setf *print-array* nil)

(declaim (inline swap-bytes-16-portable))
(defun swap-bytes-16-portable (integer)
  (declare (type (unsigned-byte 16) integer))
  (logior (ash (logand #xFF integer) 8)
          (ash integer -8)))

(declaim (inline swap-bytes-32-portable))
(defun swap-bytes-32-portable (integer)
  (declare (type (unsigned-byte 32) integer))
  (logior (ash (logand #xFF integer) 24)
          (ash (logand #xFF00 integer) 8)
          (ash (logand #xFF0000 integer) -8)
          (ash integer -24)))

(declaim (inline swap-bytes-64-portable))
(defun swap-bytes-64-portable (integer)
  (declare (type (unsigned-byte 64) integer))
  (macrolet ((shift (mask shift)
               `(ash (logand ,mask integer) ,shift)))
    (logior
     (shift #xFF 56)
     (shift #xFF00 40)
     (shift #xFF0000 24)
     (shift #xFF000000 8)
     (shift #xFF00000000 -8)
     (shift #xFF0000000000 -24)
     (shift #xFF000000000000 -40)
     (ash integer -56))))

(defparameter *v-16*
  (let ((i 0))
    (map-into (make-array 10000000 :element-type '(unsigned-byte 16))
              (lambda () (mod (incf i) 65536)))))


(defun test-16 (vector)
  (declare (type (simple-array (unsigned-byte 16) (*))
                 vector))
  (loop for i below (length vector)
        do (setf (aref vector i)
                 (swap-bytes:swap-bytes-16
                  (aref vector i)))))

(defun test-16-p (vector)
  (declare (type (simple-array (unsigned-byte 16) (*))
                 vector))
  (loop for i below (length vector)
        do (setf (aref vector i)
                 (swap-bytes-16-portable
                  (aref vector i)))))

;;;

(defparameter *v-32*
  (let ((i 0))
    (map-into (make-array 10000000 :element-type '(unsigned-byte 32))
              (lambda () (incf i)))))

(defun test-32 (vector)
  (declare (type (simple-array (unsigned-byte 32) (*))
                 vector))
  (loop for i below (length vector)
        do (setf (aref vector i)
                 (swap-bytes:swap-bytes-32
                  (aref vector i)))))

(defun test-32-p (vector)
  (declare (type (simple-array (unsigned-byte 32) (*))
                 vector))
  (loop for i below (length vector)
        do (setf (aref vector i)
                 (swap-bytes-32-portable
                  (aref vector i)))))
#+x86-64
(progn
  (defparameter *v-64*
    (let ((i 0))
      (map-into (make-array 10000000 :element-type '(unsigned-byte 64))
                (lambda () (incf i)))))

 (defun test-64 (vector)
   (declare (type (simple-array (unsigned-byte 64) (*))
                  vector))
   (loop for i below (length vector)
         do (setf (aref vector i)
                  (swap-bytes:swap-bytes-64
                   (aref vector i)))))

 (defun test-64-p (vector)
   (declare (type (simple-array (unsigned-byte 64) (*))
                  vector))
   (loop for i below (length vector)
         do (setf (aref vector i)
                  (swap-bytes-64-portable
                   (aref vector i))))))

(in-package #:swap-bytes)

(defpackage #:swap-bytes-test
  (:use #:cl #:fiveam #:swap-bytes)
  (:export #:run-tests))

(in-package #:swap-bytes-test)

(def-suite swap-bytes)
(in-suite swap-bytes)

(defparameter +test-table+
  '((#xcafe #xfeca swap-bytes-16)
    (#xf457 #x57f4 swap-bytes-16)
    (#x0000 #x0000 swap-bytes-16)
    (#xffff #xffff swap-bytes-16)
    (#xcafedead #xaddefeca swap-bytes-32)
    (#xb116b00b #x0bb016b1 swap-bytes-32)
    (#xbe47dead #xadde47be swap-bytes-32)
    (#xdeadbeef #xefbeadde swap-bytes-32)
    (#x00000000 #x00000000 swap-bytes-32)
    (#xffffffff #xffffffff swap-bytes-32)
    (#xb116b00b1ee7babe #xbebae71e0bb016b1 swap-bytes-64)
    (#xdeadbeefcafebabe #xbebafecaefbeadde swap-bytes-64)
    (#x0000000000000000 #x0000000000000000 swap-bytes-64)
    (#xffffffffffffffff #xffffffffffffffff swap-bytes-64)))

(test identity
  "Swapping a number twice gives the identity"
  (loop for (num snum fun) in +test-table+
     do (is (= (funcall fun (funcall fun num)) num))))

(test simple
  "Simple values"
  (loop for (num snum fun) in +test-table+
     do (is (= (funcall fun num) snum))))

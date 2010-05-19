
#+(or x86 x86_64)
(ccl::defx8632lapfunction %swap-bytes-16 ((unsigned-byte arg_z))
  (xchg  (% arg_z.bh)
         (% arg_z.b))
  (single-value-return))


#+(or x86 x86_64)
(ccl::defx8632lapfunction %swap-bytes-32 ((integer arg_z))
  (bswapl (% arg_z))
  (single-value-return))

#+x86_64
(ccl::defx86lapfunction %swap-bytes-64 ((integer arg_z))
  (bswapq (% arg_z))
  (single-value-return))


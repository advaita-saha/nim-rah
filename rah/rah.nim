{.passL: "-L. -lrah".}

{.push importc, cdecl.}
proc rah_request_mem(appid: cint, size: csize_t): pointer
proc rah_free_mem(p: pointer)
proc rah_write_mem(appid: cint, buf: pointer, len: csize_t): cint
proc rah_read(appid: cint, dst: pointer, len: csize_t): cint
proc rah_max_buffer_size(): csize_t
proc rah_clear_buffer(appid: cint)
{.pop.}

proc getMaxBufferSize*(): int =
  result = int rah_max_buffer_size()

proc rahWrite*(appid: int, data: openArray[byte]) =
  let maxn = int rah_max_buffer_size()
  var off = 0
  while off < data.len:
    let n = min(maxn, data.len - off)          # n is an int for Nim-side ops
    let dst = rah_request_mem(cint appid, csize_t(n))
    if dst.isNil:
      raise newException(OutOfMemDefect, "rah_request_mem returned nil")
    copyMem(dst, unsafeAddr data[off], Natural(n))  # copyMem expects Natural
    discard rah_write_mem(cint appid, dst, csize_t(n))
    rah_free_mem(dst)
    off += n

proc rahRead*(appid: int, n: int): seq[byte] =
  result = newSeq[byte](n)
  discard rah_read(cint appid, result[0].addr, csize_t(n))

proc rahClearBuffer*(appid: int) =
  rah_clear_buffer(cint appid)
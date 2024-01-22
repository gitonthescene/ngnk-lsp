"""Interface to ngn/k ffi."""

import struct
import ctypes as c
import sys
dll = "dylib" if sys.platform == 'darwin' else 'so'
k = c.CDLL(f'libk.{dll}')

K   = c.c_void_p
K_p = c.POINTER(K)
K2f = c.CFUNCTYPE(K,K,K)

ref  = k.ref;     ref.restype=K;     ref.argtypes=[K]
unref = k.unref; unref.restype=None;unref.argtypes=[K]

NK  = k.NK;NK.restype=c.c_int;NK.argtypes=[K]
iK  = k.iK;iK.restype=c.c_int;iK.argtypes=[K]
IK_ = k.IK;                  IK_.argtypes=[c.c_char_p,K]
CK_ = k.CK;                  CK_.argtypes=[c.c_char_p,K]
Ki  = k.Ki;Ki.restype=K;     Ki.argtypes=[c.c_int]
KC_ = k.KC;KC_.restype=K;    KC_.argtypes=[c.c_char_p,c.c_int]

K0  = k.K0;K0.restype=K;     K0.argtypes=[K_p,c.c_char_p,K_p,c.c_int]
KR  = k.KR;KR.restype=K;     KR.argtypes=[c.c_char_p,K2f,c.c_int]


def Kx(evl, args):
    """Eval k string with args."""
    return K0(c.byref(K()), evl.encode("utf-8"), args if args else None, len(args))


def extract(api, factor, fmt):
    """Extract k values into Python tuples."""
    def fn(kval):
        sz = NK(kval)
        dsz = sz * factor
        buf = bytearray(dsz)
        api((c.c_char*dsz).from_buffer(buf), kval)
        if fmt == 'B':
            return buf
        return struct.unpack(f'{sz}{fmt}', buf)
    return fn


IK = extract(IK_, 4, 'I')
CK = extract(CK_, 1, 'B')


def convert(api, factor):
    """Convert bytearrays into k values."""
    def fn(val, sz):
        dsz = sz * factor
        return k.KC((c.c_char*dsz).from_buffer(val), sz)
    return fn


KC = convert(KC_, 1)

k.kinit()

"""
Find anomalous elliptic curves (trace of Frobenius = 1).

An elliptic curve E/GF(p) is anomalous when #E(GF(p)) = p.
This script provides two methods:

1. Brute-force search over small primes: try all (a, b) pairs
   until #E = p.
2. CM construction for large primes: use the theory of complex
   multiplication to construct anomalous curves directly.
   For j=0 (discriminant D=-3), an anomalous curve exists when
   4p = 1 + 3*s^2 for odd s, giving y^2 = x^3 + b.

References:
  J. Monnerat, "Generating Anomalous Elliptic Curves", EPFL,
  2002. http://www.monnerat.info/publications/anomalous.pdf

  D. Bernstein and T. Lange, "SafeCurves: choosing safe curves
  for elliptic-curve cryptography".
  https://safecurves.cr.yp.to/

  The CM construction follows Section 18.1 of H. Cohen,
  "A Course in Computational Algebraic Number Theory",
  Springer GTM 138, 1993.

Usage:
  sage find_anomalous_curves.sage
"""


def find_small(p, require_a_nonzero=False):
    """
    Find an anomalous curve over GF(p) by brute-force search.
    Practical for primes up to a few hundred.

    INPUT:
    - p: a prime number
    - require_a_nonzero: if True, skip curves with a=0

    OUTPUT:
    - (a, b) such that #E(GF(p)) = p for y^2 = x^3 + ax + b,
      or None if not found
    """
    F = GF(p)
    start_a = 1 if require_a_nonzero else 0
    for a in range(start_a, p):
        for b in range(p):
            if (4 * a^3 + 27 * b^2) % p == 0:
                continue
            E = EllipticCurve(F, [a, b])
            if E.order() == p:
                return (a, b)
    return None


def find_large_cm(target_bits, max_attempts=50000):
    """
    Construct an anomalous curve over a prime of approximately
    target_bits bits using CM with j=0 (discriminant D=-3).

    For trace t=1: 4p = t^2 + 3*s^2 = 1 + 3*s^2.
    We need s odd for p = (1 + 3*s^2)/4 to be an integer.
    The resulting curve is y^2 = x^3 + b for some small b.

    INPUT:
    - target_bits: desired bit-length of the prime
    - max_attempts: number of values of s to try

    OUTPUT:
    - (p, a, b) where a=0 and #E(GF(p)) = p, or None
    """
    # Start s near 2^(target_bits/2) so that p ~ 2^target_bits
    s_start = ZZ(2)^(target_bits // 2)
    if s_start % 2 == 0:
        s_start += 1

    for delta in range(0, max_attempts, 2):
        s = s_start + delta
        p_candidate = (1 + 3 * s^2) // 4
        if not p_candidate.is_prime():
            continue
        if p_candidate.nbits() < target_bits - 1:
            continue
        F = GF(p_candidate)
        # Try small values of b for y^2 = x^3 + b
        for b_val in range(1, 30):
            try:
                E = EllipticCurve(F, [0, b_val])
                if E.order() == p_candidate:
                    return (p_candidate, 0, b_val)
            except ArithmeticError:
                continue
    return None


if __name__ == "__main__":
    print("=== Small primes (brute-force) ===")
    print()
    for p in [31, 43, 53, 97, 157, 181]:
        result = find_small(p)
        if result:
            a, b = result
            print(
                "p=%d: y^2 = x^3 + %d*x + %d" % (p, a, b)
            )
        # Also find one with a != 0 if the first had a=0
        result_nz = find_small(p, require_a_nonzero=True)
        if result_nz and result_nz != result:
            a, b = result_nz
            print(
                "p=%d: y^2 = x^3 + %d*x + %d (a != 0)"
                % (p, a, b)
            )

    print()
    print("=== Large primes (CM construction, j=0) ===")
    print()
    for bits in [128, 192, 256, 381]:
        result = find_large_cm(bits)
        if result:
            p, a, b = result
            print(
                "%d-bit: y^2 = x^3 + %d*x + %d"
                % (p.nbits(), a, b)
            )
            print("  p = %d" % p)
        else:
            print(
                "%d-bit: no curve found" % bits
            )

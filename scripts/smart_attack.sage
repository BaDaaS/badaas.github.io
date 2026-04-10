"""
Smart's attack on anomalous elliptic curves.

Solves the ECDLP in linear time when #E(F_p) = p, using the
p-adic formal group logarithm.

Reference:
  Nigel Smart, "The Discrete Logarithm Problem on Elliptic
  Curves of Trace One", Journal of Cryptology, 1999.
"""


def smart_attack(P, Q, p):
    """
    Solve Q = n*P on an anomalous curve E/GF(p)
    using the p-adic formal group logarithm.

    INPUT:
    - P: a point on E(GF(p)), the generator
    - Q: a point on E(GF(p)), the target
    - p: the prime defining the base field

    OUTPUT:
    - n such that Q = n * P
    """
    E = P.curve()
    Ep = EllipticCurve(Qp(p, 5), [Qp(p, 5)(a) for a in E.a_invariants()])

    # Lift points to Q_p
    P_lift = Ep.lift_x(Qp(p, 5)(int(P.xy()[0])))
    Q_lift = Ep.lift_x(Qp(p, 5)(int(Q.xy()[0])))

    # Compute p * lifted_point, extract formal group element
    pP = p * P_lift
    pQ = p * Q_lift

    # Read off the formal logarithm from the x/y coordinate
    log_P = -pP.xy()[0] / pP.xy()[1]
    log_Q = -pQ.xy()[0] / pQ.xy()[1]

    # Discrete log is now just division in Q_p
    n = log_Q / log_P
    return ZZ(n)


def test_smart_attack():
    """
    Test Smart's attack on a known anomalous curve.

    We use a small prime for testing. The curve y^2 = x^3 + x + 1
    over GF(43) has exactly 43 points, making it anomalous.
    """
    p = 43
    F = GF(p)
    E = EllipticCurve(F, [1, 1])

    # Verify the curve is anomalous
    order = E.order()
    assert order == p, (
        "Curve is not anomalous: #E(F_%d) = %d != %d" % (p, order, p)
    )

    # Pick a generator and compute a known multiple
    P = E.gens()[0]
    secret = 17
    Q = secret * P

    # Run the attack
    recovered = smart_attack(P, Q, p)
    assert recovered == secret, (
        "Attack failed: recovered %d, expected %d" % (recovered, secret)
    )

    print("Smart's attack test passed.")
    print("  Curve: y^2 = x^3 + x + 1 over GF(%d)" % p)
    print("  #E(F_p) = %d (anomalous)" % order)
    print("  Secret: %d" % secret)
    print("  Recovered: %d" % recovered)


if __name__ == "__main__":
    test_smart_attack()

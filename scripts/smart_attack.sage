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

    # Sage notation guide:
    #   ZZ = the ring of integers
    #   GF(p) = the finite field with p elements
    #   Qp(p, prec) = the p-adic numbers with `prec`
    #       digits of precision
    #   E.a_invariants() = the five coefficients
    #       [a1, a2, a3, a4, a6] of the general
    #       Weierstrass model y^2 + a1*x*y + a3*y
    #       = x^3 + a2*x^2 + a4*x + a6.
    #       For short Weierstrass (y^2 = x^3 + a*x + b),
    #       a1=a2=a3=0, a4=a, a6=b.
    #   Ep.lift_x(x, all=True) = find all points on Ep
    #       with the given x-coordinate
    #   pt.xy() = the (x, y) coordinates of a point

    # We try multiple random lifts. Perturbing the
    # a-invariants by random multiples of p gives a
    # curve over Q_p that reduces to E mod p, but is
    # not the canonical lift (where p*P_lift would be
    # zero). Some perturbations give incorrect results
    # due to the y-branch choice, so we verify and retry.
    for attempt in range(20):
        ainvs = E.a_invariants()
        lifted = [
            ZZ(t) + ZZ.random_element(0, p) * p
            for t in ainvs
        ]
        # Lifted curve over Q_p with 8 digits of precision
        Ep = EllipticCurve(Qp(p, 8), lifted)

        # Lift a point: solve the lifted curve equation
        # for the given x-coordinate, pick the y-root
        # that reduces to the original y mod p.
        def lift_point(R):
            x, y = R.xy()
            candidates = Ep.lift_x(ZZ(x), all=True)
            for pt in candidates:
                if GF(p)(pt.xy()[1]) == y:
                    return pt
            return None

        P_lift = lift_point(P)
        Q_lift = lift_point(Q)
        if P_lift is None or Q_lift is None:
            continue

        # Step 3: multiply by p to land in the formal group.
        # Since P has order p in E(F_p), p*P_lift reduces
        # to the identity mod p, so its coordinates are in
        # pZ_p.
        pP = p * P_lift
        pQ = p * Q_lift
        if pP.is_zero() or pQ.is_zero():
            continue

        # Step 4: extract the formal logarithm.
        # The local parameter t = -x/y maps the formal
        # group to pZ_p. To first order, log(t) = t.
        log_P = -(pP.xy()[0] / pP.xy()[1])
        log_Q = -(pQ.xy()[0] / pQ.xy()[1])

        # Step 5: discrete log is division in Q_p mod p.
        n = ZZ(log_Q / log_P) % p

        # Verify: retry with a fresh perturbation if wrong.
        if n * P == Q:
            return n

    raise ValueError(
        "Smart's attack failed after 20 attempts"
    )


def test_smart_attack():
    """
    Test Smart's attack on known anomalous curves.

    We verify the attack across several primes and secrets.
    A curve y^2 = x^3 + a*x + b over GF(p) is anomalous
    when #E(GF(p)) = p.
    """
    # (p, a, b) triples for anomalous curves
    # Small primes for fast sanity checks
    p_43 = 43
    p_97 = 97
    p_157 = 157
    # 256-bit prime (constructed via CM with j=0, trace=1)
    p_256 = Integer(
        "868440669279871465676782387565159309016"
        "92230158002800019079611962330850525581"
    )
    # 380-bit prime (constructed via CM with j=0, trace=1)
    p_380 = Integer(
        "184696904045599121307558000469423189711"
        "311277830306781316503193307190956665360"
        "5953071682581549594926623032013275521"
    )

    test_curves = [
        (p_43, 1, 14),
        (p_97, 1, 1),
        (p_157, 1, 57),
        (p_256, 0, 2),
        (p_380, 0, 13),
    ]

    for p, a, b in test_curves:
        F = GF(p)
        E = EllipticCurve(F, [a, b])

        order = E.order()
        assert order == p, (
            "Curve is not anomalous: "
            "#E(F_%d) = %d != %d" % (p, order, p)
        )

        P = E.gens()[0]

        for _ in range(5):
            secret = ZZ.random_element(1, p)
            Q = secret * P
            recovered = smart_attack(P, Q, p)
            assert recovered == secret, (
                "Attack failed on p=%d: "
                "recovered %d, expected %d"
                % (p, recovered, secret)
            )

        print(
            "PASS: y^2 = x^3 + %d*x + %d over GF(%d-bit)"
            % (a, b, p.nbits())
        )

    print("All Smart's attack tests passed.")


if __name__ == "__main__":
    test_smart_attack()

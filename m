From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH  1/2] dt-bindings: i2c: Document r8a7743/5 support
Date: Tue, 8 Aug 2017 13:50:06 +0200
Message-ID: <20170808115006.GC1674@katana>
References: <1502191231-8682-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502191231-8682-1-git-send-email-biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Chris Paterson <chris.paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 12:20:31PM +0100, Biju Das wrote:
> Document i2c Device Tree support for RZ/G1[ME]
> (also known as r8aA774[35]) SoCs. They are compatible with
> R-Car Gen2 SoC family.
>=20
> Signed-off-by: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>

Looks good to me, yet I'd like an ack from Simon who is currently
working on the generic fallback compatibles.

> ---
>  Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documen=
tation/devicetree/bindings/i2c/i2c-rcar.txt
> index 2b8bd33..cad39ae 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> @@ -2,6 +2,8 @@ I2C for R-Car platforms
> =20
>  Required properties:
>  - compatible:
> +	"renesas,i2c-r8a7743" if the device is a part of a R8A7743 SoC.
> +	"renesas,i2c-r8a7745" if the device is a part of a R8A7745 SoC.
>  	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
>  	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
>  	"renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
> @@ -12,7 +14,8 @@ Required properties:
>  	"renesas,i2c-r8a7795" if the device is a part of a R8A7795 SoC.
>  	"renesas,i2c-r8a7796" if the device is a part of a R8A7796 SoC.
>  	"renesas,rcar-gen1-i2c" for a generic R-Car Gen1 compatible device.
> -	"renesas,rcar-gen2-i2c" for a generic R-Car Gen2 compatible device.
> +	"renesas,rcar-gen2-i2c" for a generic R-Car Gen2 or RZ/G1 compatible
> +				device.
>  	"renesas,rcar-gen3-i2c" for a generic R-Car Gen3 compatible device.
>  	"renesas,i2c-rcar" (deprecated)
> =20
> --=20
> 1.9.1
>=20

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmJpW4ACgkQFA3kzBSg
KbZj7A//UhqZXNEcCAeQgrztrtSx5oOOtGbWw3mBgQtKrpbeYV7gyCxXVutESTG1
55Lp5923e+mjtGQ2HoMQYC++BGsilwIQnPVnmCxryVo0wq6/RozygXtrnSBzeSV+
HrpBazS5mvemi9gEb4CBgpihO3cTKGqWHWh2/n1eAcHiFNj3+FKLAvJDi1pyvY0L
3Cid/n+mOmwWhDdXVTm0Ca6p6TnXMx/dXRqqmsRQWNPwq33cTHi+/qgj/jcwFeWc
IpxsLOROaI/fl+VM6jwtdUhny8bG6ooVd1E5UHGRRBdwm3sdGceo0AI/bfHxa5UM
voY0TOkv/9Egpq4vXiBDHAxBB+rHJxL4jpFO0qe4ji+lESi3JIky5Lo8Lw15gO88
SUVBpMGsTHBg2ztlpfVc7yYieaF1trMbJgIIUd0mLBHb+sUNezfCZiOIRkoQhMOO
cPrXF7kW7HRGxVebIUsslvOupZDBUyDNWcZhd79uzZ2iDLakigUiTS7l8P1FeEps
Zeu0mikURbf7lKuzx7LdcEu+JwG/9JUpwFowftIQ5Yu3Sn3LYeLtGdKC8oiZ+FCF
McP4soo/6UGyTz7oZbEx/VML0XPWIAvEmtS0w6HDYypxhBDE2v4PeKJEsv9Wvucr
f+S6AjREq7cjjQ86PLZznOaIHTnRJxVcJ7ymWZRJEv//1znr1Ms=
=m1iM
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
